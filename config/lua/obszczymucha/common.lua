local M = {}

function M.starts_with( str, prefix )
  return str:sub( 1, string.len( prefix ) ) == prefix
end

function M.ends_with( str, suffix )
  return suffix == "" or str:sub( - #suffix ) == suffix
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

function M.remove_trailing( s, chars )
  if not s then return end

  local pattern = chars .. "+$"
  return s:gsub( pattern, "" )
end

function M.get_char_under_cursor( relative_pos )
  local pos = relative_pos and relative_pos + 1 or 1
  local _, col = unpack( vim.api.nvim_win_get_cursor( 0 ) )
  return string.sub( vim.api.nvim_get_current_line(), col + pos, col + pos )
end

function M.get_char_before_cursor( relative_pos )
  local pos = relative_pos and relative_pos + 1 or 1
  local _, col = unpack( vim.api.nvim_win_get_cursor( 0 ) )
  return string.sub( vim.api.nvim_get_current_line(), col + pos - 1, col + pos - 1 )
end

function M.get_filename( path )
  return path:gsub( "(.*/)", "" )
end

function M.escape_dots( text )
  return text:gsub( "(%.)", "%%." )
end

function M.merge_tables( t1, t2 )
  local result = {}

  for k, v in pairs( t1 ) do result[ k ] = v end
  for k, v in pairs( t2 ) do result[ k ] = v end

  return result
end

-- This disables comment continuation when pressing o.
-- The comments will still continue when pressing Enter.
-- To also disable that, remove "r" from the below.
function M.disable_comment_continuation()
  vim.opt.formatoptions:remove( "o" )
end

return M
