--local q = require( "vim.treesitter.query" )
local debug = require( "obszczymucha.debug" ).debug
local clear = require( "obszczymucha.debug" ).clear

local M = {}

function M.opts( bufnr )
  local v = vim.bo[ bufnr ]
  local all_options = vim.api.nvim_get_all_options_info()
  local result = ""

  for key, val in pairs( all_options ) do
    if val.global_local == false and val.scope == "buf" then
      result = result .. "|" .. key .. "=" .. tostring( v[ key ] or "<not set>" )
    end
  end

  --debug( result )
end

local function find_buffer( name )
  for _, bufnr in ipairs( vim.api.nvim_list_bufs() ) do
    local bufname = vim.api.nvim_buf_get_name( bufnr )
    if bufname == name then return bufnr end
  end

  return nil
end

local function is_test( filename )
  if #filename < 8 then
    return false
  end

  return filename:sub( -8 ) == ".test.ts"
end

function M.run()
  local test_results = {}
  local full_filename
  local buffer = {}

  local function flush()
    for _, v in ipairs( buffer ) do
      debug( v )
    end

    buffer = {}
  end

  local function add_to_buffer( str )
    for token in string.gmatch( str, "[^\n]+" ) do
      table.insert( buffer, token )
    end
  end

  --local function collect_errors( _, data )
  --if not data then return end
  --for _, line in ipairs( data ) do
  --table.insert( buffer, line )
  --end
  --end

  local function collect_results( _, data )
    if not data then return end

    for _, line in ipairs( data ) do
      (function()
        if not line or line == "" then return end
        local json = vim.json.decode( line )

        if not json or not json[ "numTotalTests" ] then
          return
        end

        for _, test_result in ipairs( json[ "testResults" ] ) do
          if test_result.status == "failed" then
            table.insert( buffer, line )

            if not test_result.message then
              table.insert( buffer, "Test failed for unknown reason." )
            else
              add_to_buffer( test_result.message )
            end
          end

          full_filename = test_result.name

          for _, assertion_result in ipairs( test_result[ "assertionResults" ] ) do
            local status = assertion_result.status
            local location = assertion_result.location
            table.insert( test_results, { file_name = full_filename, status = status, location = location } )

            local details = assertion_result[ "failureDetails" ]
            local messages = assertion_result[ "failureMessages" ]

            if messages then
              local pattern = ":(%d+):(%d+)"

              for index, message in ipairs( messages ) do
                local detail = details[ index ] and details[ index ][ "matcherResult" ]
                local line_nr, col_nr = message:match( pattern )

                if line_nr and col_nr then
                  table.insert( test_results,
                    {
                      file_name = full_filename,
                      status = status,
                      location = { line = line_nr, column = col_nr },
                      details = detail
                    } )
                end
              end
            end
          end
        end
      end)()
    end

    flush()
  end

  local function create_buffer( bufname )
    local bufnr = vim.api.nvim_create_buf( false, false )
    vim.api.nvim_buf_set_option( bufnr, "filetype", "typescript" )
    vim.api.nvim_buf_set_name( bufnr, bufname )
    vim.api.nvim_buf_call( bufnr, vim.cmd.edit )

    return bufnr
  end

  local function get_buffers_from_results()
    local result = {}

    for _, test_result in ipairs( test_results ) do
      local bufname = test_result.file_name

      if not result[ bufname ] then
        result[ bufname ] = find_buffer( bufname ) or create_buffer( bufname )
      end
    end

    return result
  end

  local function toJsValue( value )
    if not value then return nil end

    if type( value ) == "table" then
      local result = "["
      local i = 0

      for _, v in ipairs( value ) do
        if i > 0 then
          result = result .. ","
        end

        result = result .. toJsValue( v )
      end

      result = result .. "]"

      return result
    end

    return value
  end

  local function print_tests()
    local namespace = vim.api.nvim_create_namespace( "JestTestResults" )
    local buffers = get_buffers_from_results()
    local all_errors = {}

    for _, result in ipairs( test_results ) do
      --debug( dump( result ) )
      if result.status == "failed" then
        local bufname = result.file_name
        local bufnr = buffers[ bufname ]
        all_errors[ bufnr ] = all_errors[ bufnr ] or {}

        local expected = toJsValue( result and result.details and result.details.expected or nil )
        local actual = toJsValue( result and result.details and result.details.actual or nil )
        local details = result.details and expected and actual
        local message = details and string.format( "Expected: %s  actual: %s", expected, actual ) or "Test failed"
        local severity = details and vim.diagnostic.severity.INFO or vim.diagnostic.severity.ERROR

        table.insert( all_errors[ bufnr ], {
          bufnr = bufnr,
          lnum = result.location.line - 1,
          col = 0,
          severity = severity,
          message = message,
          source = "jest",
          user_data = {}
        } )

        --debug( string.format( "FAILED: %s", bufname ) )
      end
    end

    for _, bufnr in pairs( buffers ) do
      if all_errors[ bufnr ] then
        vim.diagnostic.set( namespace, bufnr, all_errors[ bufnr ] )
      else
        vim.diagnostic.set( namespace, bufnr, {} )
      end
    end
  end

  local buf_filename = vim.fn.expand( "%:t" )
  local command = { "jest", "--json", "--testLocationInResults" }

  if is_test( buf_filename ) then
    table.insert( command, buf_filename )
  end

  clear()

  vim.fn.jobstart( command, {
    stdout_buffered = true,
    on_stdout = collect_results,
    --on_stderr = collect_errors,
    on_exit = print_tests
  } )
end

function M.setup()
  vim.api.nvim_create_user_command( "JestTest", function()
    vim.api.nvim_create_autocmd( "BufWritePost", {
      group = vim.api.nvim_create_augroup( "JestTest", { clear = true } ),
      pattern = { "*.ts" },
      callback = function() R( "obszczymucha.jest-test" ).run() end
    } )

    print( "JestTest hooked." )
  end, { nargs = 0 } )
end

M.setup()

return M
