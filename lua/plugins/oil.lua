return {
  "stevearc/oil.nvim",
  config = function()
    require( "oil" ).setup {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      columns = { "icon" },
      keymaps = {
        [ "<M-h>" ] = "actions.select_split",
        [ "<Esc>" ] = "actions.close"
      },
      view_options = {
        show_hidden = true,
        natural_sort = true,
      },
      float = {
        padding = 2,
        max_width = 60,
        max_height = 24
      }
    }

    vim.keymap.set( "n", "-", "<cmd>Oil --float<CR>", { desc = "Open current directory (float)" } )
    vim.keymap.set( "n", "=", "<cmd>Oil<CR>", { desc = "Open current directory" } )
  end,
  lazy = false
}
