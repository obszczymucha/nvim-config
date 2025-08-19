local M = {}

function M.setup()
  local stages_util = require( "notify.stages.util" )

  -- Move notifications one row higher
  local original_get_slot_range = stages_util.get_slot_range
  stages_util.get_slot_range = function( direction )
    local top, bottom = original_get_slot_range( direction )
    return direction == stages_util.DIRECTION.TOP_DOWN and 0, bottom or top, bottom
  end
end

return M

