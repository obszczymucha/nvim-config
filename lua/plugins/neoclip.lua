return {
  "AckslD/nvim-neoclip.lua",
  keys = {
    { "<leader>p", function() require( "obszczymucha.telescope" ).neoclip() end, desc = "Paste from clipboard history" }
  },
  dependencies = {
    "kkharji/sqlite.lua"
  },
  config = function()
    require( "neoclip" ).setup( {
      -- Enabling this on a corporate Mac slows this down.
      enable_persistent_history = not is_macos
    } )
  end,
  lazy = false
}
