return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    local notify = require( "notify" )
    local colors = require( "obszczymucha.nvim-notify.colors" )
    local position = require( "obszczymucha.nvim-notify.position" )

    position.setup()

    -- Set destination background color for fade animation (e.g., 0xff0000 for red)
    -- colors.destination_bg = 0x203040

    ---@diagnostic disable-next-line: undefined-field
    notify.setup( {
      minimum_width = 8,
      render = colors.custom_render,
      stages = "fade_in_slide_out",
      timeout = 2000,
      top_down = true,
      background_colour = "Normal",
    } )
  end
}
