local M = {}

local hidden_window = {
  buffer_id = nil,
  position = nil,
  size = nil
}

local function get_window_position()
  local current_win = vim.api.nvim_get_current_win()
  local win_config = vim.api.nvim_win_get_config( current_win )

  if win_config.relative ~= '' then
    return nil
  end

  local current_pos = vim.api.nvim_win_get_position( current_win )
  local current_width = vim.api.nvim_win_get_width( current_win )
  local current_height = vim.api.nvim_win_get_height( current_win )
  local windows = vim.api.nvim_tabpage_list_wins( 0 )

  if #windows <= 1 then
    return { type = 'main', size = { width = current_width, height = current_height } }
  end

  for _, win in ipairs( windows ) do
    if win ~= current_win then
      local other_pos = vim.api.nvim_win_get_position( win )
      local other_height = vim.api.nvim_win_get_height( win )

      if current_pos[ 1 ] == other_pos[ 1 ] and current_height == other_height then
        if current_pos[ 2 ] > other_pos[ 2 ] then
          return { type = 'right', size = current_width }
        else
          return { type = 'left', size = current_width }
        end
      end

      if current_pos[ 2 ] == other_pos[ 2 ] and current_width == vim.api.nvim_win_get_width( win ) then
        if current_pos[ 1 ] > other_pos[ 1 ] then
          return { type = 'below', size = current_height }
        else
          return { type = 'above', size = current_height }
        end
      end
    end
  end

  return { type = 'right', size = current_width }
end

local function create_split( position, buffer_id )
  local cmd = ({
    right = 'rightbelow vertical split',
    left = 'leftabove vertical split',
    below = 'rightbelow split',
    above = 'leftabove split'
  })[ position.type ] or 'split'

  vim.cmd( cmd )
  vim.api.nvim_win_set_buf( 0, buffer_id )

  if position.type == 'right' or position.type == 'left' then
    vim.cmd( 'vertical resize ' .. position.size )
  else
    vim.cmd( 'resize ' .. position.size )
  end
end

function M.close()
  local windows = vim.api.nvim_tabpage_list_wins( 0 )
  if #windows <= 1 then return end

  hidden_window.buffer_id = vim.api.nvim_win_get_buf( 0 )
  hidden_window.position = get_window_position()

  vim.cmd( 'close' )
end

function M.open_last()
  if not hidden_window.buffer_id or not vim.api.nvim_buf_is_valid( hidden_window.buffer_id ) then
    return
  end

  create_split( hidden_window.position, hidden_window.buffer_id )
end

return M
