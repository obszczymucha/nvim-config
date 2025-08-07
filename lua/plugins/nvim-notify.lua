return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    -- Decorate both functions to move notifications one row higher
    local stages_util = require( "notify.stages.util" )
    local original_available_slot = stages_util.available_slot
    local original_slot_after_previous = stages_util.slot_after_previous

    stages_util.available_slot = function( ... )
      local row = original_available_slot( ... )
      return row and row - 1 or row
    end

    stages_util.slot_after_previous = function( ... )
      local row = original_slot_after_previous( ... )
      return row and row - 1 or row
    end

    local notify = require( "notify" )

    ---@diagnostic disable-next-line: undefined-field
    notify.setup( {
      minimum_width = 15,
      render = "minimal",
      stages = "fade_in_slide_out",
      timeout = 2000,
      top_down = true,
      background_colour = "#000000",
    } )
  end
}
