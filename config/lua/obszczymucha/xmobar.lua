local job = prequire( 'plenary.job' )
if not job then return end

local function callback()
  job:new( {
    command = 'sh',
    args = { '-c', 'xmonad --recompile && xmonad --restart' },
    on_start = function() vim.notify( "Reloading XMonad..." ) end,
    on_exit = function( _, return_val )
      if return_val == 0 then
        vim.notify( "XMonad reloaded successfully." )
      else
        vim.notify( "Failed to reload XMonad.", vim.log.levels.ERROR )
      end
    end,
  } ):start()
end

vim.api.nvim_create_autocmd( "BufWritePost", {
  group = vim.api.nvim_create_augroup( "XmobarConfig", { clear = true } ),
  pattern = { "xmonad.hs", "xmobar.hs" },
  callback = callback
} )
