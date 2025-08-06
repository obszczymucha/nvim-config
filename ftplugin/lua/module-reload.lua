vim.keymap.set( "n", "<leader>R", ":lua require('obszczymucha.lua-module').reload_current()<CR>",
  { silent = true, desc = "Reload current Lua module" } )
