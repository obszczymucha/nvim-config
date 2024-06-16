--local q = require( "vim.treesitter.query" )
-- local debug = require( "obszczymucha.debug" ).debug
local clear = require( "obszczymucha.debug" ).clear
---@diagnostic disable-next-line: different-requires
local common = require( "obszczymucha.common" )
local test_utils = require( "obszczymucha.test-utils" )

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
  local function collect_results( data )
    local test_results = {}
    if not data then return test_results end

    local captures = {
      last_entry_inserted = true
    }

    local function insert_last_entry()
      if not captures.full_filename then return end

      local entry = {
        file_name = captures.full_filename,
        source_file_name = captures.source_file_name,
        ok = captures.ok,
        error_line_number = captures.error_line_number,
        critical_error = captures.critical_error,
        expected = captures.expected,
        actual = captures.actual,
        class_name = captures.class_name,
        test_name = captures.test_name,
        error_message = captures.error_message
      }

      table.insert( test_results, entry )
      captures.last_entry_inserted = true
    end

    for line in string.gmatch( data, "[^\r\n]+" ) do
      (function()
        if not line or line == "" then return end

        for name in string.gmatch( line, "Testing (.+)%.%.%." ) do
          if captures.last_entry_inserted == false then
            insert_last_entry()
          end

          local filename = common.get_filename( name )

          captures = {
            full_filename = name,
            filename = filename,
            escaped_filename = common.escape_filename( filename ),
            last_entry_inserted = true
          }

          return
        end

        -- not ok 1        ItemUtilsSpec.should_get_item_id_from_item_link
        for not_ok, class_name, test_name in string.gmatch( line, "(.*)ok%s+%d+%s+(.+)%.(.+)" ) do
          if captures.last_entry_inserted == false then
            insert_last_entry()
          end

          captures.last_entry_inserted = false
          captures.critical_error = nil
          captures.error_line_number = nil
          captures.error_message = nil
          captures.expected = nil
          captures.actual = nil
          captures.ok = not_ok == ""
          captures.class_name = class_name
          captures.test_name = test_name
          captures.stack_traceback = nil
          captures.source_file_name = nil
          return
        end

        if not captures.escaped_filename then return end

        local pattern = "#*%s*stack traceback:"

        if string.match( line, pattern ) then captures.stack_traceback = true end
        if captures.stack_traceback then return end

        -- lua: Item_test.lua:4: module 'src/framework/Item' not found:
        pattern = "#*%s*lua: " .. captures.escaped_filename .. ":(%d+): (.*)"

        for line_number, error_message in string.gmatch( line, pattern ) do
          captures.critical_error = common.remove_trailing( error_message, ":" )
          captures.error_line_number = tonumber( line_number )
          captures.last_entry_inserted = false
          return
        end

        pattern = "#*%s*" .. captures.escaped_filename .. ":(%d+):%s*expected: (.*), actual: (.*)"

        for line_number, expected, actual in string.gmatch( line, pattern ) do
          captures.error_line_number = tonumber( line_number )
          captures.expected = expected
          captures.actual = actual
          return
        end

        pattern = "#*%s*" .. captures.escaped_filename .. ":(%d+):%s*expected: ?(.*)"

        for line_number, expected in string.gmatch( line, pattern ) do
          captures.error_line_number = tonumber( line_number )
          captures.expected = expected
          return
        end

        for actual in string.gmatch( line, "#*%s*actual: (.+)" ) do
          captures.actual = actual
          return
        end

        -- #   ItemUtils_test.lua:13: attempt to call a nil value (field 'get_item_id')
        -- #       ItemUtils_test.lua:13: in upvalue 'ItemUtilsSpec.should_get_item_id_from_item_link'
        pattern = "#*%s*" .. captures.escaped_filename .. ":(%d+): (.*)"

        for line_number, error_message in string.gmatch( line, pattern ) do
          captures.error_message = common.remove_trailing( error_message, ":" )
          captures.error_line_number = tonumber( line_number )
          captures.last_entry_inserted = false
          return
        end

        pattern = "#*%s*lua: (.*):(%d+): (.*)"

        for filename, line_number, message in string.gmatch( line, pattern ) do
          captures.source_file_name = test_utils.resolve_source_filename( captures.full_filename, filename )
          captures.critical_error = message
          captures.error_line_number = line_number
          captures.last_entry_inserted = false
          return
        end

        pattern = "#*%s*(.*):(%d+): (.*)"

        for filename, line_number, message in string.gmatch( line, pattern ) do
          captures.source_file_name = test_utils.resolve_source_filename( captures.full_filename, filename )
          captures.critical_error = message
          captures.error_line_number = line_number
          captures.last_entry_inserted = false
          return
        end
      end)()
    end

    if captures.last_entry_inserted == false then insert_last_entry() end

    return test_results
  end

  local function create_buffer( bufname )
    local bufnr = vim.api.nvim_create_buf( false, false )
    vim.api.nvim_set_option_value( "filetype", "lua", { buf = bufnr } )
    vim.api.nvim_buf_set_name( bufnr, bufname )
    vim.api.nvim_buf_call( bufnr, vim.cmd.edit )

    return bufnr
  end

  local function get_buffers_from_results( test_results )
    local cwd = vim.fn.getcwd()
    local result = {}

    local function find_or_create_buffer( file_name )
      local bufname = string.format( "%s/%s", cwd, file_name )

      if not result[ bufname ] then
        result[ bufname ] = find_buffer( bufname ) or create_buffer( bufname )
      end
    end

    for _, test_result in ipairs( test_results ) do
      if test_result.source_file_name then find_or_create_buffer( test_result.source_file_name ) end
      find_or_create_buffer( test_result.file_name:sub( 3 ) )
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

  local function print_tests( test_results )
    local namespace = vim.api.nvim_create_namespace( "LuaTestResults" )
    vim.diagnostic.reset( namespace )

    local cwd = vim.fn.getcwd()
    local buffers = get_buffers_from_results( test_results )
    local all_errors = {}

    for _, result in ipairs( test_results ) do
      if not result.ok then
        local bufname = string.format( "%s/%s", cwd, result.source_file_name or result.file_name:sub( 3 ) )
        local bufnr = buffers[ bufname ]
        all_errors[ bufnr ] = all_errors[ bufnr ] or {}
        local details = result.expected and result.actual
        local severity = (details or result.error_message) and vim.diagnostic.severity.INFO or
            vim.diagnostic.severity.ERROR
        local message = details and string.format( "Was: %s  Expected: %s", result.actual, result.expected ) or
            result.error_message or
            string.format( "Test failed%s",
              result.critical_error and string.format( " (%s)", result.critical_error ) or "" )

        if result.class_name and result.test_name then
          mark_test_as_failed( all_errors, bufnr, result.class_name, result.test_name )
        end

        if result.source_file_name and result.file_name then
          ---@diagnostic disable-next-line: redefined-local
          local bufname = string.format( "%s/%s", cwd, result.file_name:sub( 3 ) )
          ---@diagnostic disable-next-line: redefined-local
          local bufnr = buffers[ bufname ]
          all_errors[ bufnr ] = all_errors[ bufnr ] or {}
          mark_test_as_failed( all_errors, bufnr, result.class_name, result.test_name )
        end

        if result.error_line_number then
          table.insert( all_errors[ bufnr ], {
            bufnr = bufnr,
            lnum = result.error_line_number - 1,
            col = 0,
            severity = severity,
            message = message,
            source = "luaunit",
            user_data = {}
          } )
        end

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

  local on_exit = function( obj )
    vim.schedule( function()
      local results = collect_results( obj.stderr )
      print_tests( results )
    end )
  end

  vim.system( command, { text = true }, on_exit )

  -- This is the old method of running it and it completely fucks everything up.
  -- I'm guessing there's some race condition going on or file buffering, or whatever.
  -- vim.fn.jobstart( command, {
  --   stdout_buffered = true,
  --   on_stdout = collect_results,
  --   on_stderr = collect_results,
  --   on_exit = print_tests
  -- } )
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
