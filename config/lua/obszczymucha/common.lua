local M = {}

M.ends_with = function( str, ending )
  return ending == "" or str:sub( - #ending ) == ending
end

M.prequire = function( ... )
  local status, module = pcall( require, ... )
  if status then return module else return nil end
end

M.princess_kenny = function()
  return "Princess Kenny"
end

M.is_blank = function( s )
  return not s or s:match( "^%s*$" ) ~= nil
end

M.get_char_under_cursor = function( relative_pos )
  local pos = relative_pos and relative_pos + 1 or 1
  local _, col = unpack( vim.api.nvim_win_get_cursor( 0 ) )
  return string.sub( vim.api.nvim_get_current_line(), col + pos, col + pos )
end

return M
