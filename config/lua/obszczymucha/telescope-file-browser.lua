-- You don't need to set any of these options.
-- IMPORTANT!: this is only a showcase of how you can set default options!
require( "telescope" ).setup {
  extensions = {
    file_browser = {
      --theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        [ "i" ] = {
          [ "<A-j>" ] = function( prompt_bufnr )
            require( "telescope.actions" ).move_selection_next( prompt_bufnr )
          end,
          [ "<A-k>" ] = function( prompt_bufnr )
            require( "telescope.actions" ).move_selection_previous( prompt_bufnr )
          end
          -- your custom insert mode mappings
        },
        [ "n" ] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require( "telescope" ).load_extension "file_browser"
