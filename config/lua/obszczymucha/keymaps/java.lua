local M = {}

function M.test_file()
  require( "dap" ).repl.open()
  require( "jdtls" ).test_class()
end

function M.test_nearest_method()
  require( "dap" ).repl.open()
  require( "jdtls" ).test_nearest_method()
end

function M.organize_imports()
  require( "jdtls" ).organize_imports()
end

return M
