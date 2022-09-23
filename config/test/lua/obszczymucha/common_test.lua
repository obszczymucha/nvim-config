package.path = package.path .. ";../../../lua/obszczymucha/?.lua"
local lu = require( "luaunit" )
local princess_kenny = require( "common" ).princess_kenny

---@diagnostic disable-next-line: lowercase-global
function test_clean_hls_message()
  lu.assertEquals( princess_kenny(), "Princess Kenny" )
end

local runner = lu.LuaUnit.new()
runner:setOutputType( "text" )
os.exit( runner:runSuite() )
