local M = {}

---@class TextPart
---@field text string
---@field highlight string

---Resolves a highlight group by name, checking both direct name and @-prefixed name
---@param name string The highlight group name to resolve
---@return table|nil highlight The highlight group table or nil if not found
function M.resolve_highlight( name )
  local hl = vim.api.nvim_get_hl( 0, { name = name } )
  if hl and (hl.fg or hl.link) then
    return hl
  end

  hl = vim.api.nvim_get_hl( 0, { name = "@" .. name } )
  if hl and (hl.fg or hl.link) then
    return hl
  end

  return nil
end

---Enhances a highlights object with custom color group functionality and opacity support
---@param highlights table The highlights object to enhance
function M.enhance_highlights( highlights )
  if highlights.add_custom_group then
    return
  end

  highlights._custom_groups = {}
  highlights._instance_id = tostring( os.clock() ):gsub( "%.", "" ) .. math.random( 1000 )

  function highlights:add_custom_group( name, color )
    local custom_name = name:gsub( "#", "hex_" ) .. "_notify_" .. self._instance_id

    local color_num = color
    if type( color ) == "string" and color:match( "^#%x%x%x%x%x%x$" ) then
      color_num = tonumber( color:sub( 2 ), 16 )
    end

    self._custom_groups[ custom_name ] = color_num
    vim.api.nvim_set_hl( 0, custom_name, { fg = color } )
    return custom_name
  end

  local original_set_opacity = highlights.set_opacity

  function highlights:set_opacity( alpha )
    local result = original_set_opacity( self, alpha )

    local util = require( "notify.util" )
    local background = 0x000000

    for group_name, original_color in pairs( self._custom_groups ) do
      local blended_fg = util.blend( original_color, background, alpha / 100 )
      vim.api.nvim_set_hl( 0, group_name, { fg = blended_fg } )
      result = true
    end

    return result
  end
end

---Resolves color to a foreground color value
---@param color string The color string (hex or highlight group name)
---@return table|nil highlight The resolved highlight with fg property
local function resolve_color( color )
  if color:match( "^#%x%x%x%x%x%x$" ) then
    return { fg = color }
  end

  local hl = M.resolve_highlight( color )
  if hl and hl.link then
    hl = vim.api.nvim_get_hl( 0, { name = hl.link, link = false } )
  end
  return hl
end

---Creates or gets highlight group for a color
---@param color string The original color string
---@param fg_color any|nil The resolved foreground color
---@param highlights table The highlights object
---@return string group_name The highlight group name to use
local function get_highlight_group( color, fg_color, highlights )
  if fg_color then
    M.enhance_highlights( highlights )
    return highlights:add_custom_group( color, fg_color )
  end
  return highlights.body
end

---Finds the next color pattern in text
---@param text string The text to search
---@param pos number Starting position
---@return number|nil start_pos Start position of pattern
---@return number|nil end_pos End position of pattern
---@return string|nil color The color value
---@return string|nil content The text content
local function find_next_pattern( text, pos )
  local hex_start, hex_end, hex_color, hex_content = text:find( "@(#%x%x%x%x%x%x)@([^@]-)@@", pos )
  local name_start, name_end, name_color, name_content = text:find( "@([%w%.]+)@([^@]-)@@", pos )

  if hex_start and (not name_start or hex_start < name_start) then
    return hex_start, hex_end, hex_color, hex_content
  elseif name_start then
    return name_start, name_end, name_color, name_content
  end

  return nil
end

---Adds a text part to the parts array
---@param parts TextPart[] The parts array
---@param text string The text to add
---@param highlight string The highlight group
---@param clean_text string The accumulated clean text
---@return string clean_text Updated clean text
local function add_part( parts, text, highlight, clean_text )
  if text ~= "" then
    parts[ #parts + 1 ] = { text = text, highlight = highlight }
    return clean_text .. text
  end
  return clean_text
end

---Parses text containing color patterns and returns text parts with highlight groups
---@param text string The text to parse (supports @#hex@text@@ and @group@text@@ patterns)
---@param highlights table The highlights object from nvim-notify
---@return TextPart[] parts Array of text parts with their highlight groups
---@return string clean_text The text with color patterns removed
function M.parse_colored_text( text, highlights )
  local parts = {}
  local clean_text = ""
  local pos = 1

  while pos <= #text do
    local start_pos, end_pos, color, content = find_next_pattern( text, pos )

    if not start_pos then
      -- No more patterns, add remaining text
      clean_text = add_part( parts, text:sub( pos ), highlights.body, clean_text )
      break
    end

    -- Add text before the pattern
    if start_pos > pos then
      clean_text = add_part( parts, text:sub( pos, start_pos - 1 ), highlights.body, clean_text )
    end

    local original_hl = color and resolve_color( color )
    local custom_group_name = color and get_highlight_group( color, original_hl and original_hl.fg, highlights ) or
        highlights.body

    clean_text = add_part( parts, content or "", custom_group_name, clean_text )
    pos = end_pos + 1
  end

  return parts, clean_text
end

---Custom render function for nvim-notify that supports colored text
---@param bufnr number The buffer number to render into
---@param notif table The notification object from nvim-notify
---@param highlights table The highlights object from nvim-notify
function M.custom_render( bufnr, notif, highlights )
  local base = require( "notify.render.base" )
  local namespace = base.namespace()
  local icon = notif.icon

  local parts, clean_message = M.parse_colored_text( notif.message[ 1 ], highlights )

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
