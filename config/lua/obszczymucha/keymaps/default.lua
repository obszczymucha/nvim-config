local common = require( "obszczymucha.common" )
local M = {}

function M.go_to_definition()
  vim.cmd( "lua vim.lsp.buf.definition()" )
end

function M.go_to_implementation()
  vim.cmd( "lua vim.lsp.buf.implementation()" )
end

function M.signature_help()
  vim.cmd( "lua vim.lsp.buf.signature_help()" )
end

function M.peek_definition()
  --vim.cmd( "lua vim.lsp.buf.definition()" )
  vim.cmd( "Lspsaga peek_definition" )
end

function M.references()
  vim.cmd( "lua vim.lsp.buf.references()" )
end

function M.documentation()
  --vim.cmd( "lua vim.lsp.buf.hover()" )
  vim.cmd( "Lspsaga hover_doc" )
end

function M.rename()
  --vim.cmd( "lua vim.lsp.buf.rename()" )
  vim.cmd( "Lspsaga rename" )
end

function M.format_file()
  vim.cmd( "lua vim.lsp.buf.formatting()" )
end

function M.next_diagnostic()
  --vim.cmd( "lua vim.diagnostic.goto_next()" )
  vim.cmd( "Lspsaga diagnostic_jump_next" )
end

function M.prev_diagnostic()
  --vim.cmd( "lua vim.diagnostic.goto_prev()" )
  vim.cmd( "Lspsaga diagnostic_jump_prev" )
end

function M.code_action()
  --vim.cmd( "lua vim.lsp.buf.code_action()" )
  vim.cmd( "Lspsaga code_action" )
end

function M.code_lens()
  vim.cmd( "lua vim.lsp.codelens.run()" )
end

function M.outline()
  vim.cmd( "LSoutlineToggle" )
end

local function wrap( operation )
  local char = common.get_char_under_cursor()
  local delete = (char == '"' or char == "'") and "\"_x" or ""

  vim.api.nvim_input( string.format( "<Esc>l\"_x<Esc>%sa%s<Esc>%s", operation, char, delete ) )
end

function M.fast_continuous_wrap()
  wrap( "E" )
end

function M.fast_word_wrap()
  wrap( "e" )
end

return M
