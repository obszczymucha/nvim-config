return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "L3MON4D3/LuaSnip",
        lazy = false,
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require( "luasnip.loaders.from_vscode" ).lazy_load()
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      {
        "zbirenbaum/copilot-cmp",
        lazy = false,
        config = function()
          require( "copilot_cmp" ).setup( {
            suggestion = { enabled = false },
            panel = { enabled = false },
          } )
        end
      }
    },
    config = function() require( "obszczymucha.cmp" ) end
  }
}
