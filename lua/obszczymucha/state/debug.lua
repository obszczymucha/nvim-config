-- I contain state for debug module.
-- The module gets reloaded (on remap to refresh the code) while the state persists.
local M = {}

vim.api.nvim_create_augroup( "DebugWindowEvents", { clear = true } )

return M
