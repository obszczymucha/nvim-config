local function add_file()
  local filetype = vim.api.nvim_get_option_value( "filetype", { buf = 0 } )
  local buf_name = vim.api.nvim_buf_get_name( 0 )

  if buf_name == "" or filetype == "harpoon" then return end

  require( "harpoon.mark" ).add_file()
  vim.notify( "[Harpoon: ]{purple}Added.", vim.log.levels.INFO, {
    title = "Harpoon",
  } )
end

return {
  "ThePrimeagen/harpoon",
  keys = {
    { "<A-a>", function() add_file() end, desc = "Add file to harpoon" },
    { "<A-f>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Harpoon quick menu" },
    { "<A-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", desc = "Harpoon file 1" },
    { "<A-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", desc = "Harpoon file 2" },
    { "<A-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", desc = "Harpoon file 3" },
    { "<A-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon file 4" },
    { "<A-5>", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", desc = "Harpoon file 5" },
    { "<A-6>", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>", desc = "Harpoon file 6" },
  },
  config = function()
    -- Configuration happens on first keypress
  end
}
