local M = {}

function M.hook_restart( service_name )
  local current_buffer = vim.api.nvim_get_current_buf()
  local augroup_name = "WallpaperReloadHook" .. current_buffer

  vim.api.nvim_create_augroup( augroup_name, { clear = true } )
  vim.api.nvim_create_autocmd( "BufWritePost", {
    group = augroup_name,
    buffer = current_buffer,
    callback = function() require( "obszczymucha.actions.utils.systemctl" ).restart( service_name ) end
  } )

  vim.notify( string.format( "%s restart hooked.", service_name ), vim.log.levels.INFO )
end

return M
