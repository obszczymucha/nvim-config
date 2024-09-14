local M = {}

function M.organize_imports()
  vim.cmd( "MetalsOrganizeImports" )
end

function M.compile()
  vim.cmd( "MetalsCompileCascade" )
end

function M.show_test_results()
  R( 'obszczymucha.lang.scala.dap-repl-popup' ).toggle()
end

return M
