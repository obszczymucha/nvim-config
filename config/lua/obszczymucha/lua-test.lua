local q = require( "vim.treesitter.query" )

local M = {}

local test_bufnr = 11

local tests = {}

local function dump( value )
  print( vim.inspect( value ) )
end

function M.run_tests()

  vim.api.nvim_buf_set_lines( output_bufnr, 0, -1, false, {
    "Hello",
    "world"
  } )


  local language_tree = vim.treesitter.get_parser( test_bufnr, "lua" )
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[ 1 ]:root()
  local query = vim.treesitter.parse_query( "lua", [[
    (function_declaration
      name: [
        (method_index_expression
          table: (identifier) @table
          method: (identifier) @method
        )
        (dot_index_expression
          table: (identifier) @table2
          field: (identifier) @field
        )
      ] @ss (#offset! @ss)
    )
  ]] )

  tests = {}

  for _, match, metadata in query:iter_matches( root, test_bufnr, root:start(), root:end_() ) do
    local class_name = q.get_node_text( match[ 1 ] or match[ 3 ], test_bufnr )
    local test_name = q.get_node_text( match[ 2 ] or match[ 4 ], test_bufnr )
    local line = tonumber( string.format( "Line: %s", metadata[ 5 ].range[ 1 ] + 1 ) )
    tests[ string.format( "%s.%s", class_name, test_name ) ] = line
  end
end

function M.run( bufnr )
  if not bufnr then
    print( "chuj" )
    return
  end

  local function append_data( _, data )
    if not data then return end

    print( "xbufnr: " .. (bufnr or "chuj") )
    if not bufnr then return end
    vim.api.nvim_buf_set_lines( bufnr, -1, -1, false, data )
  end

  local command = { "./test.sh", "-T", "Spec", "-m", "should", "-v", "-o", "tap" }
  vim.api.nvim_buf_set_lines( bufnr, 0, -1, false, {} )
  vim.fn.jobstart( command, {
    stdout_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data
  } )
end

function M.setup()
  vim.api.nvim_create_user_command( "LuaTest", function( opts )
    vim.api.nvim_create_augroup( "AutoLuaTest", { clear = true } )
    vim.api.nvim_create_autocmd( "BufWrite", {
      group = "AutoLuaTest",
      pattern = { "*.lua" },
      callback = function() M.run( tonumber( opts.args ) ) end
    } )
  end, { nargs = 1 } )
end

M.setup()

return M
