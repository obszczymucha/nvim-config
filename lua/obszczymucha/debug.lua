local M = {}

local buf
local win

local state
local is_vertical

function M.set( st )
  state = st
end

function M.get()
  return state
end

local function create_buffer( callback )
  if buf and vim.api.nvim_buf_is_valid( buf ) then return end

  buf = vim.api.nvim_create_buf( true, true )
  vim.api.nvim_buf_set_name( buf, "Debug" )
  if callback then callback() end
end

function M.show( split_cmd, split_prefix )
  local needs_set = false
  create_buffer( function() needs_set = true end )

  local split = split_cmd or "vs"
  is_vertical = split == "vs"
  local prefix = split_prefix and string.format( "%s ", split_prefix ) or ""
  local width = config.debug.width or 70
  local height = config.debug.height or 12
  local size = is_vertical and width or height

  if not win or not vim.api.nvim_win_is_valid( win ) then
    vim.cmd( string.format( "%s%s%s#%s", prefix or "", size, split, buf ) )
    win = vim.api.nvim_get_current_win()
    vim.api.nvim_input( "<C-W>p" )
    return
  end

  if needs_set then vim.api.nvim_win_set_buf( win, buf ) end
  vim.api.nvim_input( "<C-W>p" )
end

function M.is_visible()
  return win and vim.api.nvim_win_is_valid( win )
end

function M.hide()
  vim.api.nvim_win_close( win, true )
end

function M.toggle()
  if M.is_visible() then
    M.hide()
    return
  end

  M.show()
end

function M.toggle_horizontal()
  if M.is_visible() then
    M.hide()
    return
  end

  M.show( "sp", "bel" )
end

function M.flip()
  M.hide()
  if is_vertical then
    M.toggle_horizontal()
  else
    M.toggle()
  end
end

function M.setup()
  local function cleanup()
    if win and vim.api.nvim_win_is_valid( win ) then
      vim.api.nvim_win_close( win, true )
      win = nil
    end

    if buf and vim.api.nvim_buf_is_valid( buf ) then
      vim.api.nvim_buf_delete( buf, { force = true } )
      buf = nil
    end
  end

  vim.api.nvim_create_user_command( "Dbg", function()
    cleanup()
    R( "obszczymucha.debug" ).show()
  end, { nargs = 0 } )

  vim.api.nvim_create_user_command( "Dbgh", function()
    cleanup()
    R( "obszczymucha.debug" ).show( "sp", "bel" )
  end, { nargs = 0 } )
end

---@diagnostic disable-next-line: unused-function
local function dump2( o )
  local entries = 0

  if type( o ) == 'table' then
    local s = '{'
    for k, v in pairs( o ) do
      if (entries == 0) then s = s .. " " end
      if type( k ) ~= 'number' then k = '"' .. k .. '"' end
      if (entries > 0) then s = s .. ", " end
      s = s .. '[' .. k .. '] = ' .. dump2( v )
      entries = entries + 1
    end

    if (entries > 0) then s = s .. " " end
    return s .. '}'
  else
    return tostring( o )
  end
end

local function is_buf_empty( buffer )
  local count = vim.api.nvim_buf_line_count( buffer )
  local first_line = vim.api.nvim_buf_get_lines( buffer, 0, 1, false )
  return count == 1 and first_line[ 1 ] == ""
end

function M.debug( text )
  create_buffer()

  if type( text ) == "table" then
    vim.api.nvim_buf_set_lines( buf, is_buf_empty( buf ) and 0 or -1, -1, false, text )
    return
  end

  local t = string.format( "%s", text or "nil" )

  for line in string.gmatch( t, "([^\n]+)" ) do
    vim.api.nvim_buf_set_lines( buf, is_buf_empty( buf ) and 0 or -1, -1, false, { line } )
  end
end

function M.count()
  M.clear()
  vim.api.nvim_buf_set_lines( buf, 0, -1, false, { tostring( vim.api.nvim_buf_line_count( buf ) ) } )
end

function M.clear()
  if not buf or not vim.api.nvim_buf_is_valid( buf ) then return end
  vim.api.nvim_buf_set_lines( buf, 0, -1, false, {} )
end

M.setup()

return M
