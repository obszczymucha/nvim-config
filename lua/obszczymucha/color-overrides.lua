local cmd = vim.cmd
local schemes = require("obszczymucha.colorscheme.schemes")
local config = require("obszczymucha.user-config")

local function apply_color_overrides()
  local scheme_name = config.get_colorscheme()
  local colors = schemes.get_custom_colors(scheme_name)

  cmd( string.format( "hi CursorLineNr ctermfg=214 ctermbg=237 guifg=%s guibg=None", colors.cursor_line ) )
  cmd( string.format( "hi LineNr ctermfg=11 guifg=%s", colors.line_number ) )
  cmd( "hi Shebang ctermfg=red ctermbg=black guifg=#ff0000" )
  cmd( "syntax match Shebang /#!.*/" )
  cmd( "highlight LspFloatWinNormal guibg=NONE" )

  cmd( string.format( "hi WinSeparator guifg=%s guibg=NONE", colors.dark_accent ) )
  cmd( string.format( "hi accent guifg=%s", colors.accent ) )
  cmd( string.format( "hi light-accent guifg=%s", colors.light_accent ) )
  cmd( string.format( "hi light-blue guifg=%s", colors.light_blue ) )

  cmd( string.format( "highlight ActionsTelescopeBorder guifg=%s", colors.light_accent ) )

  local function set_notify_highlights( prefix, suffixes, color )
    for _, suffix in ipairs( suffixes ) do
      vim.api.nvim_set_hl( 0, prefix .. suffix, { fg = color } )
    end
  end

  set_notify_highlights( "NotifyINFO", { "Title", "Border" }, colors.notify_info_border )
  set_notify_highlights( "NotifyINFO", { "Icon", "Body" }, colors.notify_info_body )
end

cmd( "autocmd ColorScheme * lua require('obszczymucha.color-overrides').apply()" )

return { apply = apply_color_overrides }
