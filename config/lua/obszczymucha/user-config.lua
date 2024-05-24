local Path = require( "plenary.path" )
local config_file = string.format( "%s/user-config.json", vim.fn.stdpath( "data" ) )

local M = {}
local config

local function read_config()
  return vim.json.decode( Path:new( config_file ):read() )
end

function M.load()
  local ok, result = pcall( read_config )

  if not ok then
    config = {}
    return
  end

  config = result
end

function M.save()
  Path:new( config_file ):write( vim.fn.json_encode( config ), "w" )
end

local function set( key, value )
  config[ key ] = value
  M.save()
end

function M.auto_center()
  return config.auto_center and true or false
end

function M.toggle_auto_center()
  local auto_center = config.auto_center or false
  set( "auto_center", not auto_center )

  vim.notify( string.format( "Auto-center: %s", config.auto_center and "on" or "off" ) )
end

M.load()

return M
