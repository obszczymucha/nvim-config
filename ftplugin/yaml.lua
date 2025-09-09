vim.keymap.set( "n", "<leader>j", ":%!yq --sort-keys --yaml-output<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Prettify JSON" } )
vim.keymap.set( "v", "<leader>j", ":'<,'>%!yq --yaml-output<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Prettify JSON" } )
