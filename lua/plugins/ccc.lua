return {
  "uga-rosa/ccc.nvim",
  config = function()
    local ccc = require("ccc")

    ccc.setup( {
      highlighter = {
        auto_enable = false,
        lsp = true,
      },
      picker = {
        win_opts = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual",
        },
      },
      formats = { "hex", "rgb", "hsl", "name" },
      default_color = "#ffffff",
    } )
  end,
  lazy = false
}
