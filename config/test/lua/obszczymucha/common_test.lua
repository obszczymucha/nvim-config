---@diagnostic disable: duplicate-set-field
package.path = "../../?.lua;" .. package.path .. ";../../../lua/obszczymucha/?.lua"

local lu = require( "luaunit" )
local common = require( "common" )
local princess_kenny = common.princess_kenny
local is_blank = common.is_blank
local get_filename = common.get_filename
local escape_dots = common.escape_dots

CommonSpec = {}

function CommonSpec:should_princess_kenny()
  lu.assertEquals( princess_kenny(), "Princess Kenny" )
end

function CommonSpec:should_determine_if_input_is_blank()
  lu.assertEquals( is_blank( nil ), true )
  lu.assertEquals( is_blank( "" ), true )
  lu.assertEquals( is_blank( "a" ), false )
  lu.assertEquals( is_blank( " " ), true )
  lu.assertEquals( is_blank( "  " ), true )
end

function CommonSpec:should_get_filename_from_path()
  lu.assertEquals( get_filename( "/abc/dupa.jas" ), "dupa.jas" )
  lu.assertEquals( get_filename( "./abc/dupa.jas" ), "dupa.jas" )
  lu.assertEquals( get_filename( "abc/dupa.jas/" ), "" )
  lu.assertEquals( get_filename( "" ), "" )
end

function CommonSpec:should_escape_dots()
  lu.assertEquals( escape_dots( "/chuj.xxx/dupa.jas" ), "/chuj%.xxx/dupa%.jas" )
end

function CommonSpec:should_match_line_number_and_expected_value()
  -- Given
  local name = "common_test%.lua"
  local pattern = "#%s*" .. name .. ":(%d+):.*"
  local result

  -- When
  for line_number in ("#  common_test.lua:38: attempt to concatenate a nil value"):gmatch( pattern ) do
    result = line_number
  end

  -- Then
  lu.assertEquals( result, "38" )
end

lu.LuaUnit.run()
