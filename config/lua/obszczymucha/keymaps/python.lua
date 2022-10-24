local M = {}

function M.format_file()
  vim.cmd( [[w | silent exec "!black -q %"]] )
end

function M.organize_imports()
  vim.cmd( [[w | silent exec "!isort -q --profile black %"]] )
end

return M
