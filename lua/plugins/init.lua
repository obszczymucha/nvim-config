return {
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
  { "RRethy/nvim-treesitter-endwise", event = "InsertEnter" }
}
