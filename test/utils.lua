local M = {}

function M.luaunit( ... )
  local result = {}
  local lu = require( "luaunit" )

  for _, name in ipairs( { ... } ) do
    table.insert( result, lu[ name ] )
  end

  return lu, table.unpack( result )
end

return M
