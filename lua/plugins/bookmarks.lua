return {
  "LintaoAmons/bookmarks.nvim",
  -- pin the plugin at specific version for h
  -- backup your bookmark sqlite db when there are breaking changes
  -- tag = "v2.3.0",
  dependencies = {
    { "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" } -- optional: better UI
  },
  config = function()
    local opts = {
      signs = {
        mark = {
          icon = ">",
          color = "#af86d7",
          line_bg = "#3f3767",
        }
      }
    }                                    -- go to the following link to see all the options in the deafult config file
    require( "bookmarks" ).setup( opts ) -- you must call setup to init sqlite db
    vim.keymap.set( "n", "ma", "<cmd>BookmarksQuickMark<CR>", { desc = "Mark current line." } )
    vim.keymap.set( "n", "ms", "<cmd>BookmarksMark<CR>", { desc = "Mark current line with a name." } )
    vim.keymap.set( "n", "zh", "<cmd>BookmarksGotoPrev<CR>", { desc = "Go to the previous bookmark." } )
    vim.keymap.set( "n", "zl", "<cmd>BookmarksGotoNext<CR>", { desc = "Go to the next bookmark." } )
    vim.keymap.set( "n", "mq", "<cmd>BookmarksGoto<CR>", { desc = "Bookmark Telescope." } )
    vim.keymap.set( "n", "mg", "<cmd>BookmarksTree<CR>", { desc = "Bookmark tree." } )
  end,
  lazy = false
}
