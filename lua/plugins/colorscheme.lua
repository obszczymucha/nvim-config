local augroup = vim.api.nvim_create_augroup( "ColorschemeAutoReload", { clear = true } )

vim.api.nvim_create_autocmd( "BufWritePost", {
  group = augroup,
  pattern = "*/lua/plugins/colorscheme.lua",
  callback = function()
    vim.schedule( function()
      package.loaded[ "plugins.colorscheme" ] = nil
      package.loaded[ "obszczymucha.color-overrides" ] = nil
      require( "plugins.colorscheme" ).config()
      require( "obszczymucha.color-overrides" )
      vim.notify( "Colorscheme reloaded.", vim.log.levels.INFO )
    end )
  end
} )

return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require( 'kanagawa' ).setup( {
      compile = false,  -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,   -- do not set background color
      dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {             -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      ---@diagnostic disable-next-line: unused-local
      overrides = function( colors ) -- add/modify highlights
        return {
          Visual = { bg = "#3d3a7a" },
          Normal = { bg = "#1d1d26" },
          -- Telescope specific highlights
          TelescopeNormal = { bg = "#17101a" },  -- Main picker background
          TelescopeBorder = { bg = "#17101a", fg = "#4c4a69"},  -- Border color
          TelescopePromptNormal = { bg = "#17101a" },  -- Prompt background
          -- TelescopePromptBorder = { bg = "#16161d", fg = "#9f7fff" },
          -- -- TelescopePromptTitle = { bg = "#9f7fff", fg = "#16161d" },
          -- -- TelescopePreviewTitle = { bg = "#9f7fff", fg = "#16161d" },
          -- -- TelescopeResultsTitle = { bg = "#9f7fff", fg = "#16161d" },
          -- TelescopeSelection = { bg = "#2d2d4f" },  -- Selected item background
          -- TelescopeSelectionCaret = { fg = "#fabd2f" },  -- Caret color
        }
      end,
      theme = "wave",  -- Load "wave" theme when 'background' option is not set
      background = {   -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus"
      },
    } )

    vim.cmd( "colorscheme kanagawa" )
  end
}
