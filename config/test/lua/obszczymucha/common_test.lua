package.path = package.path .. ";../../../lua/obszczymucha/?.lua"
local lu = require( "luaunit" )
local common = require( "common" )
local princess_kenny = common.princess_kenny
local is_blank = common.is_blank

---@diagnostic disable-next-line: lowercase-global
function test_clean_hls_message()
  lu.assertEquals( princess_kenny(), "Princess Kenny" )
end

---@diagnostic disable-next-line: lowercase-global
function test_is_blank()
  lu.assertEquals( is_blank( nil ), true )
  lu.assertEquals( is_blank( "" ), true )
  lu.assertEquals( is_blank( "a" ), false )
  lu.assertEquals( is_blank( " " ), true )
  lu.assertEquals( is_blank( "  " ), true )
end

local runner = lu.LuaUnit.new()
runner:setOutputType( "text" )
os.exit( runner:runSuite() )
