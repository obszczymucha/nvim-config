package.path = "../../?.lua;" .. package.path .. ";../../../lua/?.lua"
require( "vim-mock" ).setup()

local lu, is_true, is_false = require( "utils" ).luaunit( "assertTrue", "assertFalse" )

---@diagnostic disable-next-line: different-requires
local should_update = require( "obszczymucha.auto-update" ).should_update

AutoUpdateSpec = {}

function AutoUpdateSpec:should_update_in_the_morning_when_no_previous_update()
  local morning_time = os.time( { year = 2023, month = 5, day = 30, hour = 8 } )
  is_true( should_update( nil, morning_time ) )
end

function AutoUpdateSpec:should_update_in_the_morning_after_evening_update_previous_day()
  local last_evening = os.time( { year = 2023, month = 5, day = 29, hour = 19 } )
  local morning_time = os.time( { year = 2023, month = 5, day = 30, hour = 8 } )
  is_true( should_update( last_evening, morning_time ) )
end

function AutoUpdateSpec:should_update_in_the_evening_when_no_previous_update()
  local evening_time = os.time( { year = 2023, month = 5, day = 30, hour = 19 } )
  is_true( should_update( nil, evening_time ) )
end

function AutoUpdateSpec:should_update_in_the_evening_after_morning_update_same_day()
  local morning_time_same_day = os.time( { year = 2023, month = 5, day = 30, hour = 8 } )
  local evening_time = os.time( { year = 2023, month = 5, day = 30, hour = 19 } )
  is_true( should_update( morning_time_same_day, evening_time ) )
end

function AutoUpdateSpec:should_not_update_after_morning_update()
  local morning_update_time = os.time( { year = 2023, month = 5, day = 30, hour = 7 } )
  local after_morning_update = os.time( { year = 2023, month = 5, day = 30, hour = 10 } )
  is_false( should_update( morning_update_time, after_morning_update ) )
end

function AutoUpdateSpec:should_not_update_after_morning_update_at_the_same_hour()
  local morning_update_time = os.time( { year = 2023, month = 5, day = 30, hour = 7 } )
  local after_morning_update = os.time( { year = 2023, month = 5, day = 30, hour = 7 } )
  is_false( should_update( morning_update_time, after_morning_update ) )
end

function AutoUpdateSpec:should_not_update_after_evening_update()
  local evening_update_time = os.time( { year = 2023, month = 5, day = 30, hour = 18 } )
  local after_evening_update = os.time( { year = 2023, month = 5, day = 30, hour = 20 } )
  is_false( should_update( evening_update_time, after_evening_update ) )
end

lu.LuaUnit.run()
