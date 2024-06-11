vim.cmd([[
  autocmd FileType java setlocal tabstop=4 shiftwidth=4 expandtab
  augroup JavaAutoRetab
    autocmd!
    autocmd BufWritePre *.java :retab
  augroup END
]])
