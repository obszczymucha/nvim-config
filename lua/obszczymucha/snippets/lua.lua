local ls = prequirev( "luasnip" )
if not ls then return end

local LANG = "lua"
require( "luasnip.session.snippet_collection" ).clear_snippets( LANG )

local s = ls.s
local i = ls.i
local fmt = require( "luasnip.extras.fmt" ).fmt

ls.add_snippets( LANG, {
  s( "gwt",
    fmt( "-- Given\n{start}\n\n-- When\n\n-- Then", {
      start = i( 0 )
    } )
  ),
  s( "modui",
    fmt( [[
      local M = ModUi.mod( "{name}"{mixins} )

      function M.main()
        {start}
      end
    ]], {
      name = i( 1 ),
      mixins = i( 2 ),
      start = i( 0 ),
    } )
  ),
  s( "mixui",
    fmt( [[
      local M = ModUi.mixin( "{name}"{mixins} )

      function M.main()
      end

      function M.extend( component )
        {start}
      end
    ]], {
      name = i( 1 ),
      mixins = i( 2 ),
      start = i( 0 ),
    } )
  )
} )
