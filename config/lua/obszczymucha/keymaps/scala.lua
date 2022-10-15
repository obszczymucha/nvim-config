local M = {}

function M.organize_imports()
  vim.cmd( "MetalsOrganizeImports" )
end

function M.compile()
  vim.cmd( "MetalsCompileCascade" )
end

return M

