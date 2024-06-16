package.path = "../../?.lua;" .. package.path .. ";../../../lua/?.lua"

local lu = require( "luaunit" )
---@diagnostic disable-next-line: different-requires
local common = require( "obszczymucha.common" )
local princess_kenny = common.princess_kenny
local is_blank = common.is_blank
local get_filename = common.get_filename
local escape_dots = common.escape_dots
local escape_dashes = common.escape_dashes
local escape_filename = common.escape_filename
local remove_trailing = common.remove_trailing

TestUtilsSpec = {}

function TestUtilsSpec:should_princess_kenny()
  lu.assertEquals( princess_kenny(), "Princess Kenny" )
end

function TestUtilsSpec:should_determine_if_input_is_blank()
  lu.assertEquals( is_blank( nil ), true )
  lu.assertEquals( is_blank( "" ), true )
  lu.assertEquals( is_blank( "a" ), false )
  lu.assertEquals( is_blank( " " ), true )
  lu.assertEquals( is_blank( "  " ), true )
end

function TestUtilsSpec:should_get_filename_from_path()
  lu.assertEquals( get_filename( "/abc/dupa.jas" ), "dupa.jas" )
  lu.assertEquals( get_filename( "./abc/dupa.jas" ), "dupa.jas" )
  lu.assertEquals( get_filename( "abc/dupa.jas/" ), "" )
  lu.assertEquals( get_filename( "" ), "" )
end

function TestUtilsSpec:should_escape_dots()
  lu.assertEquals( escape_dots( "/chuj.xxx/dupa.jas" ), "/chuj%.xxx/dupa%.jas" )
end

function TestUtilsSpec:should_escape_dashes()
  lu.assertEquals( escape_dashes( "abc-def" ), "abc%-def" )
end

function TestUtilsSpec:should_escape_filename()
  lu.assertEquals( escape_filename( "abc-def.lua" ), "abc%-def%.lua" )
end

function TestUtilsSpec:should_compose_functions()
  -- Given
  local f1 = function( v ) return v + 1 end
  local f2 = function( v ) return v * 3 end
  local f3 = common.compose( f1, f2 )

  -- Expect
  lu.assertEquals( f1( 2 ), 3 )
  lu.assertEquals( f2( 3 ), 9 )
  lu.assertEquals( f3( 3 ), 12 )
end

function TestUtilsSpec:should_remove_trailing_chars()
  lu.assertEquals( remove_trailing( "abc:as::", ":" ), "abc:as" )
  lu.assertEquals( remove_trailing( "abc:as:", ":" ), "abc:as" )
  lu.assertEquals( remove_trailing( "abc:as", ":" ), "abc:as" )
  lu.assertEquals( remove_trailing( "", ":" ), "" )
end

lu.LuaUnit.run()
