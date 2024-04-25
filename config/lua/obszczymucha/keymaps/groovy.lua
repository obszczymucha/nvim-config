local M = {}

-- Install npm-groovy-lint via Mason.
function M.format_file()
  vim.cmd( "%!npm-groovy-lint --format -" )
end

return M
