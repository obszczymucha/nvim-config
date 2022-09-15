local M = {}

function M.go_to_definition()
  vim.cmd( "lua vim.lsp.buf.definition()" )
end

return M

