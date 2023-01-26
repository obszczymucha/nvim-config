local M = {}

function M.ends_with( str, ending )
  return ending == "" or str:sub( - #ending ) == ending
end

function M.prequire( ... )
  local status, module = pcall( require, ... )
  if status then return module else return nil end
end

function M.princess_kenny()
  return "Princess Kenny"
end

function M.is_blank( s )
  return not s or s:match( "^%s*$" ) ~= nil
end

function M.get_char_under_cursor( relative_pos )
  local pos = relative_pos and relative_pos + 1 or 1
  local _, col = unpack( vim.api.nvim_win_get_cursor( 0 ) )
  return string.sub( vim.api.nvim_get_current_line(), col + pos, col + pos )
end

function M.get_filename( path )
  return path:gsub( "(.*/)", "" )
end

return M
