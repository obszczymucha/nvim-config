return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = true,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      transparent = true,     -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value `:help attr-list`
        comments = "italic",
        keywords = "italic",
        functions = "NONE",
        variables = "NONE",
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent",       -- style for sidebars, see below
        floats = "dark",                -- style for floating windows
      },
      sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false,             -- dims inactive windows
      lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold
      -- You can override specific color groups to use other groups or a hex color
      -- fucntion will be called with a ColorScheme table
      --@param colors ColorScheme
      ---@diagnostic disable-next-line: unused-local
      on_colors = function( colors )
      end,
      -- You can override specific highlights to use other groups or a hex color
      -- function will be called with a Highlights and ColorScheme table
      --@param highlights Highlights
      --@param colors ColorScheme
      ---@diagnostic disable-next-line: unused-local
      on_highlights = function( highlights, colors )
      end,
    },
    config = function()
      vim.cmd( [[colorscheme tokyonight-moon]] )
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
      require( 'kanagawa' ).setup( {
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        ---@diagnostic disable-next-line: unused-local
        overrides = function( colors ) -- add/modify highlights
          return {}
        end,
        theme = "wave",  -- Load "wave" theme when 'background' option is not set
        background = {   -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus"
        },
      } )

      vim.cmd( "colorscheme kanagawa" )
    end
  },
  { "MunifTanjim/nui.nvim" },
  { "ThePrimeagen/harpoon" },
  { "https://github.com/mbbill/undotree", lazy = false },
  { "jenterkin/vim-autosource" },
  { "kyazdani42/nvim-web-devicons" },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require( "nvim-surround" ).setup( {
        -- Configuration here, or leave empty to use defaults
      } )
    end
  },
  { "marilari88/twoslash-queries.nvim" }, -- Uses ^ to show info
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-jdtls" },
  { "neovim/nvim-lspconfig" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim",    build = "make",                                                     lazy = false },
  { "nvim-telescope/telescope-dap.nvim" },
  { "nvim-telescope/telescope.nvim",               branch = "0.1.x" },
  -- { "nvim-treesitter/nvim-treesitter-context" },
  { "nvim-treesitter/nvim-treesitter-textobjects", build = ":TSUpdate",                                                lazy = false },
  { "psliwka/vim-smoothie",                        lazy = false },
  { "rcarriga/nvim-dap-ui",                        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  { "rcarriga/nvim-notify",                        lazy = false },
  { "tpope/vim-fugitive",                          cmd = "Git" },
  { "williamboman/mason-lspconfig.nvim" },
  { "williamboman/mason.nvim" },
  { "windwp/nvim-autopairs" },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  { "jbyuki/one-small-step-for-vimkind", lazy = false }, -- :help osv -> QUICKSTART
  {
    "AckslD/nvim-neoclip.lua",
    lazy = false,
    dependencies = {
      "kkharji/sqlite.lua"
    },
    config = function()
      require( "neoclip" ).setup( {
        enable_persistent_history = true
      } )
    end,
  },
  -- Causing errors in checkhealth.
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = {
      vim.keymap.set( "n", "<leader>vf", function() require( "zen-mode" ).toggle( { window = { width = 1 } } ) end,
        { silent = true, desc = "Fullscreen" } )
    }
  },
  -- {
  --   "jinh0/eyeliner.nvim",
  --   config = function()
  --     require( "eyeliner" ).setup {
  --       highlight_on_key = true,
  --       dim = true
  --     }
  --   end,
  --   lazy = false
  -- },
  { "folke/neoconf.nvim" },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  { "rhysd/git-messenger.vim",        lazy = false },
  { "RRethy/nvim-treesitter-endwise", lazy = false }
}
