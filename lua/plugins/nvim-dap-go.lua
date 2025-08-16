return {
  "leoluz/nvim-dap-go",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    require( "dap-go" ).setup()
  end,
}
