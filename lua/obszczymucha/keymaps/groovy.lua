local M = {}

function M.format_file()
  vim.cmd( "%!npm-groovy-lint --format -" )
end

return M
