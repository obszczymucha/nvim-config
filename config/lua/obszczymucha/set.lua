local o = vim.opt
local g = vim.g
local api = vim.api
local cmd = vim.cmd

cmd( "syntax on" )

o.nu = true
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "number"
o.guicursor = 'n-c:block,i:block-iCursor,r:block-rCursor,v:block-vCursor'

cmd( "hi Cursor guifg=white guibg=black" )
cmd( "hi iCursor guifg=white guibg=steelblue" )
cmd( "hi rCursor guifg=white guibg=#f7768e" )
cmd( "hi vCursor guifg=white guibg=#9d7cd8" )

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smarttab = true
o.hlsearch = false
o.incsearch = true

o.smartindent = true

o.wrap = false

g.mapleader = " "

g.airline_theme = "deus"
g.airline_symbols = { colnr = "c:", linenr = " l:" }
g.airline_powerline_fonts = 1

api.nvim_create_user_command( "Conf", "cd ~/.config/nvim | lua require( 'harpoon.ui' ).nav_file( 1 )", {} )
cmd( "cnoreabbrev H vert bo h" )

