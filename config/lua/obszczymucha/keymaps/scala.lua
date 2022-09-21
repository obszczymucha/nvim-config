local M = {}

function M.go_to_definition()
  vim.cmd( "lua vim.lsp.buf.definition()" )
end

function M.show_documentation()
  --vim.cmd( "lua vim.lsp.buf.hover()" )
  vim.cmd( "Lspsaga hover_doc" )
end

function M.rename()
  --vim.cmd( "lua vim.lsp.buf.rename()" )
  vim.cmd( "Lspsaga rename" )
end

function M.format_file()
  vim.cmd( "lua vim.lsp.buf.formatting()")
end

function M.next_diagnostic()
  vim.cmd( "lua vim.diagnostic.goto_next()")
end

function M.prev_diagnostic()
  vim.cmd( "lua vim.diagnostic.goto_prev()")
end

function M.code_action()
  --vim.cmd( "lua vim.lsp.buf.code_action()" )
  vim.cmd( "Lspsaga code_action" )
end

function M.code_lens()
  vim.cmd( "lua vim.lsp.codelens.run()" )
end

return M

