local M = {}
local file_utils = require( "obszczymucha.actions.utils.file" )

local function detect_module()
  local rel_path = file_utils.get_relative_path()

  if not rel_path then
    return nil
  end

  local module_name = rel_path:match( "^lua/(.*)%.lua$" )
  if module_name then
    return module_name:gsub( "/", "." )
  end

  return nil
end

function M.reload_current()
  local module_name = detect_module()
  if not module_name then return end

  local success, error = pcall( R, module_name )

  if success then
    vim.notify( string.format( "Module reloaded: [%s]{light-blue}", module_name ) )
  else
    vim.notify( string.format( "Failed to reload [%s]{light-blue}: %s", module_name, error ), vim.log.levels.WARN )
  end
end

return M
