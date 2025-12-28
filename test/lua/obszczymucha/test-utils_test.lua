package.path = "../../?.lua;" .. package.path .. ";../../../lua/?.lua"

local lu, eq = require( "utils" ).luaunit( "assertEquals" )

local test_utils = require( "obszczymucha.test-utils" )
local resolve = test_utils.resolve_source_filename

TestUtilsSpec = {}

function TestUtilsSpec:should_resolve_source_name_from_test_name()
  eq( resolve( "./test/ModUi_test.lua", "../ModUi.lua" ), "ModUi.lua" )
  eq( resolve( "./test/module/ModUi_test.lua", "../../ModUi.lua" ), "ModUi.lua" )
  eq( resolve( "./test/module/ModUi_test.lua", "../../src/ModUi.lua" ), "src/ModUi.lua" )
end

lu.LuaUnit.run()
