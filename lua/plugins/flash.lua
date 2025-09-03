return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = {
      multi_window = true
    },
    modes = {
      search = {
        enabled = true,
        highlight = { backdrop = false },
        jump = { history = true, register = true, nohlsearch = true }
      }
    }
  },
  -- stylua: ignore
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require( "flash" ).jump() end,              desc = "Flash" },
    { "<A-v>", mode = { "n", "x", "o" }, function() require( "flash" ).treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require( "flash" ).remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require( "flash" ).treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require( "flash" ).toggle() end,            desc = "Toggle Flash Search" },
  },
}
