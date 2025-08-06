local M = {}

---@return string|nil Relative path from current working directory or nil if not within cwd
function M.get_relative_path()
  local buf_path = vim.fn.resolve( vim.fn.expand( "%:p" ) )
  local cwd = vim.fn.resolve( vim.fn.getcwd() )

  if buf_path == "" then
    return nil
  end

  -- Check if buffer is within current working directory
  if buf_path:sub( 1, #cwd ) == cwd then
    return buf_path:sub( #cwd + 2 ) -- +2 to skip the trailing slash
  end

  return nil
end

return M

