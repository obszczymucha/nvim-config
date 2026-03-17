return {
  "mfussenegger/nvim-dap-python",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    require( "dap-python" ).setup( "python3" )
  end,
}
