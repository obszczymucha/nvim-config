local M = {}

local colors = require( "obszczymucha.colors" )

local function decorate_set_opacity( highlights, custom_groups )
  local original_set_opacity = highlights.set_opacity

  function highlights:set_opacity( alpha )
    local result = original_set_opacity( self, alpha )

    local util = require( "notify.util" )
    local normal_hl = vim.api.nvim_get_hl( 0, { name = "Normal" } )
    local background = normal_hl.bg or 0x000000

    for group_name, original_color in pairs( custom_groups ) do
      local blended_fg = util.blend( original_color, background, alpha / 100 )
      vim.api.nvim_set_hl( 0, group_name, { fg = blended_fg } )
      result = true
    end

    return result
  end
end

---Custom render function for nvim-notify that supports colored text
---@param bufnr number The buffer number to render into
---@param notif table The notification object from nvim-notify
---@param highlights table The highlights object from nvim-notify
function M.custom_render( bufnr, notif, highlights )
  local base = require( "notify.render.base" )
  local namespace = base.namespace()
  local icon = notif.icon

  local parts, clean_message = colors.parse_colored_text( bufnr, notif.message[ 1 ], highlights )
  local custom_groups = colors.create_custom_groups( parts )
  decorate_set_opacity( highlights, custom_groups )

  local message = { string.format( "%s  %s", icon, clean_message ) }

  for i = 2, #notif.message do
    message[ i ] = notif.message[ i ]
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

return M
