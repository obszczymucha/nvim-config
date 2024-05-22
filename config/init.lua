local lazypath = vim.fn.stdpath( "data" ) .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat( lazypath ) then
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

---@diagnostic disable-next-line: lowercase-global
prequire = require( "obszczymucha.common" ).prequire

---@diagnostic disable-next-line: lowercase-global
prequirev = function( name, ... )
  local result, value = prequire( name, ... )
  if not result then vim.notify( string.format( "'%s' could not be found.", name ), vim.log.levels.WARN ) end

  return result, value
end

require( "lazy" ).setup( "plugins", {
  defaults = {
    lazy = true
  }
} )

require( "obszczymucha" )
