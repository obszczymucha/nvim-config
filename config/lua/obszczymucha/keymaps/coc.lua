local M = {}

function M.go_to_definition()
  vim.cmd( [[:execute "normal \<Plug>(coc-definition)"]] )
end

function M.show_documentation()
  vim.cmd( "call ShowDocumentation()" )
end

function M.rename()
  vim.cmd( [[:execute "normal \<Plug>(coc-rename)"]] )
end

function M.format_file()
  vim.cmd( "Format" )
end

function M.next_diagnostic()
  vim.cmd( [[:execute "normal \<Plug>(coc-diagnostic-next)"]] )
end

function M.prev_diagnostic()
  vim.cmd( [[:execute "normal \<Plug>(coc-diagnostic-prev)"]] )
end

function M.code_action()
  vim.cmd( [[:execute "normal \<Plug>(coc-codeaction)"]] )
end

function M.code_lens()
  vim.cmd( [[:execute "normal \<Plug>(coc-codelens-action)"]] )
end

function M.outline()
  vim.cmd( "CocList outline" )
end

return M
