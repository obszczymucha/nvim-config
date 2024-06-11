local cmd = vim.cmd

-- This splits screen into four windows
cmd( [[let @s=":vs\<CR>\<C-w>l:sp\<CR>\<C-w>j\<C-w>h:sp\<CR>"]] )

