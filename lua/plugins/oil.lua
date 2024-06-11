return {
  "stevearc/oil.nvim",
  config = function()
    require( "oil" ).setup {
      columns = { "icon" },
      keymaps = {
        [ "<M-h>" ] = "actions.select_split"
      },
      view_options = {
        show_hidden = true
      }
    }

    vim.keymap.set( "n", "-", "<cmd>Oil<CR>", { desc = "Open current directory" } )
  end,
  lazy = false
}
