local M = {}

-- I demonstrate how to query Treesitter.
-- Run me (:so %) and I'll find all the function names within this file.

function M.function_names()
  local bufnr = 0
  local lang = "lua"
  local parser = vim.treesitter.get_parser( bufnr, lang )
  local tree = parser:parse()[ 1 ]
  local root = tree:root()

  local query = vim.treesitter.query.parse( lang, [[
    (function_declaration
      name: (dot_index_expression) @function_name
    )
  ]] )

  for _, node in query:iter_captures( root, bufnr, 0, -1 ) do
    local text = vim.treesitter.get_node_text( node, bufnr )
    local start_row_index = node:range()
    local line_number = start_row_index + 1

    print( string.format( "Line %s: %s", line_number, vim.inspect( text ) ) )
  end
end

function M.function_names_detailed()
  local bufnr = 0
  local lang = "lua"
  local parser = vim.treesitter.get_parser( bufnr, lang )
  local tree = parser:parse()[ 1 ]
  local root = tree:root()
  local query = vim.treesitter.query.parse( lang, [[
    (function_declaration
      name: (dot_index_expression
        table: (identifier) @table_name
        field: (identifier) @field_name
      ) @function_name
    )
  ]] )

  local function get_line_number( node )
    local start_row_index = node:range()
    return start_row_index + 1
  end

  local function find_outer_node( node, node_name )
    if not node then return nil end
    local outer_node = node:parent()

    while outer_node and outer_node:type() ~= node_name do
      outer_node = outer_node:parent()
    end

    return outer_node
  end

  local line_numbers = {}
  local functions = {}

  for id, node in query:iter_captures( root, bufnr, 0, -1 ) do
    local text = vim.treesitter.get_node_text( node, bufnr )
    local capture_name = query.captures[ id ]

    if capture_name == "function_name" then
      local line_number = get_line_number( node )
      functions[ line_number ] = {}
      table.insert( line_numbers, line_number )
    else
      local outer_node = find_outer_node( node, "dot_index_expression" )

      if outer_node then
        local line_number = get_line_number( node )
        functions[ line_number ][ capture_name ] = text
      end
    end
  end

  -- Uncomment to see the table structure.
  -- print( vim.inspect( functions ) )

  for _, y in ipairs( line_numbers ) do
    print( string.format( "Line %s: %s.%s", y, functions[ y ].table_name, functions[ y ].field_name ) )
  end
end

M.function_names_detailed()

return M
