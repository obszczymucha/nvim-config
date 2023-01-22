local M = {}

local buf
local win

function M.show()
  if not win or not vim.api.nvim_win_is_valid( win ) then
    vim.cmd( "vs" )
    win = vim.api.nvim_get_current_win()
  end

  if not buf or not vim.api.nvim_buf_is_valid( buf ) then
    buf = vim.api.nvim_create_buf( false, false )
  end

  vim.api.nvim_win_set_buf( win, buf )
end

function M.toggle()
  if win and vim.api.nvim_win_is_valid( win ) then
    vim.api.nvim_win_close( win, true )
    return
  end

  M.show()
end

function M.setup()
  vim.api.nvim_create_user_command( "Debug", function()
    if win and vim.api.nvim_win_is_valid( win ) then
      vim.api.nvim_win_close( win, true )
    end

    if buf and vim.api.nvim_buf_is_valid( buf ) then
      vim.api.nvim_buf_delete( buf, { force = true } )
    end

    R( "obszczymucha.debug" ).init()
  end, { nargs = 0 } )
end

function M.init()
  M.show()

  vim.api.nvim_create_autocmd( "BufWritePost", {
    group = vim.api.nvim_create_augroup( "MyDebug", { clear = true } ),
    pattern = { "*.lua" },
    callback = function() R( "obszczymucha.lua-test" ).run() end
  } )
end

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
  if not buf or not vim.api.nvim_buf_is_valid( buf ) then
    print( "No debug buffer available." )
    return
  end

  vim.api.nvim_buf_set_lines( buf, is_buf_empty( buf ) and 0 or -1, -1, false,
    type( text ) == "table" and text or { text } )
end

function M.count()
  M.clear()
  vim.api.nvim_buf_set_lines( buf, 0, -1, false, { tostring( vim.api.nvim_buf_line_count( buf ) ) } )
end

function M.clear()
  if not buf or not vim.api.nvim_buf_is_valid( buf ) then
    print( "No debug buffer available." )
    return
  end

  vim.api.nvim_buf_set_lines( buf, 0, -1, false, {} )
end

M.setup()

return M
