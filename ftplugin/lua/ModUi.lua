-- I decorate "cib" and "dib" functionality to not change the content
-- if the cursor is inside a function whose name is in function_names.
-- Instead, we'll modify next available parentheses.
local M = {}

M.function_names = { "ModUi.mod", "ModUi.cmod", "ModUi.mixin", "ModUi.cmixin" }

local function should_move_cursor( node )
  local current = node

  while current do
    if current:type() == "parameters" or current:type() == "arguments" then
      local call = current:parent()

      if call and call:type() == "function_call" then
        local prefix = call:child( 0 )

        if prefix and prefix:type() == "dot_index_expression" then
          local text = vim.treesitter.get_node_text( prefix, 0 )

          for _, name in ipairs( M.function_names ) do
            if text == name then return true end
          end
        end

        return false
      end
    end

    current = current:parent()
  end

  return true
end

local function find_next_paren( row, col )
  for current_line = row, vim.api.nvim_buf_line_count( 0 ) - 1 do
    local line = vim.api.nvim_buf_get_lines( 0, current_line, current_line + 1, false )[ 1 ]
    local next_paren = line:find( "%(", current_line == row and col + 1 or 1 )

    if next_paren then return current_line, next_paren end
  end
end

---@param operator "'c'" | "'d'" | "'v'"
function M.custom_ib( operator )
  local cursor = vim.api.nvim_win_get_cursor( 0 )
  local row, col = cursor[ 1 ] - 1, cursor[ 2 ]

  local node = vim.treesitter.get_parser( 0, "lua" ):parse()[ 1 ]:root()
      :named_descendant_for_range( row, col, row, col )

  if should_move_cursor( node ) then
    local next_row, next_col = find_next_paren( row, col )

    if next_row then
      vim.api.nvim_win_set_cursor( 0, { next_row + 1, next_col - 1 } )
    end
  end

  vim.api.nvim_feedkeys( string.format( [[%sib]], operator ), "n", true )
end

vim.keymap.set( "n", "cib", function() M.custom_ib( "c" ) end, { noremap = true, silent = true, buffer = true } )
vim.keymap.set( "n", "dib", function() M.custom_ib( "d" ) end, { noremap = true, silent = true, buffer = true } )
vim.keymap.set( "n", "vib", function() M.custom_ib( "v" ) end, { noremap = true, silent = true, buffer = true } )

return M
