-- Seems like <M-j> and <M-k> is required for Alt to work under WSL2.
vim.keymap.set( "i", "<M-k>", "<cmd>lua require('dap.repl').on_up()<CR>", { silent = true, noremap = true, desc = "Up" } )
vim.keymap.set( "i", "<M-j>", "<cmd>lua require('dap.repl').on_down()<CR>",
  { silent = true, noremap = true, desc = "Down" } )

-- These below work on linux as intended.
vim.keymap.set( "i", "<A-k>", "<cmd>lua require('dap.repl').on_up()<CR>", { silent = true, noremap = true, desc = "Up" } )
vim.keymap.set( "i", "<A-j>", "<cmd>lua require('dap.repl').on_down()<CR>",
  { silent = true, noremap = true, desc = "Down" } )
