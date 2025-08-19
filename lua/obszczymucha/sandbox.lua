local M = {}
local state = require( "obszczymucha.state.sandbox" )

local utils = require( "obszczymucha.utils" )
local saturate, brightness = utils.saturate, utils.brightness

local purple = "#9f7fff"
local light_purple = saturate( purple, 0.6 )
local light_purple2 = saturate( purple, 0.9 )
local dark_purple = brightness( purple, 0.4 )

local colors = { purple, light_purple, light_purple2, dark_purple }
state.current_color = state.current_color or 1

function M.test()
  local color = colors[ state.current_color ]
  vim.notify( string.format( "@%s@Sandbox: @@Hello (@%s@%s@@)!", color, color, color ) )
  state.current_color = state.current_color + 1
  if state.current_color > #colors then state.current_color = 1 end
end

return M
