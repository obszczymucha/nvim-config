local g = vim.g
local o = vim.opt
local cmd = vim.cmd

g.tokyonight_transparent_sidebar = true
g.tokyonight_transparent = true
o.background = "dark"

cmd( "autocmd ColorScheme * hi CursorLineNr ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=None" )
cmd( "autocmd ColorScheme * hi LineNr ctermfg=11 guifg=#4b5271" )
cmd( "autocmd ColorScheme * hi Shebang ctermfg=red ctermbg=black guifg=#ff0000" )
cmd( "autocmd ColorScheme * syntax match Shebang /#!.*/" )
cmd( "colorscheme tokyonight" )

