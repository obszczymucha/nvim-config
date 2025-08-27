---@class WindowToggle
---@field open_last fun()
local M = {}

local state = require( "obszczymucha.window-toggle.state" )
local utils = require( "obszczymucha.utils" )

---@type string[]
local ignore_filetypes = {
  "TelescopePrompt",
  "TelescopeResults",
  "ccc-ui",
  "cmp_menu",
  "fidget",
  "help",
  "noice",
  "notify",
  "oil",
  "wk",
}

---@class LastWindow
---@field buffer_id integer
---@field position WindowPosition
---@field cwd string
---@field cursor_pos integer[]

---@class WindowPosition
---@field type "main"|"right"|"left"|"below"|"above"
---@field size number|table

---@return WindowPosition|nil
local function get_window_position()
  local current_win = vim.api.nvim_get_current_win()
  local win_config = vim.api.nvim_win_get_config( current_win )

  if win_config.relative ~= "" then
    return nil
  end

  local current_pos = vim.api.nvim_win_get_position( current_win )
  local current_width = vim.api.nvim_win_get_width( current_win )
  local current_height = vim.api.nvim_win_get_height( current_win )
  local windows = vim.api.nvim_tabpage_list_wins( 0 )

  if #windows <= 1 then
    return { type = "main", size = { width = current_width, height = current_height } }
  end

  for _, win in ipairs( windows ) do
    if win ~= current_win then
      local other_pos = vim.api.nvim_win_get_position( win )
      local other_height = vim.api.nvim_win_get_height( win )

      if current_pos[ 1 ] == other_pos[ 1 ] and current_height == other_height then
        if current_pos[ 2 ] > other_pos[ 2 ] then
          return { type = "right", size = current_width }
        else
          return { type = "left", size = current_width }
        end
      end

      if current_pos[ 2 ] == other_pos[ 2 ] and current_width == vim.api.nvim_win_get_width( win ) then
        if current_pos[ 1 ] > other_pos[ 1 ] then
          return { type = "below", size = current_height }
        else
          return { type = "above", size = current_height }
        end
      end
    end
  end

  return { type = "right", size = current_width }
end

---@param position WindowPosition
---@param buffer_id integer Buffer ID to display in the split
---@param cwd string Working directory
local function create_split( position, buffer_id, cwd )
  local cmd = ({
    right = "rightbelow vertical split",
    left = "leftabove vertical split",
    below = "rightbelow split",
    above = "leftabove split"
  })[ position.type ] or "split"

  vim.cmd( cmd )
  vim.api.nvim_win_set_buf( 0, buffer_id )
  vim.cmd( "lcd " .. cwd )

  if position.type == "right" or position.type == "left" then
    vim.cmd( "vertical resize " .. position.size )
  else
    vim.cmd( "resize " .. position.size )
  end
end

local function save()
  local windows = vim.api.nvim_tabpage_list_wins( 0 )
  if #windows <= 1 then return end

  local position = get_window_position()
  if not position then return end

  state.last_window = {
    buffer_id = vim.api.nvim_win_get_buf( 0 ),
    position = position,
    cwd = utils.get_project_root_dir(),
    cursor_pos = vim.api.nvim_win_get_cursor( 0 )
  }
end

---@param buffer_id integer
---@param position WindowPosition
---@return boolean
local function is_buffer_in_position( buffer_id, position )
  local windows = vim.api.nvim_tabpage_list_wins( 0 )

  for _, win in ipairs( windows ) do
    if vim.api.nvim_win_get_buf( win ) == buffer_id then
      local saved_win = vim.api.nvim_get_current_win()
      vim.api.nvim_set_current_win( win )
      local current_position = get_window_position()
      vim.api.nvim_set_current_win( saved_win )

      if current_position and position and current_position.type == position.type then
        return true
      end
    end
  end

  return false
end

function M.open_last()
  if not state.last_window then return end
  if not vim.api.nvim_buf_is_valid( state.last_window.buffer_id ) then return end
  if is_buffer_in_position( state.last_window.buffer_id, state.last_window.position ) then return end

  create_split( state.last_window.position, state.last_window.buffer_id, state.last_window.cwd )
  vim.api.nvim_win_set_cursor( 0, state.last_window.cursor_pos )
  vim.cmd( "normal! zz" )
end

local function hook()
  local id = vim.api.nvim_create_augroup( "WindowToggleGroup", { clear = true } )

  vim.api.nvim_create_autocmd( "WinClosed", {
    group = id,
    ---@param data table
    callback = function( data )
      local buf = data.buf

      if buf and vim.api.nvim_buf_is_valid( buf ) then
        local filetype = vim.api.nvim_get_option_value( "filetype", { buf = buf } )
        if not filetype or filetype == "" or vim.tbl_contains( ignore_filetypes, filetype ) then return end

        local bufname = vim.api.nvim_buf_get_name( buf )
        if not bufname or bufname == "" then return end

        save()
      end
    end
  } )
end

hook()
vim.keymap.set( "n", "<A-0>", function() M.open_last() end, { desc = "Open last window" } )

return M
