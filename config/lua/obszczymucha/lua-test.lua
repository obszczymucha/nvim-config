--local q = require( "vim.treesitter.query" )
local debug = require( "obszczymucha.debug" ).debug
local clear = require( "obszczymucha.debug" ).clear
local common = require( "obszczymucha.common" )

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

function M.run()
  local test_results = {}
  local index = 0
  local full_filename
  local filename
  local States = { Start = 0, Ok = 1, NotOk = 2, End = 3 }
  local state = States.Start
  local buffer = {}

  local function flush()
    for _, v in ipairs( buffer ) do
      debug( v )
    end

    buffer = {}
  end

  local function collect_results( _, data )
    if not data then return end

    for _, line in ipairs( data ) do
      (function()
        if state == States.NotOk then
          table.insert( buffer, line )
        end

        if #buffer > 0 and state == States.NotOk then
          flush()
        end

        if common.starts_with( line, "===" ) then
          state = States.End
          return
        end

        for name in string.gmatch( line, "Testing (.+)%.%.%." ) do
          full_filename = name
          filename = common.get_filename( full_filename )
          state = States.Start
          return
        end

        if state == States.End then return end

        for not_ok, class_name, test_name in string.gmatch( line, "(.*)ok%s+%d+%s+(.+)%.(.+)" ) do
          table.insert( test_results,
            { file_name = full_filename, ok = not_ok == "", class_name = class_name, test_name = test_name } )
          index = index + 1

          if not_ok == "" then
            state = States.Ok
          else
            table.insert( buffer, line )
            state = States.NotOk
          end

          return
        end

        local escaped_filename = common.escape_filename( filename )
        local pattern = "#*%s*lua: " .. escaped_filename .. ":(%d+): (.*)"

        for line_number, error_message in string.gmatch( line, pattern ) do
          table.insert( test_results,
            {
              file_name = full_filename,
              ok = false,
              error_line_number = tonumber( line_number ),
              critical_error =
                  common.remove_trailing( error_message, ":" )
            } )
          index = index + 1

          table.insert( buffer, line )
          state = States.NotOk

          return
        end

        if state ~= States.NotOk then return end

        pattern = "#*%s*" .. escaped_filename .. ":(%d+):%s*expected: (.*), actual: (.*)"

        for line_number, expected, actual in string.gmatch( line, pattern ) do
          test_results[ index ].error_line_number = tonumber( line_number )
          test_results[ index ].expected = expected
          test_results[ index ].actual = actual
          return
        end

        pattern = "#*%s*" .. escaped_filename .. ":(%d+):%s*expected: ?(.*)"

        for line_number, expected in string.gmatch( line, pattern ) do
          test_results[ index ].error_line_number = tonumber( line_number )
          test_results[ index ].expected = expected
          return
        end

        for actual in string.gmatch( line, ".+actual: (.+)" ) do
          test_results[ index ].actual = actual

          return
        end
      end)()
    end

    flush()
  end

  local function create_buffer( bufname )
    local bufnr = vim.api.nvim_create_buf( false, false )
    vim.api.nvim_buf_set_option( bufnr, "filetype", "lua" )
    vim.api.nvim_buf_set_name( bufnr, bufname )
    vim.api.nvim_buf_call( bufnr, vim.cmd.edit )

    return bufnr
  end

  local function get_buffers_from_results()
    local cwd = vim.fn.getcwd()
    local result = {}

    for _, test_result in ipairs( test_results ) do
      local bufname = string.format( "%s/%s", cwd, test_result.file_name:sub( 3 ) )

      if not result[ bufname ] then
        result[ bufname ] = find_buffer( bufname ) or create_buffer( bufname )
      end
    end

    return result
  end

  local function mark_test_as_failed( all_errors, bufnr, class_name, test_name )
    local language_tree = vim.treesitter.get_parser( bufnr, "lua" )
    local syntax_tree = language_tree:parse()
    local root = syntax_tree[ 1 ]:root()
    local query = vim.treesitter.query.parse( "lua", [[
      (function_declaration
        name: (method_index_expression
          table: (identifier) @class_name
          method: (identifier) @test_name) @ss (#offset! @ss)
      )
    ]] )

    for _, match, metadata in query:iter_matches( root, bufnr, root:start(), root:end_(), { all = true } ) do
      local classname = vim.treesitter.get_node_text( match[ 1 ][ 1 ], bufnr )
      local test = vim.treesitter.get_node_text( match[ 2 ][ 1 ], bufnr )
      local line = tonumber( metadata[ 3 ].range[ 1 ] + 1 )
      -- debug( string.format( "classname: %s, test: %s, line: %s", classname, test, line ) )

      if class_name == classname and test_name == test then
        table.insert( all_errors[ bufnr ], {
          bufnr = bufnr,
          lnum = line - 1,
          col = 0,
          severity = vim.diagnostic.severity.ERROR,
          message = "Test failed",
          source = "lua",
          user_data = {}
        } )
      end
    end
  end

  local function print_tests()
    local namespace = vim.api.nvim_create_namespace( "LuaTestResults" )
    vim.diagnostic.reset( namespace )

    local cwd = vim.fn.getcwd()
    local buffers = get_buffers_from_results()
    local all_errors = {}

    for _, result in ipairs( test_results ) do
      if not result.ok then
        local bufname = string.format( "%s/%s", cwd, result.file_name:sub( 3 ) )
        local bufnr = buffers[ bufname ]
        all_errors[ bufnr ] = all_errors[ bufnr ] or {}
        local details = result.expected and result.actual
        local severity = details and vim.diagnostic.severity.INFO or vim.diagnostic.severity.ERROR
        local message = details and string.format( "Was: %s  Expected: %s", result.actual, result.expected ) or
            string.format( "Test failed%s",
              result.critical_error and string.format( " (%s)", result.critical_error ) or "" )

        if result.class_name and result.test_name then
          mark_test_as_failed( all_errors, bufnr, result.class_name, result.test_name )
        end

        table.insert( all_errors[ bufnr ], {
          bufnr = bufnr,
          lnum = result.error_line_number - 1,
          col = 0,
          severity = severity,
          message = message,
          source = "luaunit",
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

  local command = { "./test.sh", "-T", "Spec", "-m", "should", "-v", "-o", "tap" }
  clear()

  vim.fn.jobstart( command, {
    stdout_buffered = true,
    on_stdout = collect_results,
    on_stderr = collect_results,
    on_exit = print_tests
  } )
end

function M.setup()
  vim.api.nvim_create_user_command( "LuaTest", function()
    vim.api.nvim_create_autocmd( "BufWritePost", {
      group = vim.api.nvim_create_augroup( "LuaTest", { clear = true } ),
      pattern = { "*.lua" },
      callback = function() R( "obszczymucha.lua-test" ).run() end
    } )

    vim.notify( "LuaTest hooked." )
  end, { nargs = 0 } )
end

M.setup()

return M
