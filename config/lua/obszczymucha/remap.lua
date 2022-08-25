local nnoremap = require( "obszczymucha.keymap" ).nnoremap

local netrw = function( functionName )
  return string.format( '<cmd>lua require( "obszczymucha.netrw" ).%s()<CR>', functionName )
end

nnoremap( "<M-Esc>", netrw( "toggle_netrw" ) )
nnoremap( "-", netrw( "run_vinegar" ) )
nnoremap( "<leader>ff", "<cmd>Telescope find_files<CR>" )
nnoremap( "<leader>fg", "<cmd>Telescope live_grep<CR>" )
nnoremap( "<leader>fb", "<cmd>Telescope buffers<CR>" )
nnoremap( "<leader>fh", "<cmd>Telescope help_tags<CR>" )

nnoremap( "<A-v>", "<C-w>v<C-w>w" )
nnoremap( "<A-V>", "<C-w>v<C-w>w<cmd>Telescope find_files<CR>" )
nnoremap( "<A-s>", "<C-w>s<C-w>w" )
nnoremap( "<A-S>", "<C-w>s<C-w>w<cmd>Telescope find_files<CR>" )
nnoremap( "<A-j>", "<C-w>j" )
nnoremap( "<A-k>", "<C-w>k" )
nnoremap( "<A-h>", "<C-w>h" )
nnoremap( "<A-l>", "<C-w>l" )

nnoremap( "<A-q>", "<cmd>q<CR>" )

nnoremap( "<A-`>", [[:lua require( "harpoon.mark" ).add_file()<CR>]] )
nnoremap( "``", [[:lua require( "harpoon.ui" ).toggle_quick_menu()<CR>]] )
nnoremap( "<A-1>", [[:lua require( "harpoon.ui" ).nav_file( 1 )<CR>]] )
nnoremap( "<A-2>", [[:lua require( "harpoon.ui" ).nav_file( 2 )<CR>]] )
nnoremap( "<A-3>", [[:lua require( "harpoon.ui" ).nav_file( 3 )<CR>]] )
nnoremap( "<A-4>", [[:lua require( "harpoon.ui" ).nav_file( 4 )<CR>]] )

