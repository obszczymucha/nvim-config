local ls = prequirev( "luasnip" )
if not ls then return end

local LANG = "scala"
require( "luasnip.session.snippet_collection" ).clear_snippets( LANG )

local s = ls.s
local i = ls.i
local fmt = require( "luasnip.extras.fmt" ).fmt

ls.add_snippets( LANG, {
  s( "gwt", fmt( "// Given\n{start}\n\n// When\n\n// Then", {
    start = i( 0 )
  } ) )
} )
