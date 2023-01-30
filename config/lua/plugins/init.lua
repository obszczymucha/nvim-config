return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require( "tokyonight" ).setup( {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value `:help attr-list`
          comments = "italic",
          keywords = "italic",
          functions = "NONE",
          variables = "NONE",
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        -- You can override specific color groups to use other groups or a hex color
        -- fucntion will be called with a ColorScheme table
        --@param colors ColorScheme
        ---@diagnostic disable-next-line: unused-local
        on_colors = function( colors ) end,

        -- You can override specific highlights to use other groups or a hex color
        -- function will be called with a Highlights and ColorScheme table
        --@param highlights Highlights
        --@param colors ColorScheme
        ---@diagnostic disable-next-line: unused-local
        on_highlights = function( highlights, colors ) end,
      } )

      -- load the colorscheme here
      vim.cmd( [[colorscheme tokyonight]] )
    end,
  },
  { "MunifTanjim/nui.nvim" },
  { "ThePrimeagen/harpoon" },
  { "folke/noice.nvim" },
  { "glepnir/lspsaga.nvim", version = "main" },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-nvim-lua", lazy = true },
  { "hrsh7th/cmp-vsnip", lazy = true },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/vim-vsnip", lazy = true },
  { "j-hui/fidget.nvim", lazy = true },
  { "jenterkin/vim-autosource" },
  { "kyazdani42/nvim-web-devicons", lazy = true },
  { "neovim/nvim-lspconfig" },
  { "nvim-lua/lsp-status.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", lazy = true },
  { "nvim-telescope/telescope.nvim", version = "0.1.1" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "nvim-treesitter/nvim-treesitter-textobjects", build = ":TSUpdate" },
  { "nvim-treesitter/playground" },
  { "preservim/nerdcommenter" },
  { "psliwka/vim-smoothie" },
  { "rcarriga/nvim-notify" },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "williamboman/mason.nvim", lazy = true },
  { "windwp/nvim-autopairs" },
  { "rcarriga/nvim-dap-ui" },
  { "mfussenegger/nvim-dap", lazy = true },
  { "scalameta/nvim-metals" },
  { "https://github.com/mbbill/undotree" },
  { "kevinhwang91/nvim-bqf" },
  { "mfussenegger/nvim-jdtls" },
  { "mfussenegger/nvim-treehopper" }
}
