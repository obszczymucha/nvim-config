return {
  "stevearc/oil.nvim",
  config = function()
    require( "oil" ).setup {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      columns = { "icon" },
      keymaps = {
        [ "<M-h>" ] = "actions.select_split"
      },
      view_options = {
        show_hidden = true,
        natural_sort = true,
      },
    }

    vim.keymap.set( "n", "-", "<cmd>Oil<CR>", { desc = "Open current directory" } )
  end,
  lazy = false
}
