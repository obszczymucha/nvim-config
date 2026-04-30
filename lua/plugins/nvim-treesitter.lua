return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
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
        "markdown",
        "python",
        "bash",
        "zsh"
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd( { "FileType" }, {
        pattern = "*",
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          pcall( vim.treesitter.start, buf )
        end
      } )
    end
  },
}
