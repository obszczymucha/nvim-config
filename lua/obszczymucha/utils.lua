local M = {}

function M.get_project_root_dir()
  local root_dir = vim.fn.system( "git rev-parse --show-toplevel" )
  return not vim.v.shell_error and root_dir or vim.fn.getcwd()
end

---@param hex_color string Hex color code, e.g. "#ff5733"
---@param saturation_factor number Saturation factor, e.g. 0.5 for 50% saturation
---@return string Hex color code with adjusted saturation
function M.saturate( hex_color, saturation_factor )
  -- Remove # if present
  hex_color = hex_color:gsub( "#", "" )

  -- Parse RGB values
  local r = tonumber( hex_color:sub( 1, 2 ), 16 ) / 255
  local g = tonumber( hex_color:sub( 3, 4 ), 16 ) / 255
  local b = tonumber( hex_color:sub( 5, 6 ), 16 ) / 255

  -- Convert to HSL
  local max_val = math.max( r, g, b )
  local min_val = math.min( r, g, b )
  local diff = max_val - min_val

  local l = (max_val + min_val) / 2
  local s = 0
  local h = 0

  if diff ~= 0 then
    if l < 0.5 then
      s = diff / (max_val + min_val)
    else
      s = diff / (2 - max_val - min_val)
    end

    if max_val == r then
      h = (g - b) / diff + (g < b and 6 or 0)
    elseif max_val == g then
      h = (b - r) / diff + 2
    elseif max_val == b then
      h = (r - g) / diff + 4
    end
    h = h / 6
  end

  -- Apply saturation factor
  s = s * saturation_factor
  s = math.max( 0, math.min( 1, s ) ) -- Clamp to [0, 1]

  -- Convert back to RGB
  local function hue_to_rgb( p, q, t )
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1 / 6 then return p + (q - p) * 6 * t end
    if t < 1 / 2 then return q end
    if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
    return p
  end

  if s == 0 then
    r, g, b = l, l, l -- achromatic
  else
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue_to_rgb( p, q, h + 1 / 3 )
    g = hue_to_rgb( p, q, h )
    b = hue_to_rgb( p, q, h - 1 / 3 )
  end

  -- Convert back to hex
  r = math.floor( r * 255 + 0.5 )
  g = math.floor( g * 255 + 0.5 )
  b = math.floor( b * 255 + 0.5 )

  return string.format( "#%02x%02x%02x", r, g, b )
end

---@param hex_color string Hex color code, e.g. "#ff5733"
---@param luminosity_factor number Luminosity factor from 0.0 to 1.0
---@return string Hex color code with adjusted luminosity
function M.luminosity( hex_color, luminosity_factor )
  -- Remove # if present
  hex_color = hex_color:gsub( "#", "" )

  -- Parse RGB values
  local r = tonumber( hex_color:sub( 1, 2 ), 16 ) / 255
  local g = tonumber( hex_color:sub( 3, 4 ), 16 ) / 255
  local b = tonumber( hex_color:sub( 5, 6 ), 16 ) / 255

  -- Convert to HSL
  local max_val = math.max( r, g, b )
  local min_val = math.min( r, g, b )
  local diff = max_val - min_val

  local l = (max_val + min_val) / 2
  local s = 0
  local h = 0

  if diff ~= 0 then
    if l < 0.5 then
      s = diff / (max_val + min_val)
    else
      s = diff / (2 - max_val - min_val)
    end

    if max_val == r then
      h = (g - b) / diff + (g < b and 6 or 0)
    elseif max_val == g then
      h = (b - r) / diff + 2
    elseif max_val == b then
      h = (r - g) / diff + 4
    end
    h = h / 6
  end

  -- Apply luminosity factor
  l = luminosity_factor
  l = math.max( 0, math.min( 1, l ) ) -- Clamp to [0, 1]

  -- Convert back to RGB
  local function hue_to_rgb( p, q, t )
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1 / 6 then return p + (q - p) * 6 * t end
    if t < 1 / 2 then return q end
    if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
    return p
  end

  if s == 0 then
    r, g, b = l, l, l -- achromatic
  else
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue_to_rgb( p, q, h + 1 / 3 )
    g = hue_to_rgb( p, q, h )
    b = hue_to_rgb( p, q, h - 1 / 3 )
  end

  -- Convert back to hex
  r = math.floor( r * 255 + 0.5 )
  g = math.floor( g * 255 + 0.5 )
  b = math.floor( b * 255 + 0.5 )

  return string.format( "#%02x%02x%02x", r, g, b )
end

---@param hex_color string Hex color code, e.g. "#ff5733"
---@param brightness_factor number Brightness factor from 0.0 (black) to 1.0 (original) to 2.0 (white)
---@return string Hex color code interpolated between black, original color, and white
function M.brightness( hex_color, brightness_factor )
  hex_color = hex_color:gsub( "#", "" )

  -- Parse RGB values
  local r = tonumber( hex_color:sub( 1, 2 ), 16 )
  local g = tonumber( hex_color:sub( 3, 4 ), 16 )
  local b = tonumber( hex_color:sub( 5, 6 ), 16 )

  -- Clamp brightness factor to [0, 2]
  brightness_factor = math.max( 0, math.min( 2, brightness_factor ) )

  if brightness_factor <= 1.0 then
    -- Interpolate between black (0, 0, 0) and original color
    r = math.floor( r * brightness_factor + 0.5 )
    g = math.floor( g * brightness_factor + 0.5 )
    b = math.floor( b * brightness_factor + 0.5 )
  else
    -- Interpolate between original color and white (255, 255, 255)
    local factor = brightness_factor - 1.0
    r = math.floor( r + (255 - r) * factor + 0.5 )
    g = math.floor( g + (255 - g) * factor + 0.5 )
    b = math.floor( b + (255 - b) * factor + 0.5 )
  end

  return string.format( "#%02x%02x%02x", r, g, b )
end

return M
