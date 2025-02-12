local utils = require( "obszczymucha.utils" )

return {
  "tomasky/bookmarks.nvim",
  event = "VimEnter",
  config = function()
    require( "bookmarks" ).setup {
      save_file = utils.get_project_root_dir() .. "/.bookmarks",
      keywords = {
        [ "@t" ] = "?? ", -- mark annotation startswith @t ,signs this icon as `Todo`
        [ "@w" ] = "?? ", -- mark annotation startswith @w ,signs this icon as `Warn`
        [ "@f" ] = "? ",  -- mark annotation startswith @f ,signs this icon as `Fix`
        [ "@n" ] = "? ",  -- mark annotation startswith @n ,signs this icon as `Note`
      },
      on_attach = function()
        local bm = require "bookmarks"
        local map = vim.keymap.set
        map( "n", "ma", bm.bookmark_toggle )
        map( "n", "ms", bm.bookmark_ann )
        map( "n", "mc", bm.bookmark_clean )
        map( "n", "zl", bm.bookmark_next )
        map( "n", "zh", bm.bookmark_prev )
        map( "n", "mg", bm.bookmark_list )
        map( "n", "mC", bm.bookmark_clear_all )
        map( "n", "mq", function() require( "telescope" ).extensions.bookmarks.list() end )
      end
    }
  end
}
