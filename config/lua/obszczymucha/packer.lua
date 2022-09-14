local fn = vim.fn
local install_path = fn.stdpath( 'data' ) .. '/site/pack/packer/start/packer.nvim'

if fn.empty( fn.glob( install_path ) ) > 0 then
  packer_bootstrap = fn.system( { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path } )
  vim.cmd [[ packadd packer.nvim ]]
end

return require( 'packer' ).startup( function( use )
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use 'psliwka/vim-smoothie'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim' }
    }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'tpope/vim-vinegar' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'ThePrimeagen/harpoon' }
  use { 'jenterkin/vim-autosource' }
  use { 'preservim/nerdcommenter' }

  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip' } }
  use { 'scalameta/nvim-metals', requires = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' } }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require( 'packer' ).sync()
  end
end )

