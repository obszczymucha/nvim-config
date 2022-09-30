local common = require( "obszczymucha.common" )
local M = {}

local function wrap( operation )
  local char = common.get_char_under_cursor()
  local delete = (char == '"' or char == "'") and "\"_x" or ""

  vim.api.nvim_input( string.format( "<Esc>l\"_xi <Esc>%sa %s<Esc>%s", operation, char, delete ) )
end

function M.fast_continuous_wrap()
  wrap( "E" )
end

function M.fast_word_wrap()
  wrap( "e" )
end

return M
