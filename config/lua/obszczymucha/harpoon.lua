local M = {}

function M.add_file()
  local buf_name = vim.api.nvim_buf_get_name( 0 )
  if buf_name == "" then
    print( "Harpoon: Can't add - buffer is empty." )
  else
    require( "harpoon.mark" ).add_file()
    print( "Harpoon: Added." )
  end
end

return M

