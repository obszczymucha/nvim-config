local M = {}

---@class TextPart
---@field text string
---@field highlight string
---@field fg_color string|number|nil

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


---Finds the next color pattern in text
---@param text string The text to search
---@param pos number Starting position
---@return number|nil start_pos Start position of pattern
---@return number|nil end_pos End position of pattern
---@return string|nil content The text content
---@return string|nil color The color value
local function find_next_pattern( text, pos )
  return text:find( "%[(.-)%]{(.-)}", pos )
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
---@param bufnr number The buffer number for unique group names
---@param text string The text to parse (supports @#hex@text@@ and @group@text@@ patterns)
---@param highlights table The highlights object from nvim-notify
---@return TextPart[] parts Array of text parts with their highlight groups and color info
---@return string clean_text The text with color patterns removed
function M.parse_colored_text( bufnr, text, highlights )
  local parts = {}
  local clean_text = ""
  local pos = 1

  while pos <= #text do
    local start_pos, end_pos, content, color = find_next_pattern( text, pos )

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
    local fg_color = original_hl and original_hl.fg

    if fg_color and color then
      local custom_name = "custom_" .. color:gsub( "#", "" ) .. bufnr
      parts[ #parts + 1 ] = { text = content or "", highlight = custom_name, fg_color = fg_color }
    else
      parts[ #parts + 1 ] = { text = content or "", highlight = highlights.body }
    end

    clean_text = clean_text .. (content or "")
    pos = end_pos + 1
  end

  return parts, clean_text
end

---Creates custom highlight groups from text parts
---@param parts TextPart[] Array of text parts with highlight and color info
---@return table custom_groups Map of group_name to color_num for opacity decoration
function M.create_custom_groups( parts )
  local custom_groups = {}

  for _, part in ipairs( parts ) do
    if part.fg_color then
      local color_num = part.fg_color

      if type( part.fg_color ) == "string" and part.fg_color:match( "^#%x%x%x%x%x%x$" ) then
        color_num = tonumber( part.fg_color:sub( 2 ), 16 )
      end

      custom_groups[ part.highlight ] = color_num

      vim.api.nvim_set_hl( 0, part.highlight, { fg = part.fg_color } )
    end
  end

  return custom_groups
end

---Parses buffer content and applies colored text highlighting
---@param bufnr number The buffer number to parse and highlight
---@param ns_id number Namespace ID for extmarks
---@return string[] highlight_groups Array of created highlight group names for cleanup
function M.apply_colored_text( bufnr, ns_id )
  local lines = vim.api.nvim_buf_get_lines( bufnr, 0, -1, false )
  local mock_highlights = { body = "Normal" }
  local created_groups = {}
  local clean_lines = {}
  local all_parts = {}

  for _, line_text in ipairs( lines ) do
    local parts, clean_text = M.parse_colored_text( bufnr, line_text, mock_highlights )
    local custom_groups = M.create_custom_groups( parts )

    for group_name, _ in pairs( custom_groups ) do
      table.insert( created_groups, group_name )
    end

    table.insert( clean_lines, clean_text )
    table.insert( all_parts, parts )
  end

  vim.api.nvim_buf_set_lines( bufnr, 0, -1, false, clean_lines )

  for line_num, parts in ipairs( all_parts ) do
    local col = 0

    for _, part in ipairs( parts ) do
      vim.api.nvim_buf_set_extmark( bufnr, ns_id, line_num - 1, col, {
        end_col = col + #part.text,
        hl_group = part.highlight
      } )

      col = col + #part.text
    end
  end

  return created_groups
end

return M
