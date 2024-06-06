-- local q = require( "vim.treesitter.query" )
-- local debug = require( "obszczymucha.debug" ).debug
local clear = require( "obszczymucha.debug" ).clear
local ts_rust_utils = require( "obszczymucha.treesitter.rust" )

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

  -- A map with key = filename, value = number of failures
  local test_failures = {}

  local function collect_results( _, data )
    if not data then return end

    local captures = {
      last_entry_inserted = true
    }

    local parsing_status = {}
    local Details = { Name = 1, Line = 2 }

    local function insert_last_entry()
      local entry = {
        module = captures.module_name,
        test_name = captures.test_name,
        file_name = captures.file_name,
        case_name = captures.case_name,
        status = "failed",
        location = { line = captures.line_nr, column = captures.col_nr },
        actual = captures.actual,
        expected = captures.right,
        critical_error = (not captures.actual or not captures.right) and captures.critical_error,
      }

      table.insert( test_results, entry )
      captures.last_entry_inserted = true
    end

    for line_number, line in ipairs( data ) do
      (function()
        ---@diagnostic disable-next-line: unused-local
        local qualified_name, status = line:match( "test (.-) %.%.%. (.+)" )

        if qualified_name and status then
          local count = status == "ok" and 0 or 1
          test_failures[ qualified_name ] = test_failures[ qualified_name ] or count
          return
        end

        local short_name, module_name, test_name, case_name = line:match(
          "---- ([^:]+)::([^:]+)::([^:%s]+):*(%S*) stdout ----" )

        if short_name and module_name and test_name then
          if captures.last_entry_inserted == false then
            insert_last_entry()
          end

          parsing_status = {}

          captures = {
            short_name = short_name,
            module_name = module_name,
            test_name = test_name,
            case_name = case_name,
            last_entry_inserted = false
          }

          parsing_status[ Details.Name ] = line_number

          return
        end

        local file_name, line_nr, col_nr = line:match( "thread '.+' panicked at (.+):(.+):(.+):" )

        if file_name and line_nr and col_nr then
          captures.file_name = file_name
          captures.line_nr = line_nr
          captures.col_nr = col_nr

          parsing_status[ Details.Line ] = line_number

          return
        end

        local left = line:match( "  left: (.+)" )

        if left then
          captures.actual = left
          return
        end

        local right = line:match( " right: (.+)" )

        if right then
          captures.right = right
          return
        end

        local last_line_nr = parsing_status[ Details.Line ]

        if last_line_nr and last_line_nr + 1 == line_number then
          captures.critical_error = line
        end
      end)()
    end

    if captures.last_entry_inserted == false then insert_last_entry() end
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

  local function format_case( case_name )
    return string.format( "Test failed%s", case_name and string.format( " (%s)", case_name ) or "" )
  end

  local function mark_test_as_failed( all_errors, bufnr, module_name, test_name, case_name )
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
      -- debug( string.format( "modname: %s, test: %s, line: %s", modname, test, line ) )

      if module_name == modname and test_name == test then
        table.insert( all_errors[ bufnr ], {
          bufnr = bufnr,
          lnum = line - 1,
          col = 0,
          severity = vim.diagnostic.severity.ERROR,
          message = format_case( case_name ),
          source = "rust",
          user_data = {}
        } )
      end
    end
  end

  local function mark_case_line( all_errors, bufnr, test_name, case_name )
    local case_number = tonumber( case_name:match( "case_(%d+)" ) ) - 1

    local line_numbers = ts_rust_utils.find_case_line_numbers( bufnr, test_name )
    print( case_number )
    print( vim.inspect( line_numbers ) )
    local line_number = line_numbers[ case_number ]

    if line_number then
      table.insert( all_errors[ bufnr ], {
        bufnr = 0,
        lnum = line_number + 1,
        col = 0,
        severity = vim.diagnostic.severity.INFO,
        message = "This case failed",
        source = "rust",
        user_data = {}
      } )
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
    vim.diagnostic.reset( namespace )

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
            format_case( result.case_name )
        local severity = details and vim.diagnostic.severity.INFO or vim.diagnostic.severity.ERROR

        if result.module and result.test_name then
          mark_test_as_failed( all_errors, bufnr, result.module, result.test_name, result.case_name )
        end

        if result.case_name then
          mark_case_line( all_errors, bufnr, result.test_name, result.case_name )
        end

        if not result.critical_error then
          table.insert( all_errors[ bufnr ], {
            bufnr = bufnr,
            lnum = result.location.line - 1,
            col = 0,
            severity = severity,
            message = message,
            source = "rust",
            user_data = {}
          } )
        else
          table.insert( all_errors[ bufnr ], {
            bufnr = bufnr,
            lnum = result.location.line - 1,
            col = 0,
            severity = vim.diagnostic.severity.ERROR,
            message = result.critical_error,
            source = "rust",
            user_data = {}
          } )
        end

        -- debug( string.format( "FAILED: %s", bufname ) )
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

  local command = { "cargo", "test", "--target", "x86_64-pc-windows-gnu" }
  clear()

  vim.fn.jobstart( command, {
    stdout_buffered = false,
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
