local M = {}

local q = require( "vim.treesitter.query" )
local ts_utils = require( "nvim-treesitter.ts_utils" )

function M.show_function_help()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return end

  local expr = current_node

  while expr do
    if expr:type() == "function_call" then
      break
    end

    expr = expr:parent()
  end

  if not expr then return end

  local query = vim.treesitter.parse_query( "lua", [[
    name: (dot_index_expression
      field: (identifier) @field
    )
  ]] )

  local buf = vim.api.nvim_get_current_buf()

  for _, match, _ in query:iter_matches( expr, buf, expr:start(), expr:end_() + 1 ) do
    local node = match[ 1 ]
    local function_name = q.get_node_text( node, buf )
    vim.cmd( "h " .. function_name )
  end
end

return M
