local q = require( "vim.treesitter.query" )

local M = {}

local test_bufnr = 11

local function dump( value )
  return vim.inspect( value )
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

  for _, match, metadata in query:iter_matches( root, test_bufnr, root:start(), root:end_() ) do
    local class_name = q.get_node_text( match[ 1 ] or match[ 3 ], test_bufnr )
    local test_name = q.get_node_text( match[ 2 ] or match[ 4 ], test_bufnr )
    local line = tonumber( string.format( "Line: %s", metadata[ 5 ].range[ 1 ] + 1 ) )
    tests[ string.format( "%s.%s", class_name, test_name ) ] = line
  end
end

local function dump2( o )
  local entries = 0

  if type( o ) == 'table' then
    local s = '{'
    for k, v in pairs( o ) do
      if (entries == 0) then s = s .. " " end
      if type( k ) ~= 'number' then k = '"' .. k .. '"' end
      if (entries > 0) then s = s .. ", " end
      s = s .. '[' .. k .. '] = ' .. dump2( v )
      entries = entries + 1
    end

    if (entries > 0) then s = s .. " " end
    return s .. '}'
  else
    return tostring( o )
  end
end

function M.run()
  local buf = require( "obszczymucha.debug" ).get_buf()

  if not buf then return end
  local tests = {}

  local function append_data( _, data )
    if not data then return end

    vim.api.nvim_buf_set_lines( buf, -1, -1, false, { dump( data ) } )
    --for class_name, test_name in string.gmatch( data, "ok%s+%d+%s+(%w)" ) do
    --local text = string.format( "Class: %s, test: %s", class_name, test_name )
    --vim.api.nvim_buf_set_lines( bufnr, -1, -1, false, text )
    --end
  end

  local command = { "./test.sh", "-T", "Spec", "-m", "should", "-v", "-o", "tap" }
  vim.api.nvim_buf_set_lines( buf, 0, -1, false, {} )
  vim.fn.jobstart( command, {
    stdout_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data
  } )
end

function M.setup()
  --vim.api.nvim_create_user_command( "LuaTest", function( opts )
  --vim.api.nvim_create_augroup( "AutoLuaTest", { clear = true } )
  --vim.api.nvim_create_autocmd( "BufWritePost", {
  --group = "AutoLuaTest",
  --pattern = { "*.lua" },
  --callback = function() R( "obszczymucha.lua-test" ).run( tonumber( opts.args ) ) end
  --} )
  --end, { nargs = 1 } )
end

M.setup()

return M
