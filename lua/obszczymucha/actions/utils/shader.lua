local M = {}

function M.reload_shader()
  local job_id = vim.fn.jobstart( "source .venv/bin/activate && python reload_shader.py", {
    on_exit = function( _, exit_code )
      vim.schedule( function()
        if exit_code == 0 then
          vim.notify( "Shader reloaded.", vim.log.levels.INFO )
        else
          vim.notify( "Failed to reload shader (exit code: " .. exit_code .. ")", vim.log.levels.ERROR )
        end
      end )
    end
  } )

  if job_id <= 0 then
    vim.notify( "Failed to start shader reload job.", vim.log.levels.ERROR )
  end

  return job_id
end

return M