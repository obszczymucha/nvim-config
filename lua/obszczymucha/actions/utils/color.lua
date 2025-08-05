local M = {}

function M.is_hex_color_at_cursor()
  local cursor_char = vim.fn.getline( '.' ):sub( vim.fn.col( '.' ), vim.fn.col( '.' ) )

  if cursor_char == '#' then
    local line = vim.fn.getline( '.' )
    local col = vim.fn.col( '.' )
    local hex_pattern = '%x%x%x%x%x%x'
    local after_hash = line:sub( col + 1, col + 6 )

    return after_hash:match( '^' .. hex_pattern .. '$' ) ~= nil
  end

  local current_word = vim.fn.expand( '<cword>' )
  return current_word:match( '^%x%x%x%x%x%x$' ) ~= nil
end

return M

