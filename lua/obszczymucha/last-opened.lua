local M = {}

local config = require( "obszczymucha.user-config" )
local state = require( "obszczymucha.state.last-opened" )
local utils = require( "obszczymucha.utils" )

local ignore_filetypes = { "codecompanion", "oil", "qf", "query" }

local group = vim.api.nvim_create_augroup( "LastOpened", { clear = true } )

local function on_buf_leave()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_get_option_value( "filetype", { buf = bufnr } )

  if vim.tbl_contains( ignore_filetypes, filetype ) then return end

  local bufname = vim.api.nvim_buf_get_name( bufnr )
  local cursor = vim.api.nvim_win_get_cursor( 0 )

  if not filetype or filetype == "" then return end

  state.last_buffer = {
    name = bufname,
    filetype = filetype,
    path = vim.fn.expand( bufname ),
    line = cursor[ 1 ],
    col = cursor[ 2 ]
  }
end

vim.api.nvim_create_autocmd( "BufLeave", {
  group = group,
  callback = on_buf_leave
} )

local function on_leave_pre()
  on_buf_leave()
  if not state.last_buffer then return end
  local project_root = utils.get_project_root_dir()
  if project_root == vim.fn.expand( "~" ) then return end

  config.set_local( "last-opened", state.last_buffer )
end

vim.api.nvim_create_autocmd( "VimLeavePre", {
  group = group,
  callback = on_leave_pre
} )

local function on_enter()
  if vim.fn.argc() > 0 then return end

  local data = config.get_local( "last-opened" )
  if not data or not data.path or vim.fn.filereadable( data.path ) == 0 then return end

  vim.schedule( function()
    vim.cmd( "edit " .. data.path )

    local buf = vim.api.nvim_win_get_buf( 0 )
    local line_count = vim.api.nvim_buf_line_count( buf )
    local target_line = data.line - 1

    if target_line >= line_count then return end

    local line = vim.api.nvim_buf_get_lines( buf, target_line, target_line + 1, true )[ 1 ]
    local target_col = data.col - 1

    if target_col > #line then return end

    if data.line and data.col then
      vim.api.nvim_win_set_cursor( 0, { data.line, data.col } )
      vim.cmd( "normal! zz" )
    end
  end )
end

vim.api.nvim_create_autocmd( "VimEnter", {
  group = group,
  callback = on_enter
} )

return M
