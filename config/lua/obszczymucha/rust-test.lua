-- local q = require( "vim.treesitter.query" )
-- local debug = require( "obszczymucha.debug" ).debug
local clear = require( "obszczymucha.debug" ).clear

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
  local captures = {}
  -- A map with key = filename, value = number of failures
  local test_failures = {}

  local function collect_results( _, data )
    if not data then return end

    for _, line in ipairs( data ) do
      (function()
        ---@diagnostic disable-next-line: unused-local
        local qualified_name, status = line:match( "test (.-) %.%.%. (.+)" )

        if qualified_name and status then
          local count = status == "ok" and 0 or 1
          test_failures[ qualified_name ] = test_failures[ qualified_name ] or count
          return
        end

        local short_name, module_name, test_name = line:match( "---- (%S+)::(%S+)::(%S+) stdout ----" )
        if short_name and module_name and test_name then
          captures = {
            short_name = short_name,
            module_name = module_name,
            test_name = test_name
          }

          return
        end

        local file_name, line_nr, col_nr = line:match( "thread '.+' panicked at (.+):(.+):(.+):" )
        if file_name and line_nr and col_nr then
          captures.file_name = file_name
          captures.line_nr = line_nr
          captures.col_nr = col_nr

          return
        end

        local left = line:match( "  left: (.+)" )
        if left then
          captures.actual = left
          return
        end

        local right = line:match( " right: (.+)" )

        if right then
          table.insert( test_results,
            {
              module = captures.module_name,
              test_name = captures.test_name,
              file_name = captures.file_name,
              status = "failed",
              location = { line = captures.line_nr, column = captures.col_nr },
              actual = captures.actual,
              expected = right
            } )
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
      local bufname = string.format( "%s/%s", cwd, test_result.file_name )

      if not result[ bufname ] then
        result[ bufname ] = find_buffer( bufname ) or create_buffer( bufname )
      end
    end

    return result
  end

  local function mark_test_as_failed( all_errors, bufnr, module_name, test_name )
    local language_tree = vim.treesitter.get_parser( bufnr, "rust" )
    local syntax_tree = language_tree:parse()
    local root = syntax_tree[ 1 ]:root()
    local query = vim.treesitter.query.parse( "rust", [[
      (mod_item
        name: (identifier) @module
        (declaration_list
          (function_item name: (identifier) @function_name) @ss (#offset! @ss)
        )
      )
    ]] )

    for _, match, metadata in query:iter_matches( root, bufnr, root:start(), root:end_(), { all = true } ) do
      local modname = vim.treesitter.get_node_text( match[ 1 ][ 1 ], bufnr )
      local test = vim.treesitter.get_node_text( match[ 2 ][ 1 ], bufnr )
      local line = tonumber( metadata[ 3 ].range[ 1 ] + 1 )

      if module_name == modname and test_name == test then
        table.insert( all_errors[ bufnr ], {
          bufnr = bufnr,
          lnum = line - 1,
          col = 0,
          severity = vim.diagnostic.severity.ERROR,
          message = "Test failed",
          source = "rust",
          user_data = {}
        } )
      end
    end
  end

  local function print_tests()
    for name, count in pairs( test_failures ) do
      if count == 0 then
        table.insert( test_results,
          {
            test_name = name,
            status = "ok"
          } )
      end
    end

    local namespace = vim.api.nvim_create_namespace( "RustTestResults" )
    local cwd = vim.fn.getcwd()
    local buffers = get_buffers_from_results()
    local all_errors = {}

    for _, result in ipairs( test_results ) do
      -- debug( dump( result ) )

      if result.status == "failed" then
        local bufname = string.format( "%s/%s", cwd, result.file_name )
        local bufnr = buffers[ bufname ]
        all_errors[ bufnr ] = all_errors[ bufnr ] or {}
        local details = result.expected and result.actual
        local message = details and string.format( "Was: %s  Expected: %s", result.actual, result.expected ) or
            "Test failed"
        local severity = details and vim.diagnostic.severity.INFO or vim.diagnostic.severity.ERROR

        if result.module and result.test_name then
          mark_test_as_failed( all_errors, bufnr, result.module, result.test_name )
        end

        table.insert( all_errors[ bufnr ], {
          bufnr = bufnr,
          lnum = result.location.line - 1,
          col = 0,
          severity = severity,
          message = message,
          source = "rust",
          user_data = {}
        } )

        -- debug( string.format( "FAILED: %s", bufname ) )
      end
    end

    vim.diagnostic.reset( namespace )

    for _, bufnr in pairs( buffers ) do
      if all_errors[ bufnr ] then
        vim.diagnostic.set( namespace, bufnr, all_errors[ bufnr ] )
      else
        vim.diagnostic.set( namespace, bufnr, {} )
      end
    end
  end

  local command = { "cargo", "test", "--target", "x86_64-pc-windows-gnu" }
  clear()

  vim.fn.jobstart( command, {
    stdout_buffered = true,
    on_stdout = collect_results,
    on_stderr = collect_results,
    on_exit = print_tests
  } )
end

function M.setup()
  vim.api.nvim_create_user_command( "RustTestHook", function()
    vim.api.nvim_create_autocmd( "BufWritePost", {
      group = vim.api.nvim_create_augroup( "RustTestHook", { clear = true } ),
      pattern = { "*.rs" },
      callback = function() R( "obszczymucha.rust-test" ).run() end
    } )

    vim.notify( "RustTest hooked." )
  end, { nargs = 0 } )
end

M.setup()

return M
