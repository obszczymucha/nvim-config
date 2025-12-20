local auto_update = prequirev( "obszczymucha.auto-update" )
if not auto_update then return end

vim.api.nvim_create_autocmd( "User", {
  pattern = "VeryLazy",
  callback = auto_update.update,
} )
