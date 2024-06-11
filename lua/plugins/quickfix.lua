return {
  "kevinhwang91/nvim-bqf",
  lazy = false,
  config = function()
    require( "bqf" ).setup {
      preview = {
        show_scroll_bar = false,
        win_height = 999, -- Fullscreen
      }
    }
  end
}
