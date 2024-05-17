return {
  { "tpope/vim-dadbod",                     lazy = false },
  { "kristijanhusak/vim-dadbod-completion", lazy = false },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = "DBUI",
    config = function()
      vim.cmd( "hi NotificationInfo guifg=#FFFFFF guibg=#202020" )
      vim.cmd( "hi NotificationWarning guifg=#FF9A40 guibg=#202020" )
      vim.cmd( "hi NotificationError guifg=#FF6060 guibg=#202020" )
    end
  }
}
