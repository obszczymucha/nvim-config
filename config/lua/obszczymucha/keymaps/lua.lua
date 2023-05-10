local common = require( "obszczymucha.common" )
local M = {}

local function wrap( operation )
  local char = common.get_char_under_cursor()
  local any_quote = char == '"' or char == "'" or char == "`"
  local delete = (char == '"' or char == "`") and "\"_x" or ""
  local left_space = any_quote and "" or "i <Esc>"
  local right_space = any_quote and "a" or "a "

  vim.api.nvim_input( string.format( "<Esc>l\"_x%s%s%s%s<Esc>%s", left_space, operation, right_space, char, delete ) )
end

function M.fast_continuous_wrap()
  wrap( "E" )
end

function M.fast_word_wrap()
  wrap( "e" )
end

function M.reload()
  vim.api.nvim_command( "so %" )
  print( "File reinterpreted." )
end

return M
