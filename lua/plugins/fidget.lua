-- LSP notifications in the bottom right corner.
-- Does the same thing Noice does, but with a different look.
return {
  "j-hui/fidget.nvim",
  config = function()
    require( "fidget" ).setup( {
      progress = {
        ignore = { "null-ls" }
      }
    } )
  end,
  lazy = false
}
