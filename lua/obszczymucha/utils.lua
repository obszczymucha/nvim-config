local M = {}

function M.get_project_root_dir()
  local root_dir = vim.fn.system( "git rev-parse --show-toplevel" )
  return not vim.v.shell_error and root_dir or vim.fn.getcwd()
end

return M
