require( "obszczymucha.globals" )
require( "obszczymucha.common" )
require( "obszczymucha.set" )
require( "obszczymucha.color-overrides" )
require( "obszczymucha.packer" )
require( "obszczymucha.macros" )
require( "obszczymucha.telescope" )
require( "obszczymucha.metals" )
require( "obszczymucha.dap-ui" )
require( "obszczymucha.lua-test" )
require( "obszczymucha.documentation" )
require( "obszczymucha.debug" )
require( "obszczymucha.cmp" )

---@diagnostic disable-next-line: lowercase-global
dbg = function( ... ) require( "obszczymucha.debug" ).debug( ... ) end
