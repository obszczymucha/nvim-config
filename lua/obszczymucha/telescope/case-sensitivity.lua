local M = {}

---@alias CaseSensitivity
---| "smart"
---| "ignore"
---| "respect"

---@param current CaseSensitivity
---@return CaseSensitivity
function M.next( current )
  if current == "smart" then
    return "ignore"
  elseif current == "ignore" then
    return "respect"
  else
    return "smart"
  end
end

return M
