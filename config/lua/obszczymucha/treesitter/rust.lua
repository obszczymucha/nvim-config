local M = {}

function M.find_case_line_numbers( bufnr, function_name )
  local lang = "rust"
  local parser = vim.treesitter.get_parser( bufnr, lang )
  local tree = parser:parse()[ 1 ]
  local root = tree:root()
  local query = vim.treesitter.query.parse( lang, [[
    (
      (attribute_item
        (attribute
          (identifier) @rstest_attribute
          (#eq? @rstest_attribute "rstest")
        )
      )
      (attribute_item
        (attribute
          (identifier) @case_attribute
          (#eq? @case_attribute "case")
          arguments: (token_tree)
        )
      )
      (function_item
        name: (identifier) @function_name
        (#eq? @function_name "]] .. function_name .. [[")
      )
    )
  ]] )

  local function get_line_number( node )
    local start_row_index = node:range()
    return start_row_index + 1
  end

  local line_numbers = {}

  for id, node in query:iter_captures( root, bufnr, 0, -1 ) do
    local capture_name = query.captures[ id ]

    if capture_name == "case_attribute" then
      local line_number = get_line_number( node )
      table.insert( line_numbers, line_number )
    end
  end

  return line_numbers
end

return M
