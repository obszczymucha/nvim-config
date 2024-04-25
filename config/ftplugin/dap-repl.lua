vim.keymap.set( "i", "<M-k>", "<cmd>lua require('dap.repl').on_up()<CR>", { silent = true, noremap = true, desc = "Up" } )
vim.keymap.set( "i", "<M-j>", "<cmd>lua require('dap.repl').on_down()<CR>",
  { silent = true, noremap = true, desc = "Down" } )
