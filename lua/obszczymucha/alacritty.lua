local src = vim.fn.resolve( os.getenv( "ALACRITTY_CONFIG" ) )
local dest = os.getenv( "WIN_ALACRITTY_CONFIG" )

if not src or not dest then return end

local function callback()
  vim.cmd( string.format( "silent exec \":!cp %s %s\"", src, dest ) )
  vim.notify( "Alacritty config reloaded." )
end

vim.api.nvim_create_autocmd( "BufWritePost", {
  group = vim.api.nvim_create_augroup( "AlacrittyConfig", { clear = true } ),
  pattern = { src },
  callback = callback
} )
