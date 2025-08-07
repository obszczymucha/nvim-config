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

    local function custom_render( bufnr, notif, highlights )
      local base = require( "notify.render.base" )
      local namespace = base.namespace()
      local icon = notif.icon

      local message = {
        string.format( "%s  %s", icon, notif.message[ 1 ] ),
        unpack( notif.message, 2 ),
      }

      vim.api.nvim_buf_set_lines( bufnr, 0, -1, false, message )

      local icon_length = string.len( icon )

      vim.api.nvim_buf_set_extmark( bufnr, namespace, 0, 0, {
        hl_group = highlights.icon,
        end_col = icon_length + 1,
        priority = 50,
      } )
      vim.api.nvim_buf_set_extmark( bufnr, namespace, 0, icon_length + 1, {
        hl_group = highlights.body,
        end_line = #message,
        priority = 50,
      } )
    end

    local notify = require( "notify" )

    ---@diagnostic disable-next-line: undefined-field
    notify.setup( {
      minimum_width = 8,
      render = custom_render, -- "minimal"
      stages = "fade_in_slide_out",
      timeout = 2000,
      top_down = true,
      background_colour = "#000000",
    } )
  end
}
