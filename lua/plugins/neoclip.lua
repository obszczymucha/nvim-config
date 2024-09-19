return {
  "AckslD/nvim-neoclip.lua",
  lazy = false,
  dependencies = {
    "kkharji/sqlite.lua"
  },
  config = function()
    require( "neoclip" ).setup( {
      -- Enabling this on a corporate Mac slows this down.
      enable_persistent_history = not is_macos
    } )
  end,
}
