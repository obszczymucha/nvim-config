local M = {}

function M.go_to_definition()
  vim.cmd( [[:execute "normal \<Plug>(coc-definition)"]] )
end

return M

