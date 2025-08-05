local M = {}

function M.get_word_under_cursor()
  local cursor_word = vim.fn.expand( "<cword>" )
  return cursor_word
end

function M.is_camel_case()
  local word = M.get_word_under_cursor()
  if word == "" then return false end

  -- Check if word contains lowercase letters followed by uppercase letters
  -- This pattern matches camelCase (starts with lowercase) or PascalCase (starts with uppercase)
  return word:match( "^%l+%u" ) ~= nil or word:match( "%l%u" ) ~= nil
end

function M.is_snake_case()
  local word = M.get_word_under_cursor()
  if word == "" then return false end

  return word:match( "_" ) ~= nil and word:match( "^[%l_]+$" ) ~= nil
end

function M.to_snake_case()
  local word = M.get_word_under_cursor()
  if word == "" then return end

  local snake_case = word:gsub( "(%l)(%u)", "%1_%2" ):lower()

  vim.cmd( "normal! ciw" .. snake_case )
  vim.api.nvim_feedkeys( vim.api.nvim_replace_termcodes( "<Esc>", true, false, true ), "n", false )
end

function M.to_pascal_case()
  local word = M.get_word_under_cursor()
  if word == "" then return end

  local pascal_case = word:gsub( "(%l)(_)(%l)", function( a, _, c ) return a .. c:upper() end )
  pascal_case = pascal_case:gsub( "^%l", string.upper )

  vim.cmd( "normal! ciw" .. pascal_case )
  vim.api.nvim_feedkeys( vim.api.nvim_replace_termcodes( "<Esc>", true, false, true ), "n", false )
end

return M
