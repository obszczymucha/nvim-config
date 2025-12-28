local M = {}

function M.dump( o )
  local entries = 0

  if type( o ) == 'table' then
    local s = '{'
    for k, v in pairs( o ) do
      if (entries == 0) then s = s .. " " end
      if type( k ) ~= 'number' then k = '"' .. k .. '"' end
      if (entries > 0) then s = s .. ", " end
      s = s .. '[' .. k .. '] = ' .. M.dump( v )
      entries = entries + 1
    end

    if (entries > 0) then s = s .. " " end
    return s .. '}'
  else
    return tostring( o )
  end
end

return M
