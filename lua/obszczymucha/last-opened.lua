local M = {}

local config = require( "obszczymucha.user-config" )

local group = vim.api.nvim_create_augroup( "LastOpened", { clear = true } )

local function on_leave_pre()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor( 0 )
  local data = {
    filename = vim.api.nvim_buf_get_name( bufnr ),
    line = cursor[ 1 ],
    col = cursor[ 2 ]
  }

  config.set_local( "last-opened", data )
end

vim.api.nvim_create_autocmd( "VimLeavePre", {
  group = group,
  callback = on_leave_pre
} )

local function on_enter()
  if vim.fn.argc() == 0 then
    local data = config.get_local( "last-opened" )
    if not data or not data.filename then return end

    vim.defer_fn( function()
      vim.cmd( "edit " .. data.filename )

      if data.line and data.col then
        vim.api.nvim_win_set_cursor( 0, { data.line, data.col } )
      end
    end, 10 )
  end
end

vim.api.nvim_create_autocmd( "VimEnter", {
  group = group,
  callback = on_enter
} )
return M
