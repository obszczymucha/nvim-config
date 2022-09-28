local M = {}

function M.test_file()
  vim.cmd("lua require'dap'.repl.open()")
  vim.cmd("lua require'jdtls'.test_class()")
end

function M.test_nearest_method()
  vim.cmd("lua require'dap'.repl.open()")
  vim.cmd("lua require'jdtls'.test_nearest_method()")
end

return M
