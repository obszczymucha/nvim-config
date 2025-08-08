return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    -- Decorate both functions to move notifications one row higher
    local stages_util = require( "notify.stages.util" )
    local original_get_slot_range = stages_util.get_slot_range

    stages_util.get_slot_range = function( direction )
      local top, bottom = original_get_slot_range( direction )
      return direction == stages_util.DIRECTION.TOP_DOWN and 0, bottom or top, bottom
    end

    local function custom_render( bufnr, notif, highlights )
      local base = require( "notify.render.base" )
      local namespace = base.namespace()
      local icon = notif.icon

      local function parse_highlights( text )
        local parts = {}
        local clean_text = ""
        local last_pos = 1

        for highlight_group, content, end_pos in text:gmatch( "@([%w%.]+)@([^@]-)@@()" ) do
          local before_match = text:sub( last_pos, text:find( "@" .. highlight_group .. "@", last_pos ) - 1 )
          if before_match ~= "" then
            table.insert( parts, {
              text = before_match,
              highlight = highlights.body
            } )
            clean_text = clean_text .. before_match
          end
          table.insert( parts, {
            text = content,
            highlight = highlight_group
          } )
          clean_text = clean_text .. content
          last_pos = end_pos
        end

        if last_pos <= #text then
          local remaining = text:sub( last_pos )
          table.insert( parts, {
            text = remaining,
            highlight = highlights.body
          } )
          clean_text = clean_text .. remaining
        end

        return parts, clean_text
      end

      local parts, clean_message = parse_highlights( notif.message[ 1 ] )

      local first_line = string.format( "%s  %s", icon, clean_message )
      local message = { first_line }
      for i = 2, #notif.message do
        table.insert( message, notif.message[ i ] )
      end

      vim.api.nvim_buf_set_lines( bufnr, 0, -1, false, message )

      local icon_length = string.len( icon )

      vim.api.nvim_buf_set_extmark( bufnr, namespace, 0, 0, {
        hl_group = highlights.icon,
        end_col = icon_length + 1,
        priority = 50,
      } )

      local col_offset = icon_length + 2

      for _, part in ipairs( parts ) do
        vim.api.nvim_buf_set_extmark( bufnr, namespace, 0, col_offset, {
          hl_group = part.highlight,
          end_col = col_offset + #part.text,
          priority = 50,
        } )
        col_offset = col_offset + #part.text
      end

      if #message > 1 then
        vim.api.nvim_buf_set_extmark( bufnr, namespace, 1, 0, {
          hl_group = highlights.body,
          end_line = #message - 1,
          end_col = 0,
          priority = 50,
        } )
      end
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
