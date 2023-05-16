P = function( v )
  print( vim.inspect( v ) )
  return v
end

if pcall( require, "plenary" ) then
  RELOAD = require( "plenary.reload" ).reload_module

  R = function( name )
    RELOAD( name )
    return require( name )
  end
end

---@diagnostic disable-next-line: lowercase-global
dbg = function( ... ) require( "obszczymucha.debug" ).debug( ... ) end

---@diagnostic disable-next-line: lowercase-global
dump = function( o )
  local entries = 0

  if type( o ) == 'table' then
    local s = '{'
    for k, v in pairs( o ) do
      if (entries == 0) then s = s .. " " end
      if type( k ) ~= 'number' then k = '"' .. k .. '"' end
      if (entries > 0) then s = s .. ", " end
      s = s .. '[' .. k .. '] = ' .. dump( v )
      entries = entries + 1
    end

    if (entries > 0) then s = s .. " " end
    return s .. '}'
  else
    return tostring( o )
  end
end

---@diagnostic disable-next-line: lowercase-global
is_wsl = os.getenv( "WSL_DISTRO_NAME" )

---@diagnostic disable-next-line: lowercase-global
is_windows = os.getenv( "OS" ) == "Windows_NT"

