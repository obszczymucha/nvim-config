local M = {}

function M.restart( service_name )
  local job_id = vim.fn.jobstart( string.format( "systemctl --user restart %s", service_name ), {
    on_exit = function( _, exit_code )
      vim.schedule( function()
        if exit_code == 0 then
          vim.notify( string.format( "%s restarted", service_name ), vim.log.levels.INFO )
        else
          vim.notify( string.format( "Failed to restart %s (exit code: " .. exit_code .. ")", service_name ),
            vim.log.levels.ERROR )
        end
      end )
    end
  } )

  if job_id <= 0 then
    vim.notify( "Failed to start systemctl service restart job.", vim.log.levels.ERROR )
  end
end

return M
