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
  local module
  local testname
  local expected
  local buffer = {}
  -- A map with key = filename, value = number of failures
  local test_failures = {}

  local function collect_results( _, data )
    if not data then return end

    for _, line in ipairs( data ) do
      (function()
        local fname = line:match( "     Running unittests (.+) %(" )

        if fname then
          test_failures[ fname ] = test_failures[ fname ] or 0
          return
        end

        local mod, tname = line:match( "---- (%S+)::(%S+) stdout ----" )

        if mod and tname then
          module = mod
          testname = tname
          return
        end

        local left = line:match( "  left: `(.+)`," )

        if left then
          expected = left
          return
        end

        local actual, filename, line_nr, col_nr = line:match( " right: `(.+)`', (.+):(.+):(.+)" )

        if actual and filename and line and col_nr then
          test_failures[ filename ] = test_failures[ filename ] or 0
          test_failures[ filename ] = test_failures[ filename ] + 1

          table.insert( test_results,
            {
              module = module,
              test_name = testname,
              file_name = filename,
              status = "failed",
              location = { line = line_nr, column = col_nr },
              expected = expected,
              actual = actual
            } )

          module = nil
          testname = nil
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

    for _, match, metadata in query:iter_matches( root, bufnr, root:start(), root:end_() ) do
      local modname = vim.treesitter.get_node_text( match[ 1 ], bufnr )
      local test = vim.treesitter.get_node_text( match[ 2 ], bufnr )
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
            file_name = name,
            status = "ok"
          } )
      end
    end

    local namespace = vim.api.nvim_create_namespace( "RustTestResults" )
    local cwd = vim.fn.getcwd()
    local buffers = get_buffers_from_results()
    local all_errors = {}

    for _, result in ipairs( test_results ) do
      --debug( dump( result ) )
      if result.status == "failed" then
        local bufname = string.format( "%s/%s", cwd, result.file_name )
        local bufnr = buffers[ bufname ]
        all_errors[ bufnr ] = all_errors[ bufnr ] or {}
        local details = result.expected and result.actual
        local message = details and string.format( "Expected: %s  actual: %s", result.expected, result.actual ) or
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

  local command = { "cargo", "test" }
  clear()

  vim.fn.jobstart( command, {
    stdout_buffered = true,
    on_stdout = collect_results,
    on_stderr = collect_results,
    on_exit = print_tests
  } )
end

function M.setup()
  vim.api.nvim_create_user_command( "RustTest", function()
    vim.api.nvim_create_autocmd( "BufWritePost", {
      group = vim.api.nvim_create_augroup( "RustTest", { clear = true } ),
      pattern = { "*.rs" },
      callback = function() R( "obszczymucha.rust-test" ).run() end
    } )

    vim.notify( "RustTest hooked." )
  end, { nargs = 0 } )
end

M.setup()

return M
