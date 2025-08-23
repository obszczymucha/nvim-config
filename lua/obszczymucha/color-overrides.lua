local cmd = vim.cmd
local utils = require( "obszczymucha.utils" )
local saturate, brightness = utils.saturate, utils.brightness

cmd( "autocmd ColorScheme * hi CursorLineNr ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=None" )
cmd( "autocmd ColorScheme * hi LineNr ctermfg=11 guifg=#4b5271" )
cmd( "autocmd ColorScheme * hi Shebang ctermfg=red ctermbg=black guifg=#ff0000" )
cmd( "autocmd ColorScheme * syntax match Shebang /#!.*/" )

-- Override lspsaga's colors
cmd( "autocmd ColorScheme * highlight LspFloatWinNormal guibg=NONE" )

local purple = "#9f7fff"
local light_purple = saturate( purple, 0.6 )
local light_purple2 = saturate( purple, 0.9 )
local dark_purple = brightness( purple, 0.4 )

cmd( string.format( "hi WinSeparator guifg=%s guibg=NONE", dark_purple ) )
-- cmd( string.format( "hi purple guifg=%s", purple ) )

vim.cmd( string.format( "highlight ActionsTelescopeBorder guifg=%s", light_purple ) )

local function set_notify_highlights( prefix, suffixes, color )
  for _, suffix in ipairs( suffixes ) do
    vim.api.nvim_set_hl( 0, prefix .. suffix, { fg = color } )
  end
end

set_notify_highlights( "NotifyINFO", { "Title", "Border" }, light_purple2 )
set_notify_highlights( "NotifyINFO", { "Icon", "Body" }, "#b9c0eb" )
