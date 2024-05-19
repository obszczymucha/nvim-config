local ls = prequire( "luasnip" )
if not ls then return end

local LANG = "zsh"
require( "luasnip.session.snippet_collection" ).clear_snippets( LANG )

local s = ls.s
local i = ls.i
local fmt = require( "luasnip.extras.fmt" ).fmt
local rep = require( "luasnip.extras" ).rep

ls.add_snippets( LANG, {
  s( "una",
    fmt(
      "alias {} > /dev/null && unalias {}",
      {
        i( 1 ),
        rep( 1 )
      }
    )
  )
} )
