local notify = prequire( "notify" )
if not notify then return end

notify.setup( {
  minimum_width = 15,
  render = "minimal",
  stages = "fade_in_slide_out",
  timeout = 2000,
  top_down = true,
  background_colour = "#000000",
} )
