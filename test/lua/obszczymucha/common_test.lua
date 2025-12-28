package.path = "../../?.lua;" .. package.path .. ";../../../lua/?.lua"

local lu, eq = require( "utils" ).luaunit( "assertEquals" )

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
  eq( princess_kenny(), "Princess Kenny" )
end

function TestUtilsSpec:should_determine_if_input_is_blank()
  eq( is_blank( nil ), true )
  eq( is_blank( "" ), true )
  eq( is_blank( "a" ), false )
  eq( is_blank( " " ), true )
  eq( is_blank( "  " ), true )
end

function TestUtilsSpec:should_get_filename_from_path()
  eq( get_filename( "/abc/dupa.jas" ), "dupa.jas" )
  eq( get_filename( "./abc/dupa.jas" ), "dupa.jas" )
  eq( get_filename( "abc/dupa.jas/" ), "" )
  eq( get_filename( "" ), "" )
end

function TestUtilsSpec:should_escape_dots()
  eq( escape_dots( "/chuj.xxx/dupa.jas" ), "/chuj%.xxx/dupa%.jas" )
end

function TestUtilsSpec:should_escape_dashes()
  eq( escape_dashes( "abc-def" ), "abc%-def" )
end

function TestUtilsSpec:should_escape_filename()
  eq( escape_filename( "abc-def.lua" ), "abc%-def%.lua" )
end

function TestUtilsSpec:should_compose_functions()
  -- Given
  local f1 = function( v ) return v + 1 end
  local f2 = function( v ) return v * 3 end
  local f3 = common.compose( f1, f2 )

  -- Expect
  eq( f1( 2 ), 3 )
  eq( f2( 3 ), 9 )
  eq( f3( 3 ), 12 )
end

function TestUtilsSpec:should_remove_trailing_chars()
  eq( remove_trailing( "abc:as::", ":" ), "abc:as" )
  eq( remove_trailing( "abc:as:", ":" ), "abc:as" )
  eq( remove_trailing( "abc:as", ":" ), "abc:as" )
  eq( remove_trailing( "", ":" ), "" )
end

lu.LuaUnit.run()
