local M = {}

local function wrap( operation )
  local _, col = unpack( vim.api.nvim_win_get_cursor( 0 ) )
  local char = string.sub( vim.api.nvim_get_current_line(), col + 1, col + 1 )
  vim.api.nvim_input( string.format( "<Esc>l\"_xi <Esc>%sa %s<Esc>", operation, char ) )
end

function M.fast_continuous_wrap()
  wrap( "E" )
end

function M.fast_word_wrap()
  wrap( "e" )
end

return M
