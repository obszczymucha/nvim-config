local ls = prequirev( "luasnip" )
if not ls then return end

local LANG = "markdown"
require( "luasnip.session.snippet_collection" ).clear_snippets( LANG )

local s = ls.s
local i = ls.i
local fmt = require( "luasnip.extras.fmt" ).fmt

ls.add_snippets( LANG, {
  s( "code", fmt( "```{type}\n{start}\n```", {
    start = i( 0 ),
    type = i( 1 )
  } ) )
} )
