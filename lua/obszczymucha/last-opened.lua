local M = {}

local config = require( "obszczymucha.user-config" )

local group = vim.api.nvim_create_augroup( "LastOpened", { clear = true } )

local function on_leave_pre()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name( bufnr )

  if not bufname or bufname:match( "^oil:///" ) then return end

  local cursor = vim.api.nvim_win_get_cursor( 0 )
  local data = {
    filename = bufname,
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
    if not data or not data.filename or vim.fn.filereadable( data.filename ) == 0 then return end

    vim.defer_fn( function()
      vim.cmd( "edit " .. data.filename )

      local buf = vim.api.nvim_win_get_buf( 0 )
      local line_count = vim.api.nvim_buf_line_count( buf )
      local target_line = data.line - 1

      if target_line >= line_count then return end

      local line = vim.api.nvim_buf_get_lines( buf, target_line, target_line + 1, true )[ 1 ]
      local target_col = data.col - 1

      if target_col > #line then return end

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
