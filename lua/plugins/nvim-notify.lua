return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    local stages_util = require( "notify.stages.util" )

    -- Move notifications one row higher
    local original_get_slot_range = stages_util.get_slot_range
    stages_util.get_slot_range = function( direction )
      local top, bottom = original_get_slot_range( direction )
      return direction == stages_util.DIRECTION.TOP_DOWN and 0, bottom or top, bottom
    end

    local function resolve_highlight( name )
      -- Try the name as-is first
      local hl = vim.api.nvim_get_hl( 0, { name = name } )
      if hl and (hl.fg or hl.link) then
        return hl
      end

      -- Try with @ prefix
      hl = vim.api.nvim_get_hl( 0, { name = "@" .. name } )
      if hl and (hl.fg or hl.link) then
        return hl
      end

      return nil
    end

    -- Parse @highlight@text@@ syntax and create colored parts
    local function parse_colored_text( text, highlights )
      local parts = {}
      local clean_text = ""
      local last_pos = 1

      for highlight_group, content, end_pos in text:gmatch( "@([%w%.]+)@([^@]-)@@()" ) do
        -- Add text before the highlight
        local before_match = text:sub( last_pos, text:find( "@" .. highlight_group .. "@", last_pos ) - 1 )
        if before_match ~= "" then
          table.insert( parts, {
            text = before_match,
            highlight = highlights.body
          } )
          clean_text = clean_text .. before_match
        end

        -- Resolve the highlight group
        local original_hl = resolve_highlight( highlight_group )
        if original_hl and original_hl.link then
          original_hl = vim.api.nvim_get_hl( 0, { name = original_hl.link, link = false } )
        end

        -- Create custom highlight or fallback to body
        local custom_group_name
        if original_hl and original_hl.fg then
          -- Ensure highlights object has our enhanced methods
          if not highlights.add_custom_group then
            highlights._custom_groups = highlights._custom_groups or {}

            function highlights:add_custom_group( name, original_color )
              local custom_name = name .. "_notify_" .. vim.api.nvim_buf_get_number( 0 )
              self._custom_groups[ custom_name ] = original_color
              vim.api.nvim_set_hl( 0, custom_name, { fg = original_color } )
              return custom_name
            end

            local original_set_opacity = highlights.set_opacity
            function highlights:set_opacity( alpha )
              local result = original_set_opacity( self, alpha )

              local util = require( "notify.util" )
              local background = 0x000000 -- Default black background

              for group_name, original_color in pairs( self._custom_groups ) do
                local blended_fg = util.blend( original_color, background, alpha / 100 )
                vim.api.nvim_set_hl( 0, group_name, { fg = blended_fg } )
                result = true
              end

              return result
            end
          end

          custom_group_name = highlights:add_custom_group( highlight_group, original_hl.fg )
        else
          custom_group_name = highlights.body
        end

        table.insert( parts, {
          text = content,
          highlight = custom_group_name
        } )
        clean_text = clean_text .. content
        last_pos = end_pos
      end

      -- Add remaining text
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

    -- Custom renderer with colored highlight support
    local function custom_render( bufnr, notif, highlights )
      local base = require( "notify.render.base" )
      local namespace = base.namespace()
      local icon = notif.icon

      local parts, clean_message = parse_colored_text( notif.message[ 1 ], highlights )

      local message = { string.format( "%s  %s", icon, clean_message ) }
      for i = 2, #notif.message do
        table.insert( message, notif.message[ i ] )
      end

      vim.api.nvim_buf_set_lines( bufnr, 0, -1, false, message )

      local icon_length = string.len( icon )

      -- Set icon highlight
      vim.api.nvim_buf_set_extmark( bufnr, namespace, 0, 0, {
        hl_group = highlights.icon,
        end_col = icon_length + 1,
        priority = 50,
      } )

      -- Set text highlights
      local col_offset = icon_length + 2
      for _, part in ipairs( parts ) do
        vim.api.nvim_buf_set_extmark( bufnr, namespace, 0, col_offset, {
          hl_group = part.highlight,
          end_col = col_offset + #part.text,
          priority = 50,
        } )
        col_offset = col_offset + #part.text
      end

      -- Highlight additional message lines
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
      render = custom_render,
      stages = "fade_in_slide_out",
      timeout = 2000,
      top_down = true,
      background_colour = "#000000",
    } )
  end
}
