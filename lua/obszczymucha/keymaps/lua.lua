local common = require( "obszczymucha.common" )
local M = {}

local function wrap( operation )
  local char = common.get_char_under_cursor()
  local any_quote = char == '"' or char == "'" or char == "`"
  local delete = (char == '"' or char == "`") and "\"_x" or ""
  local left_space = any_quote and "" or "i <Esc>"
  local right_space = any_quote and "a" or "a "

  vim.api.nvim_input( string.format( "<Esc>\"_x%s%s%s%s<Esc>%si", left_space, operation, right_space, char, delete ) )
end

function M.fast_continuous_wrap()
  wrap( "E" )
end

function M.fast_word_wrap()
  wrap( "e" )
end

function M.reload()
  vim.api.nvim_command( "so %" )
  vim.notify( "File reinterpreted." )
end

function M.format_file()
  vim.cmd( "lua vim.lsp.buf.format { async = false }" )
  -- vim.defer_fn( function() vim.diagnostic.enable() end, 100 )
  vim.diagnostic.enable()
end

return M
