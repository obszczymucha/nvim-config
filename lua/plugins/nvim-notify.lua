return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    local notify = require( "notify" )
    local colors = require( "obszczymucha.nvim-notify.colors" )
    local position = require( "obszczymucha.nvim-notify.position" )

    position.setup()

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
