local ls = prequirev( "luasnip" )
if not ls then return end

local LANG = "sh"
require( "luasnip.session.snippet_collection" ).clear_snippets( LANG )

local s = ls.s
local i = ls.i
local fmt = require( "luasnip.extras.fmt" ).fmt

local snippets = {
  s( "bash", fmt( [[
  #!/usr/bin/env bash

  main() {{
    {start}
  }}

  main "$@"

  ]], {
    start = i( 0 )
  } ) ),
}

ls.add_snippets( LANG, snippets )
ls.add_snippets( "", snippets )
