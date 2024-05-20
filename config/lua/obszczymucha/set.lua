local o = vim.opt
local g = vim.g
local api = vim.api
local cmd = vim.cmd

cmd( "syntax on" )

o.nu = true
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "line,number"
o.guicursor = 'n-c:block,i:block-iCursor,r:block-rCursor,v:block-vCursor'

cmd( "hi Cursor guifg=white guibg=black" )
cmd( "hi iCursor guifg=white guibg=#30d0d0" )
cmd( "hi rCursor guifg=white guibg=#f7768e" )
cmd( "hi vCursor guifg=white guibg=#9d7cd8" )
cmd( "hi CursorLine guibg=#12122c" )

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smarttab = true
o.hlsearch = false
o.incsearch = true
o.smartindent = true
o.wrap = false
o.splitright = true
o.fileformats = { 'unix', 'dos', 'mac' }
o.ignorecase = true -- Enables case insensitive autocompletion (and search).
o.smartcase = true  -- Makes search case sensitive if there are capital letters in the pattern.

g.mapleader = " "
g.airline_theme = "deus"
g.airline_symbols = { colnr = "c:", linenr = " l:" }
g.airline_powerline_fonts = 1

if not is_windows then
  api.nvim_create_user_command( "Conf", "cd ~/.config/nvim | lua require( 'harpoon.ui' ).nav_file( 1 )", {} )
end

cmd( "cnoreabbrev H vert bo h" )

g.smoothie_no_default_mappings = true
g.AutoPairsShortcutFastWrap = ""
g.AutoPairsShortcutToggle = "<C-p>"

-- Broken - throws errors on some files.
--cmd( "set viewoptions-=options" )
--cmd( "autocmd BufWinLeave *.* mkview" )
--cmd( "autocmd BufWinEnter *.* silent loadview" )

o.swapfile = false
o.backup = false

if not is_windows then
  o.undodir = os.getenv( "HOME" ) .. "/.vim/undodir"
end

o.undofile = true

vim.cmd [[command! HarpoonFirst lua local harpoon=prequire( "harpoon.ui" ); if harpoon then harpoon.nav_file( 1 ) end]]

-- NERDCommenter
g.NERDCustomDelimiters = {
  gradle = {
    left = "// "
  },
  groovy = {
    left = "// "
  },
  java = {
    left = "// ",
    leftAlt = "/*",
    rightAlt = "*/"
  },
  lua = {
    left = "-- "
  }
}

vim.cmd( [[autocmd BufEnter,BufWinEnter,FileType * lua require("obszczymucha.common").disable_comment_continuation()]] )
