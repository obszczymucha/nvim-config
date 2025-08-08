local function add_file()
  local filetype = vim.api.nvim_get_option_value( "filetype", { buf = 0 } )
  local buf_name = vim.api.nvim_buf_get_name( 0 )

  if buf_name == "" or filetype == "harpoon" then return end

  require( "harpoon.mark" ).add_file()
  vim.notify( "@lsp.type.variable@Harpoon:@@ Added.", vim.log.levels.INFO, {
    title = "Harpoon",
  } )
end

return {
  "ThePrimeagen/harpoon",
  config = function()
    vim.keymap.set( "n", "<A-a>", add_file, { silent = true } )
    vim.keymap.set( "n", "<A-f>", [[:lua require( "harpoon.ui" ).toggle_quick_menu()<CR>]], { silent = true } )
    vim.keymap.set( "n", "<A-1>", [[:lua require( "harpoon.ui" ).nav_file( 1 )<CR>]], { silent = true } )
    vim.keymap.set( "n", "<A-2>", [[:lua require( "harpoon.ui" ).nav_file( 2 )<CR>]], { silent = true } )
    vim.keymap.set( "n", "<A-3>", [[:lua require( "harpoon.ui" ).nav_file( 3 )<CR>]], { silent = true } )
    vim.keymap.set( "n", "<A-4>", [[:lua require( "harpoon.ui" ).nav_file( 4 )<CR>]], { silent = true } )
    vim.keymap.set( "n", "<A-5>", [[:lua require( "harpoon.ui" ).nav_file( 5 )<CR>]], { silent = true } )
    vim.keymap.set( "n", "<A-6>", [[:lua require( "harpoon.ui" ).nav_file( 6 )<CR>]], { silent = true } )
  end,
  lazy = false
}
