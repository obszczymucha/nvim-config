local M = {}

function M.get_selection()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
  
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  
  if start_pos[2] == end_pos[2] then
    local line = vim.fn.getline(start_pos[2])
    return string.sub(line, start_pos[3], end_pos[3])
  else
    return nil
  end
end

return M