return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require( "dap" )
    dap.defaults.fallback.force_external_terminal = true
    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "Run Or Test",
        metals = {
          runType = "runOrTestFile",
          envFile = vim.fn.getcwd() .. "/.metals.env"
        },
        console = "integratedTerminal"
      },
      {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
          runType = "testTarget",
          envFile = vim.fn.getcwd() .. "/.metals.env"
        }
      }
    }
  end
}
