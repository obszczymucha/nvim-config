local M = {}

function M.format_file()
  vim.cmd( [[silent exec "%!black -q -"]] )
end

function M.organize_imports()
  vim.cmd( [[silent exec "%!isort -q --profile black -"]] )
end

return M
