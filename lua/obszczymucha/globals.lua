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
dump = function( ... ) require( "obszczymucha.dump" ).dump( ... ) end

---@diagnostic disable-next-line: lowercase-global
config = {
  debug = {
    width = 50,
    height = 12
  }
}
