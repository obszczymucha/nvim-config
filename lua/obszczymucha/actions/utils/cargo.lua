local M = {}

local state = require( "obszczymucha.state.cargo" )
local utils = require( "obszczymucha.utils" )

function M.is_hooked()
  return state.is_hooked
end

function M.hook()
  state.is_hooked = true

  local augroup = vim.api.nvim_create_augroup( "cargo-build", { clear = true } )
  vim.api.nvim_create_autocmd( "BufWritePost", {
    group = augroup,
    pattern = "*.rs",
    callback = function()
      vim.schedule( function()
        local file = vim.fn.expand( "<afile>:p" )
        local project_dir = utils.get_project_root_dir( file )
        local dbg = require( "obszczymucha.debug" )

        dbg.clear()

        local job_id = vim.fn.jobstart( { "cargo", "build", "--release" }, {
          cwd = project_dir,
          stdout_buffered = true,
          stderr_buffered = true,
          on_exit = function( _, exit_code )
            if exit_code ~= 0 then
              vim.schedule( function()
                vim.notify( "cargo build --release failed: " .. exit_code, vim.log.levels.WARN )
              end )
            else
              vim.schedule( function()
                vim.notify( "Build ready." )
              end )
            end
          end,
          on_stdout = function( _, data )
            if data then
              local lines = vim.tbl_filter( function( line ) return line ~= "" end, data )
              if #lines > 0 then vim.schedule( function() dbg.debug( lines ) end ) end
            end
          end,
          on_stderr = function( _, data )
            if data then
              local lines = vim.tbl_filter( function( line ) return line ~= "" end, data )
              if #lines > 0 then vim.schedule( function() dbg.debug( lines ) end ) end
            end
          end,
        } )

        if job_id <= 0 then
          vim.notify( "Failed to start cargo build.", vim.log.levels.WARN )
        end
      end )
    end
  } )

  vim.notify( "Cargo build release hooked.", vim.log.levels.INFO )
end

return M
