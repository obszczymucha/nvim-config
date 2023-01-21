local q = require( "vim.treesitter.query" )
local output_bufnr = 5
local test_bufnr = 11

local tests = {}

local function dump( value )
  print( vim.inspect( value ) )
end

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
  ] @ss (#offset! @ss))
]] )

tests = {}

for _, match, metadata in query:iter_matches( root, test_bufnr, root:start(), root:end_() ) do
  local class_name = q.get_node_text( match[ 1 ] or match[ 3 ], test_bufnr )
  local test_name = q.get_node_text( match[ 2 ] or match[ 4 ], test_bufnr )
  local line = tonumber( string.format( "Line: %s", metadata[ 5 ].range[ 1 ] + 1 ) )
  tests[ string.format( "%s.%s", class_name, test_name ) ] = line
end
