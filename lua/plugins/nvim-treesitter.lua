return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require( "nvim-treesitter" ).install {
        "c",
        "lua",
        "rust",
        "javascript",
        "scala",
        "haskell",
        "java",
        "query",
        "regex",
        "markdown_inline",
        "vim",
        "markdown"
      }
    end
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require( "treesitter-modules" ).setup {
        highlight = {
          enable = true,
          disable = { "c", "rust" },
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
      }
    end
  }
}
