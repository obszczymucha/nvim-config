local M = {}

function M.fast_wrap()
  vim.api.nvim_input( "<Esc>l\"-xi <Esc>ea <Esc>\"-p" )
end

return M
