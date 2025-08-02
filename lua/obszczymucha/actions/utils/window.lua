local M = {}

function M.count_visible_windows()
  local visible_count = 0

  for _, win_id in ipairs( vim.api.nvim_tabpage_list_wins( 0 ) ) do
    local win_config = vim.api.nvim_win_get_config( win_id )
    if win_config.relative == "" then
      visible_count = visible_count + 1
    end
  end

  return visible_count
end

return M

