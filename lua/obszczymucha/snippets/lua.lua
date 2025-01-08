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
      ModUi.mod( "{name}", function( mod, wow )
        {start}
      end{mixins} )
    ]], {
      name = i( 1 ),
      mixins = i( 2 ),
      start = i( 0 ),
    } )
  ),
  s( "mixui",
    fmt( [[
      ModUi.mixin( "{name}", function( mixin, wow )
        {start}
      end, function( self, component )
      end{mixins} )
    ]], {
      name = i( 1 ),
      mixins = i( 2 ),
      start = i( 0 ),
    } )
  ),
  s( "sf",
    fmt( [[
      string.format( "{pattern}" )
    ]], {
      pattern = i( 0 )
    } )
  ),
  s( "lfn",
    fmt( [[
      local function {name}({args})
        {start}
      end
    ]], {
      name = i( 1 ),
      args = i( 2 ),
      start = i( 0 )
    } )
  ),
  s( "fnm",
    fmt( [[
      function M.{name}({args})
        {start}
      end
    ]], {
      name = i( 1 ),
      args = i( 2 ),
      start = i( 0 )
    } )
  )
} )
