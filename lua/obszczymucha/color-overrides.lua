local cmd = vim.cmd
local saturate = require( "obszczymucha.utils" ).saturate

cmd( "autocmd ColorScheme * hi CursorLineNr ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=None" )
cmd( "autocmd ColorScheme * hi LineNr ctermfg=11 guifg=#4b5271" )
cmd( "autocmd ColorScheme * hi Shebang ctermfg=red ctermbg=black guifg=#ff0000" )
cmd( "autocmd ColorScheme * syntax match Shebang /#!.*/" )

-- Override lspsaga's colors
cmd( "autocmd ColorScheme * highlight LspFloatWinNormal guibg=NONE" )

local purple = "#9f7fff"
local light_purple = saturate( purple, 0.6 )
local light_purple2 = saturate( purple, 0.9 )

vim.cmd( string.format( "highlight ActionsTelescopeBorder guifg=%s", light_purple ) )

vim.api.nvim_set_hl( 0, "NotifyINFOIcon", { fg = "#aaaaff" } )


local function set_notify_highlights( prefix, color )
  local info_highlights = { "Title", "Border", "Body" }

  for _, suffix in ipairs( info_highlights ) do
    vim.api.nvim_set_hl( 0, prefix .. suffix, { fg = color } )
  end
end

set_notify_highlights( "NotifyINFO", light_purple2 )
