local M = {}

local buf
local win
local split_command

local state

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

function M.show( split_cmd )
  local needs_set = false
  create_buffer( function() needs_set = true end )

  if not win or not vim.api.nvim_win_is_valid( win ) then
    vim.cmd( string.format( "%s#%s", split_cmd or split_command or "70vs", buf ) )
    win = vim.api.nvim_get_current_win()
    return
  end

  if needs_set then vim.api.nvim_win_set_buf( win, buf ) end
end

function M.toggle()
  if win and vim.api.nvim_win_is_valid( win ) then
    vim.api.nvim_win_close( win, true )
    return
  end

  M.show()
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
    R( "obszczymucha.debug" ).init( "70vs" )
  end, { nargs = 0 } )

  vim.api.nvim_create_user_command( "Dbgh", function()
    cleanup()
    R( "obszczymucha.debug" ).init( "bel 10sp" )
  end, { nargs = 0 } )
end

function M.init( split_cmd )
  split_command = split_cmd
  M.show()
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

  vim.api.nvim_buf_set_lines( buf, is_buf_empty( buf ) and 0 or -1, -1, false,
    type( text ) == "table" and text or { text } )
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
