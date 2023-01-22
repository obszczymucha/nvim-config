local M = {}

local buf
local win

function M.show()
  if not win or not vim.api.nvim_win_is_valid( win ) then
    vim.cmd( "vs" )
    win = vim.api.nvim_get_current_win()
  end

  if not buf or not vim.api.nvim_buf_is_valid( buf ) then
    buf = vim.api.nvim_create_buf( false, false )
  end

  vim.api.nvim_win_set_buf( win, buf )
end

function M.setup()
  vim.api.nvim_create_user_command( "Debug", function()
    if win and vim.api.nvim_win_is_valid( win ) then
      vim.api.nvim_win_close( win, true )
    end

    if buf and vim.api.nvim_buf_is_valid( buf ) then
      vim.api.nvim_buf_delete( buf, { force = true } )
    end

    R( "obszczymucha.debug" ).debug()
  end, { nargs = 0 } )
end

function M.get_buf()
  return buf
end

function M.debug()
  M.show()

  vim.api.nvim_create_augroup( "MyDebug", { clear = true } )
  vim.api.nvim_create_autocmd( "BufWritePost", {
    group = "MyDebug",
    pattern = { "*.lua" },
    callback = function() R( "obszczymucha.lua-test" ).run() end
  } )
end

M.setup()

return M
