--local q = require( "vim.treesitter.query" )
local debug = require( "obszczymucha.debug" ).debug
local clear = require( "obszczymucha.debug" ).clear
local common = require( "obszczymucha.common" )

local M = {}

--function M.run_tests()
--local language_tree = vim.treesitter.get_parser( test_bufnr, "lua" )
--local syntax_tree = language_tree:parse()
--local root = syntax_tree[ 1 ]:root()
--local query = vim.treesitter.parse_query( "lua", [[
--(function_declaration
--name: [
--(method_index_expression
--table: (identifier) @table
--method: (identifier) @method
--)
--(dot_index_expression
--table: (identifier) @table2
--field: (identifier) @field
--)
--] @ss (#offset! @ss)
--)
--]] )

--for _, match, metadata in query:iter_matches( root, test_bufnr, root:start(), root:end_() ) do
--local class_name = q.get_node_text( match[ 1 ] or match[ 3 ], test_bufnr )
--local test_name = q.get_node_text( match[ 2 ] or match[ 4 ], test_bufnr )
--local line = tonumber( string.format( "Line: %s", metadata[ 5 ].range[ 1 ] + 1 ) )
--tests[ string.format( "%s.%s", class_name, test_name ) ] = line
--end
--end

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
  local States = { Start = 0, Ok = 1, NotOk = 2 }
  local state = States.Start

  local function collect_results( _, data )
    if not data then return end
    debug( data )

    for _, line in ipairs( data ) do
      (function()
        for name in string.gmatch( line, "Testing (.+)..." ) do
          full_filename = name
          filename = common.get_filename( full_filename )
          return
        end

        for not_ok, class_name, test_name in string.gmatch( line, "(.*)ok%s+%d+%s+(.+)%.(.+)" ) do
          table.insert( test_results,
            { file_name = full_filename, ok = not_ok == "", class_name = class_name, test_name = test_name } )
          index = index + 1

          if not_ok == "" then
            state = States.Ok
          else
            state = States.NotOk
          end

          return
        end

        if state ~= States.NotOk then return end
        if test_results[ index ].error_line_number then return end

        local escaped_filename = common.escape_dots( filename )
        local pattern = "#%s*" .. escaped_filename .. ":(%d+):.*"

        for line_number in string.gmatch( line, pattern ) do
          test_results[ index ].error_line_number = tonumber( line_number )
          --test_results[ index ].expected = expected
          return
        end

        for actual in string.gmatch( line, ".+actual: \"(.+)\"" ) do
          test_results[ index ].actual = actual

          return
        end
      end)()
    end
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

  local function print_tests()
    local namespace = vim.api.nvim_create_namespace( "LuaTestResults" )
    local cwd = vim.fn.getcwd()
    local buffers = get_buffers_from_results()
    local all_errors = {}

    for _, result in ipairs( test_results ) do
      debug( dump( result ) )
      if not result.ok then
        local bufname = string.format( "%s/%s", cwd, result.file_name:sub( 3 ) )
        local bufnr = buffers[ bufname ]
        all_errors[ bufnr ] = all_errors[ bufnr ] or {}

        table.insert( all_errors[ bufnr ], {
          bufnr = bufnr,
          lnum = result.error_line_number - 1,
          col = 0,
          severity = vim.diagnostic.severity.ERROR,
          message = "Test failed",
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

    print( "LuaTest hooked." )
  end, { nargs = 0 } )
end

M.setup()

return M
