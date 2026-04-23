local M = {}

function M.show_function_help()
  local current_node = vim.treesitter.get_node()
  if not current_node then return end

  local expr = current_node

  while expr do
    if expr:type() == "function_call" then
      break
    end

    expr = expr:parent()
  end

  if not expr then return end

  local query = vim.treesitter.query.parse( "lua", [[
    name: (dot_index_expression
      field: (identifier) @field
    )
  ]] )

  local buf = vim.api.nvim_get_current_buf()

  for _, match, _ in query:iter_matches( expr, buf, expr:start(), expr:end_() + 1 ) do
    local nodes = match[ 1 ]
    local node = type( nodes ) == "table" and nodes[ 1 ] or nodes
    local function_name = vim.treesitter.get_node_text( node, buf )
    vim.cmd( "h " .. function_name )
  end
end

return M
