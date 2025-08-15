return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
    { "nvim-telescope/telescope-dap.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  config = function()
    -- Telescope
    vim.keymap.set( "n", "<leader>fs", "<cmd>lua R( 'obszczymucha.telescope' ).find_files()<CR>", { desc = "Find files" } )
    vim.keymap.set( "n", "<leader>fr", "<cmd>lua R( 'obszczymucha.telescope' ).resume()<CR>",
      { desc = "Resume find files" } )
    -- vim.keymap.set( "n", "<leader>fe", "<cmd>lua R( 'obszczymucha.telescope' ).live_grep()<CR>", { desc = "Search" } )
    vim.keymap.set( "n", "<leader>fe", "<cmd>lua R( 'obszczymucha.telescope.multigrep' ).live_multigrep()<CR>",
      { desc = "Search" } )
    vim.keymap.set( "n", "<leader>fE", "<cmd>lua R( 'obszczymucha.telescope' ).live_grep( true )<CR>",
      { desc = "Search hidden" } )
    vim.keymap.set( "n", "<leader>/", "<cmd>lua R( 'obszczymucha.telescope' ).current_buffer_fuzzy_find()<CR>",
      { desc = "Current buffer fuzzy find" } )
    vim.keymap.set( "n", "<leader>fb", "<cmd>lua R( 'obszczymucha.telescope' ).buffers()<CR>", { desc = "Buffers" } )
    vim.keymap.set( "n", "<leader>fh", "<cmd>lua R( 'obszczymucha.telescope' ).help_tags()<CR>", { desc = "Help Tags" } )
    vim.keymap.set( "n", "<leader>fH", "<cmd>lua R( 'obszczymucha.telescope' ).highlights()<CR>", { desc = "Highlights" } )
    vim.keymap.set( "n", "<leader>fd", "<cmd>lua R( 'obszczymucha.telescope' ).diagnostics()<CR>",
      { desc = "Diagnostics" } )
    vim.keymap.set( "n", "<leader>rg", "<cmd>lua R( 'obszczymucha.telescope' ).registers()<CR>", { desc = "Registers" } )
    vim.keymap.set( "n", "<leader>gc", "<cmd>lua R( 'obszczymucha.telescope' ).git_commits()<CR>",
      { desc = "Git commits" } )
    vim.keymap.set( "n", "<leader>gb", "<cmd>lua R( 'obszczymucha.telescope' ).git_branches()<CR>",
      { desc = "Git branches" } )
    vim.keymap.set( "n", "<leader>fp", "<cmd>lua R( 'obszczymucha.telescope' ).breakpoints()<CR>",
      { desc = "Breakpoints" } )
    vim.keymap.set( "n", "<leader>fq", "<cmd>lua R( 'obszczymucha.telescope' ).quickfix_history()<CR>",
      { desc = "Quickfix history" } )
    vim.keymap.set( "n", "_", "<cmd>lua R( 'obszczymucha.telescope' ).file_browser()<CR>", { desc = "File browser" } )
    vim.keymap.set( "n", "<leader>fn", "<cmd>lua R( 'obszczymucha.telescope' ).notify()<CR>", { desc = "Notifications" } )
    vim.keymap.set( "n", "<leader>fg", "<cmd>lua R( 'obszczymucha.telescope' ).oil_dir()<CR>",
      { desc = "Directory search (Oil)" } )

    vim.keymap.set( "v", "<leader>fe", function()
      local selection = require( "obszczymucha.utils.selection" ).get_selection()
      if not selection then return end

      R( "obszczymucha.telescope.multigrep" ).live_multigrep( vim.trim( selection ) )
    end, { desc = "Search selection" } )

    vim.keymap.set( "n", "<leader>fw", function()
      local selection = require( "obszczymucha.utils.selection" ).get_word_under_cursor()
      R( "obszczymucha.telescope.multigrep" ).live_multigrep( selection )
    end, { desc = "Search selection" } )

    vim.keymap.set( "n", "<leader>fW", function()
      local selection = require( "obszczymucha.utils.selection" ).get_whole_word_under_cursor()
      R( "obszczymucha.telescope.multigrep" ).live_multigrep( selection )
    end, { desc = "Search selection" } )

    vim.keymap.set( "n", "<leader>fW", function()
      local selection = require( "obszczymucha.utils.selection" ).get_whole_word_under_cursor()
      R( "obszczymucha.telescope.multigrep" ).live_multigrep( selection )
    end, { desc = "Search selection" } )

    -- For Mac
    vim.keymap.set( "n", "<M-F1>", "<cmd>lua R( 'obszczymucha.telescope' ).notify()<CR>", { desc = "Notifications" } )
  end
}
