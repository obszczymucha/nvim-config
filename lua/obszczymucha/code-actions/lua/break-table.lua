local function reverse_ipairs( t )
  local i = #t + 1

  return function()
    i = i - 1
    if i > 0 then
      return i, t[ i ]
    end
  end
end

local function break_table( node )
  vim.notify("chuj")
  if not node or node:type() ~= "table_constructor" then return end

  local fields = {}

  for child in node:iter_children() do
    if child:type() == "field" then
      local start_row, start_col, end_row, end_col = child:range()
      table.insert( fields, { start_row = start_row, start_col = start_col, end_row = end_row, end_col = end_col } )
    end
  end

  if #fields == 0 then return end

  for _, field in reverse_ipairs( fields ) do
    local col = field.end_col
    local row = field.end_row + 1
    vim.api.nvim_win_set_cursor( 0, { row, col } )
    local line = vim.api.nvim_get_current_line()
    local char = line:sub( col + 1, col + 1 )
    local c = char == "," and "a" or "i"

    vim.api.nvim_feedkeys( vim.api.nvim_replace_termcodes( string.format( "%s<CR>", c ), true, false, true ), "x", false )
  end

  local f = fields[ 1 ]
  local col = f.start_col - 1
  local row = f.start_row + 1

  vim.api.nvim_win_set_cursor( 0, { row, col } )
  vim.api.nvim_feedkeys( vim.api.nvim_replace_termcodes( "s<CR>", true, false, true ), "x", false )
end

return break_table
