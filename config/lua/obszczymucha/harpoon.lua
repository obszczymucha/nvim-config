local M = {}

function M.add_file()
  local buf_name = vim.api.nvim_buf_get_name( 0 )
  if buf_name == "" then
    vim.notify( "Harpoon: Can't add - buffer is empty." )
  else
    require( "harpoon.mark" ).add_file()
    vim.notify( "Harpoon: Added." )
  end
end

return M

