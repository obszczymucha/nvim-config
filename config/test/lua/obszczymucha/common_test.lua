---@diagnostic disable: duplicate-set-field
package.path = "../../?.lua;" .. package.path .. ";../../../lua/obszczymucha/?.lua"

local lu = require( "luaunit" )
local common = require( "common" )
local princess_kenny = common.princess_kenny
local is_blank = common.is_blank

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

lu.LuaUnit.run()
