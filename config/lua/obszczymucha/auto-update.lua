local M = {}

function M.should_update( last_update_timestamp, current_time )
  local current_date_table = os.date( "*t", current_time )
  local current_hour = current_date_table.hour
  local last_update_date_table = last_update_timestamp and os.date( "*t", last_update_timestamp )
  local last_update_hour = last_update_date_table and last_update_date_table.hour

  local morning_update_hour = 7
  local evening_update_hour = 18

  local needs_morning_update = current_hour >= morning_update_hour and (
    not last_update_hour or
    last_update_date_table.day ~= current_date_table.day or
    last_update_hour < morning_update_hour
  )

  local needs_evening_update = current_hour >= evening_update_hour and (
    not last_update_hour or
    last_update_date_table.day ~= current_date_table.day or
    (last_update_hour < evening_update_hour and (current_hour > last_update_hour or last_update_date_table.day ~= current_date_table.day))
  )

  return needs_morning_update or needs_evening_update
end

return M
