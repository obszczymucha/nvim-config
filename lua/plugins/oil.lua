return {
  "stevearc/oil.nvim",
  config = function()
    local oil = require( "oil" )
    oil.setup {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      columns = { "icon" },
      keymaps = {
        [ "<M-h>" ] = "actions.select_split",
        [ "<Esc>" ] = "actions.close",
        [ "<A-.>" ] = function()
          local strip = require( "obszczymucha.utils" ).front_strip
          vim.notify( strip( oil.get_current_dir(), vim.o.columns - 10 ) )
        end
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
