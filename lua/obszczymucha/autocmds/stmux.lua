local augroup = vim.api.nvim_create_augroup( "Stmux", { clear = true } )

vim.api.nvim_create_autocmd( "BufWritePost", {
  group = augroup,
  pattern = "*/.config/stmux/status.toml",
  callback = function()
    vim.schedule( function()
      local job_id = vim.fn.jobstart( "stmux status", {
        on_exit = function( _, exit_code )
          if exit_code ~= 0 then vim.notify( "stmux error: " .. exit_code ) end
        end,
      } )

      if job_id <= 0 then
        vim.notify( "Failed to refresh stmux status.", vim.log.levels.WARN )
      end
    end )
  end
} )
