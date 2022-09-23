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

return M
