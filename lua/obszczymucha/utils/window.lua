local M = {}

---@return number?
function M.get_last_visible_win_id()
  local windows = vim.api.nvim_list_wins()
  local win_ids = {}

  for _, win_id in ipairs( windows ) do
    if vim.api.nvim_win_is_valid( win_id ) then
      local win_config = vim.api.nvim_win_get_config( win_id )

      if win_config.relative == "" then
        table.insert( win_ids, win_id )
      end
    end
  end

  if #win_ids > 1 then
    return win_ids[ #win_ids ]
  else
    return nil
  end
end

return M
