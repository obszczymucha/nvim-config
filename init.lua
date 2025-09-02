local lazypath = vim.fn.stdpath( "data" ) .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat( lazypath ) then
  vim.fn.system( {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  } )
end

vim.opt.rtp:prepend( lazypath )

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.gitblame_enabled = 0
vim.opt.shortmess:append( "I" ) -- Disable intro message

---@diagnostic disable-next-line: lowercase-global, different-requires
prequire = require( "obszczymucha.common" ).prequire

---@diagnostic disable-next-line: lowercase-global
prequirev = function( name, ... )
  local result, value = prequire( name, ... )
  if not result then vim.notify( string.format( "'%s' could not be found.", name ), vim.log.levels.WARN ) end

  return result, value
end

local release = vim.loop.os_uname().release
---@diagnostic disable-next-line: lowercase-global
is_wsl = release:match( "microsoft" ) and true or release:match( "WSL" ) and true or false

---@diagnostic disable-next-line: lowercase-global
is_windows = vim.loop.os_uname().sysname == "Windows_NT"

---@diagnostic disable-next-line: lowercase-global
is_macos = vim.loop.os_uname().sysname == "Darwin"

require( "lazy" ).setup( "plugins", {
  defaults = {
    lazy = true
  }
} )

-- Load essential modules immediately for autocmds that need to run on VimEnter
require( "obszczymucha.globals" )
require( "obszczymucha.utils" )
require( "obszczymucha.user-config" )
require( "obszczymucha.common" )
require( "obszczymucha.last-opened" )

-- Defer heavy custom configuration loading
vim.defer_fn( function()
  require( "obszczymucha.set" )
  require( "obszczymucha.color-overrides" )
  require( "obszczymucha.macros" )
  require( "obszczymucha.telescope" )
  require( "obszczymucha.dap-ui" )
  require( "obszczymucha.lua-test" )
  require( "obszczymucha.jest-test" )
  require( "obszczymucha.rust-test" )
  require( "obszczymucha.documentation" )
  require( "obszczymucha.debug" )
  require( "obszczymucha.autocmds" )
  require( "obszczymucha.groovyls" )
  require( "obszczymucha.osv" )
  require( "obszczymucha.mason-auto-install" )
  require( "obszczymucha.code-actions.lua" )
  require( "obszczymucha.actions" )
  require( "obszczymucha.colorscheme" )
  require( "obszczymucha.window-number" )
  require( "obszczymucha.window-toggle" )

  if is_wsl then
    require( "obszczymucha.alacritty" )
  elseif not is_macos then
    require( "obszczymucha.xmobar" )
  end
end, 0 )
