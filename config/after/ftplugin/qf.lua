vim.api.nvim_buf_set_keymap( 0, "n", "<C-q>", ":cclose<CR>",
  { noremap = true, silent = true, desc = "Close quickfix" } )
vim.api.nvim_buf_set_keymap( 0, "n", "dd", ":lua require('obszczymucha.quickfix').remove_current_line()<CR>",
  { noremap = true, silent = true, desc = "Remove line" } )
vim.api.nvim_buf_set_keymap( 0, "v", "d", ":lua require('obszczymucha.quickfix').remove_selection()<CR>",
  { noremap = true, silent = true, desc = "Remove selection" } )
vim.api.nvim_buf_set_keymap( 0, "n", "<Enter>", ":.cc<CR>",
  { noremap = true, silent = true, desc = "Focus on the file" } )
