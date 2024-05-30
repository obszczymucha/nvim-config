package.path = "../../?.lua;" .. package.path .. ";../../../lua/obszczymucha/?.lua"

local lu = require( "luaunit" )
---@diagnostic disable-next-line: different-requires
local should_update = require( "auto-update" ).should_update

CommonSpec = {}

function CommonSpec:test_morning_update_no_previous_update()
  local morning_time = os.time( { year = 2023, month = 5, day = 30, hour = 8 } )
  lu.assertTrue( should_update( nil, morning_time ) )
end

function CommonSpec:test_morning_update_after_evening_update_previous_day()
  local last_evening = os.time( { year = 2023, month = 5, day = 29, hour = 19 } )
  local morning_time = os.time( { year = 2023, month = 5, day = 30, hour = 8 } )
  lu.assertTrue( should_update( last_evening, morning_time ) )
end

function CommonSpec:test_evening_update_no_previous_update()
  local evening_time = os.time( { year = 2023, month = 5, day = 30, hour = 19 } )
  lu.assertTrue( should_update( nil, evening_time ) )
end

function CommonSpec:test_evening_update_after_morning_update_same_day()
  local morning_time_same_day = os.time( { year = 2023, month = 5, day = 30, hour = 8 } )
  local evening_time = os.time( { year = 2023, month = 5, day = 30, hour = 19 } )
  lu.assertTrue( should_update( morning_time_same_day, evening_time ) )
end

function CommonSpec:test_no_update_needed_after_morning_update()
  local morning_update_time = os.time( { year = 2023, month = 5, day = 30, hour = 7 } )
  local after_morning_update = os.time( { year = 2023, month = 5, day = 30, hour = 10 } )
  lu.assertFalse( should_update( morning_update_time, after_morning_update ) )
end

function CommonSpec:test_no_update_needed_after_evening_update()
  local evening_update_time = os.time( { year = 2023, month = 5, day = 30, hour = 18 } )
  local after_evening_update = os.time( { year = 2023, month = 5, day = 30, hour = 20 } )
  lu.assertFalse( should_update( evening_update_time, after_evening_update ) )
end

lu.LuaUnit.run()
