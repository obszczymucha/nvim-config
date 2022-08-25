local M = {}
local api = vim.api
local cmd = vim.cmd
local g = vim.g
local ends_with = require( "obszczymucha.common" ).ends_with

local netrw_command = "Vex!"

g.netrw_liststyle = 3
g.netrw_banner = 0
g.netrw_browse_split = 4
--g.netrw_altv = 1
g.netrw_winsize = -35
--g.netrw_fastbrowse = 0

-- This is a way to create autocmd in lua:
-- local netrw_hide_group = api.nvim_create_augroup("NETRW_HIDE", { clear = true })
--
-- api.nvim_create_autocmd("BufWinEnter", {
--   group = netrw_hide_group,
--   callback = function(args)
--     print("chuj", args)
--   end,
--   desc = "hide netrw after opening a file",
-- })

g.netrw_bufsettings = "noma nomod nonu nobl nowrap rnu"

local is_buf_netrw = function( buf )
  local name = api.nvim_buf_get_name( buf )
  return ends_with( name, "NetrwTreeListing" )
end

local is_current_buf_netrw = function()
  local buf = api.nvim_get_current_buf()
  return is_buf_netrw( buf )
end

-- Returns the handle if it's loaded or nil
local get_netrw_buf_handle = function()
  local bufs = api.nvim_list_bufs()

  for _, v in pairs( bufs ) do
    if api.nvim_buf_is_loaded( v ) and is_buf_netrw( v ) then
      return v
    end
  end

  return nil
end

M.toggle_netrw = function()
  local was_deleted = false
  local bufs = api.nvim_list_bufs()

  for _, v in pairs( bufs ) do
    if api.nvim_buf_is_loaded( v ) and is_buf_netrw( v ) then
      api.nvim_buf_delete( v, { force = true } )
      was_deleted = true
    end
  end

  if was_deleted then return end

  vim.cmd( netrw_command )
end

local activate_window = function( buf )
  local wins = api.nvim_list_wins()

  for _, win in pairs( wins ) do
    local current_buf = api.nvim_win_get_buf( win )

    if current_buf == buf then
      api.nvim_set_current_win( win )
      return
    end
  end
end

M.run_vinegar = function()
  if is_current_buf_netrw() then
    cmd('silent! execute "normal\\<Plug>VinegarUp"')
    return
  end

  local netrw_buf = get_netrw_buf_handle()

  if netrw_buf then
    activate_window( netrw_buf )
    return
  end

  vim.cmd( netrw_command )
end

return M

