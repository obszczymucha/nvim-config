local function break_function()
  local row, col = unpack( vim.api.nvim_win_get_cursor( 0 ) )
  row = row - 1

  local node = vim.treesitter.get_node( { pos = { row, col } } )
  if not node then return end

  local arguments_node
  while node and not arguments_node do
    if node:type() == "parameters" then
      arguments_node = node
    end
    node = node:parent()
  end

  if not arguments_node then return end
  local parent = arguments_node:parent()
  if not parent or parent:type() ~= "function_declaration" then return end

  local text = vim.api.nvim_get_current_line()
  local args = {}

  for arg in arguments_node:iter_children() do
    local type = arg:type()
    if type ~= "," and type ~= "(" and type ~= ")" then
      local _, start_col, _, end_col = arg:range()
      table.insert( args, { start_col = start_col, end_col = end_col } )
    end
  end

  if #args == 0 then return end

  local result = {}
  local indent = string.match( text, "^%s*" ) or ""
  local func_part = text:sub( 1, args[ 1 ].start_col )

  table.insert( result, func_part )

  for i, arg in ipairs( args ) do
    local line = indent .. "  " .. text:sub( arg.start_col + 1, arg.end_col )
    if i < #args then
      line = line .. ","
    end
    table.insert( result, line )
  end

  table.insert( result, indent .. ")" )

  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines( bufnr, row, row + 1, false, result )
end

return break_function
