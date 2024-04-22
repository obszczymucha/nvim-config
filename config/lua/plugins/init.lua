return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require( "tokyonight" ).setup( {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm",        -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
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
      } )

      -- load the colorscheme here
      vim.cmd( [[colorscheme tokyonight]] )
    end,
  },
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {},                             -- required even with default settings, since it calls `setup()`
  },
  { "MunifTanjim/nui.nvim" },
  { "ThePrimeagen/harpoon" },
  { "f-person/git-blame.nvim", lazy = false },
  { "folke/noice.nvim" },
  { "folke/neodev.nvim",       opts = {} },
  { "nvimdev/lspsaga.nvim",    event = "LspAttach" },
  {
    "hrsh7th/vim-vsnip",
    lazy = false,
    dependencies = { "rafamadriz/friendly-snippets" }
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help"
    }
  },
  { "https://github.com/mbbill/undotree", lazy = false },
  { "j-hui/fidget.nvim" },
  { "jenterkin/vim-autosource" },
  { "kevinhwang91/nvim-bqf" },
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
  { "marilari88/twoslash-queries.nvim" },
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-jdtls" },
  { "mfussenegger/nvim-treehopper" },
  { "neovim/nvim-lspconfig" },
  { "nvim-lua/lsp-status.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim" },
  { "nvim-telescope/telescope.nvim",             version = "0.1.x" },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      name = "nvim-tree-web-devicons"
    },
    config = function()
      require( "nvim-tree" ).setup {
        view = {
          number = true,
          relativenumber = true
        }
      }
    end,
  },
  { "nvim-treesitter/nvim-treesitter",             build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "nvim-treesitter/nvim-treesitter-textobjects", build = ":TSUpdate",                                                lazy = false },
  { "nvim-treesitter/playground",                  lazy = false },
  { "preservim/nerdcommenter",                     lazy = false },
  { "psliwka/vim-smoothie",                        lazy = false },
  { "rcarriga/nvim-dap-ui",                        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  { "rcarriga/nvim-notify" },
  { "scalameta/nvim-metals" },
  { "tpope/vim-fugitive",                          lazy = false },
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
  { "airblade/vim-matchquote",           lazy = false },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn[ "mkdp#util#install" ]() end,
    config = function()
      if is_wsl then
        vim.cmd [[
          function! OpenMarkdownPreview(url)
            execute "silent !brave --app=" . a:url
          endfunction
        ]]
      else
        vim.cmd [[
          function! OpenMarkdownPreview(url)
            execute "silent !chromium --app=" . a:url
          endfunction
        ]]
      end

      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end
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
  }
}
