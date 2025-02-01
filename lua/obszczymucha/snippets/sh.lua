local ls = prequirev( "luasnip" )
if not ls then return end

local LANG = "sh"
require( "luasnip.session.snippet_collection" ).clear_snippets( LANG )

local s = ls.s
local i = ls.i
local fmt = require( "luasnip.extras.fmt" ).fmt

ls.add_snippets( LANG, {
  s( "bash", fmt( [[
  #!/usr/bin/env bash

  main() {{
    {start}
  }}

  main "$@"

  ]], {
    start = i( 0 )
  } ) ),
} )
