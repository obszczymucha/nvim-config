return {
  -- the colorscheme should be available when starting Neovim
  {
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
            Normal = { bg = "#202030" }
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
  },
  { "MunifTanjim/nui.nvim" },
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
  { "mfussenegger/nvim-jdtls" },
  { "neovim/nvim-lspconfig" },
  { "nvim-lua/plenary.nvim" },
  -- { "nvim-treesitter/nvim-treesitter-context" },
  { "nvim-treesitter/nvim-treesitter-textobjects", build = ":TSUpdate",                                                ft = { "lua", "python", "javascript", "typescript", "rust", "go", "java", "scala" } },
  { "psliwka/vim-smoothie",                        event = "VeryLazy" },
  { "rcarriga/nvim-dap-ui",                        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  { "tpope/vim-fugitive",                          cmd = "Git" },
  { "williamboman/mason-lspconfig.nvim" },
  { "williamboman/mason.nvim" },
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
  { "jbyuki/one-small-step-for-vimkind", ft = "lua" }, -- :help osv -> QUICKSTART
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
    version = '^6', -- Recommended
    ft = "rust"     -- Load only for Rust files
  },
  { "rhysd/git-messenger.vim",        keys = { { "<leader>gm", "<cmd>GitMessenger<cr>", desc = "Git messenger" } } },
  { "RRethy/nvim-treesitter-endwise", event = "InsertEnter" }
}
