local Path = require( "plenary.path" )
local config_file = string.format( "%s/user-config.json", vim.fn.stdpath( "data" ) )

local M = {}
local config

local LAST_UPDATE_TIMESTAMP = "last_update_timestamp"

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

local function get_root_dir()
  local root_dir = vim.fn.system( "git rev-parse --show-toplevel" )
  return not vim.v.shell_error and root_dir or vim.fn.getcwd()
end

function M.set_local( key, value )
  local k = string.format( "%s|%s", get_root_dir(), key )
  config[ k ] = value
  M.save()
end

function M.get_local( key )
  local k = string.format( "%s|%s", get_root_dir(), key )
  return config[ k ]
end

function M.auto_center()
  return config.auto_center
end

function M.toggle_auto_center()
  set( "auto_center", not config.auto_center )
  vim.notify( string.format( "Auto-center: %s", config.auto_center and "on" or "off" ) )
end

function M.get_last_update_timestamp()
  return config[ LAST_UPDATE_TIMESTAMP ]
end

function M.set_last_update_timestamp()
  set( LAST_UPDATE_TIMESTAMP, os.time() )
end

function M.alpha_nrformats()
  return config.alpha_nrformats
end

function M.toggle_alpha_nrformats( opts )
  set( "alpha_nrformats", not config.alpha_nrformats )
  local configured = config.alpha_nrformats

  local key = "alpha"
  local nrformats = vim.opt.nrformats

  if configured then
    nrformats:append( key )
  else
    nrformats:remove( key )
  end

  if opts and opts.silent then return end
  vim.notify( string.format( "Alpha nrformats: %s", configured and "on" or "off" ) )
end

M.load()

return M
