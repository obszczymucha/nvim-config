local ls = prequirev( "luasnip" )
if not ls then return end

local LANG = "lua"
require( "luasnip.session.snippet_collection" ).clear_snippets( LANG )

local s = ls.s
local f = ls.f
local i = ls.i
local fmt = require( "luasnip.extras.fmt" ).fmt

local function get_current_filename() return vim.fn.expand( "%:t:r" ) end

ls.add_snippets( LANG, {
  s( "gwt",
    fmt( "-- Given\n{start}\n\n-- When\n\n-- Then", {
      start = i( 0 )
    } )
  ),
  s( "modui",
    fmt( [[
      local M = {{}}

      function M.new()
        {start}
      end

      ModUi = ModUi or {{}}
      ModUi.{filename} = M
    ]], {
      start = i( 0 ),
      filename = f( get_current_filename )
    } )
  )
} )
