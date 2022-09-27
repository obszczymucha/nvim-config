local M = {}

local prequire = require( "obszczymucha.common" ).prequire
local keymap = require( "obszczymucha.keymap" )
local nnoremap = keymap.nnoremap
local inoremap = keymap.inoremap
local vnoremap = keymap.vnoremap
local xnoremap = keymap.xnoremap
local cnoremap = keymap.cnoremap
local nmap = keymap.nmap

-- netrw
local netrw = function( functionName )
  return string.format( '<cmd>lua require( "obszczymucha.netrw" ).%s()<CR>', functionName )
end

nnoremap( "<M-Esc>", netrw( "toggle_netrw" ) )

-- Telescope
nnoremap( "<leader>ff", "<cmd>lua require( 'obszczymucha.telescope' ).find_files()<CR>" )
nnoremap( "<leader>fg", "<cmd>lua require( 'obszczymucha.telescope' ).live_grep()<CR>" )
nnoremap( "<leader>fF", "<cmd>lua require( 'obszczymucha.telescope' ).find_files( true )<CR>" )
nnoremap( "<leader>fG", "<cmd>lua require( 'obszczymucha.telescope' ).live_grep( true )<CR>" )
nnoremap( "<leader>fb", "<cmd>Telescope buffers<CR>" )
nnoremap( "<leader>fh", "<cmd>Telescope help_tags<CR>" )

-- Create a file under cursor
nnoremap( "<leader>gf", "<cmd>e <cfile><CR>" )

-- Window management
nnoremap( "<A-v>", "<C-w>v<C-w>w" )
nnoremap( "<A-V>", "<C-w>v<C-w>w<cmd>Telescope find_files<CR>" )
nnoremap( "<A-s>", "<C-w>s<C-w>w" )
nnoremap( "<A-S>", "<C-w>s<C-w>w<cmd>Telescope find_files<CR>" )
nnoremap( "<A-j>", "<C-w>j" )
nnoremap( "<A-k>", "<C-w>k" )
nnoremap( "<A-h>", "<C-w>h" )
nnoremap( "<A-l>", "<C-w>l" )

-- Quit
nnoremap( "<A-q>", "<cmd>q<CR>" )

-- Harpoon
nnoremap( "<A-a>", [[:lua require( "obszczymucha.harpoon" ).add_file()<CR>]], { silent = true } )
nnoremap( "<A-f>", [[:lua require( "harpoon.ui" ).toggle_quick_menu()<CR>]], { silent = true } )
nnoremap( "<A-1>", [[:lua require( "harpoon.ui" ).nav_file( 1 )<CR>]], { silent = true } )
nnoremap( "<A-2>", [[:lua require( "harpoon.ui" ).nav_file( 2 )<CR>]], { silent = true } )
nnoremap( "<A-3>", [[:lua require( "harpoon.ui" ).nav_file( 3 )<CR>]], { silent = true } )
nnoremap( "<A-4>", [[:lua require( "harpoon.ui" ).nav_file( 4 )<CR>]], { silent = true } )
nnoremap( "<A-5>", [[:lua require( "harpoon.ui" ).nav_file( 5 )<CR>]], { silent = true } )
nnoremap( "<A-6>", [[:lua require( "harpoon.ui" ).nav_file( 6 )<CR>]], { silent = true } )

-- Moving lines
nnoremap( "<A-S-j>", "<cmd>m .+1<CR>==" )
nnoremap( "<A-S-k>", "<cmd>m .-2<CR>==" )
inoremap( "<A-S-j>", "<Esc><cmd>m .+1<CR>==gi" )
inoremap( "<A-S-k>", "<Esc><cmd>m .-2<CR>==gi" )
vnoremap( "<A-S-j>", ":m '>+1<CR>gv=gv" )
vnoremap( "<A-S-k>", ":m '<-2<CR>gv=gv" )

-- greatest remap ever : ThePrimeagen
xnoremap( "<leader>p", "\"_dP" )

-- next greatest remap ever : asbjornHaland : ThePrimeagen
nnoremap( "<leader>y", "\"+y" )
vnoremap( "<leader>y", "\"+y" )

nnoremap( "<leader>d", "\"_d" )
vnoremap( "<leader>d", "\"_d" )

local function smoothie_smart_down()
  local row, _ = unpack( vim.api.nvim_win_get_cursor( 0 ) )
  local middle = math.ceil( vim.api.nvim_win_get_height( 0 ) / 2 )

  if row < middle then
    vim.cmd( [[call smoothie#do( "M" )]] )
  else
    vim.cmd( [[call smoothie#do( "\<C-d>" )]] )
  end
end

local function smoothie_smart_up()
  local line = function( pos ) return vim.api.nvim_eval( string.format( 'line( "%s" )', pos ) ) end
  local current = line( "." )
  local top = line( "w0" )
  local relative = current - top + 1
  local middle = math.ceil( vim.api.nvim_win_get_height( 0 ) / 2 )

  if relative > middle then
    vim.cmd( [[call smoothie#do( "M" )]] )
  else
    vim.cmd( [[call smoothie#do( "\<C-u>" )]] )
  end
end

local function smoothie_page_down( key )
  vim.cmd( [[call smoothie#do( "\<C-f>" )]] )
end

local function smoothie_page_up( key )
  vim.cmd( [[call smoothie#do( "\<C-b>" )]] )
end

function M.bind( binding_name )
  local filetype = vim.bo.filetype
  local module = prequire( string.format( "obszczymucha.keymaps.%s", filetype ) )

  if module and module[ binding_name ] then
    module[ binding_name ]()
    return
  end

  local f = require( "obszczymucha.keymaps.default" )[ binding_name ]
  if f then f() end
end

nnoremap( "<C-d>", function() smoothie_smart_down() end )
nnoremap( "<C-u>", function() smoothie_smart_up() end )
nnoremap( "<C-f>", function() smoothie_page_down() end )
nnoremap( "<C-b>", function() smoothie_page_up() end )
nnoremap( "G", [[:call smoothie#do( "G" )<CR>]], { silent = true } )
nnoremap( "gg", [[:call smoothie#do( "gg" )<CR>]], { silent = true } )
nnoremap( "zz", [[:call smoothie#do( "zz" )<CR>]], { silent = true } )
nnoremap( "zt", [[:call smoothie#do( "zt" )<CR>]], { silent = true } )
nnoremap( "zb", [[:call smoothie#do( "zb" )<CR>]], { silent = true } )

inoremap( "<C-c>", "<Esc>" )

-- wildmenu is the completion menu in the command line
cnoremap( "<C-j>", [[wildmenumode() ? "\<C-n>" : "\<C-j>"]], { expr = true } )
cnoremap( "<C-k>", [[wildmenumode() ? "\<C-p>" : "\<C-k>"]], { expr = true } )
cnoremap( "<CR>", [[wildmenumode() ? "\<Up>" : "\<CR>"]], { expr = true } )

local function remap( name )
  return string.format( string.format( "<cmd>lua require( 'obszczymucha.remap' ).bind( '%s' )<CR>", name ) )
end

-- Filetype-based mappings. See obszczymucha/kemaps
nmap( "gd", remap( "go_to_definition" ), { silent = true } )
nmap( "gj", remap( "peek_definition" ), { silent = true } )
nmap( "gr", remap( "references" ), { silent = true } )
nmap( "K", remap( "documentation" ), { silent = true } )
nmap( "<leader>rn", remap( "rename" ), { silent = true } )
nmap( "<leader>F", remap( "format_file" ), { silent = true, nowait = true } )
nmap( "]g", remap( "next_diagnostic" ), { silent = true } )
nmap( "[g", remap( "prev_diagnostic" ), { silent = true } )
nmap( "<leader>o", remap( "outline" ), { silent = true, nowait = true } )
nmap( "<leader>ac", remap( "code_action" ), { silent = true } )
nmap( "<leader>cl", remap( "code_lens" ), { silent = true } )

local function test()
  print( "Princess Kenny" )
end

nnoremap( "<leader>q", function() return test() end )

-- Tab navigation
nnoremap( "<leader>t", "<cmd>tabe<CR>", { silent = true } )
nnoremap( "<C-h>", "<cmd>tabp<CR>", { silent = true } )
nnoremap( "<C-l>", "<cmd>tabn<CR>", { silent = true } )

-- Debugging
nnoremap( "<leader>dr", [[:lua require'dap'.repl.toggle()<CR>]], { silent = true } )
nnoremap( "<F7>", [[:lua require'dap'.step_into()<CR>]], { silent = true } )
nnoremap( "<F8>", [[:lua require'dap'.step_over()<CR>]], { silent = true } )
nnoremap( "<F9>", [[:lua require'dap'.toggle_breakpoint()<CR>]], { silent = true } )
nnoremap( "<F10>", [[:lua require'dap'.continue()<CR>]], { silent = true } )

-- Surround mappings
vnoremap( "<space>\"", "<Esc>`>a\"<Esc>`<i\"<Esc>w" )
vnoremap( "<space>'", "<Esc>`>a'<Esc>`<i'<Esc>w" )
vnoremap( "<space>{", "<Esc>`>a}<Esc>`<i{<Esc>w" )
vnoremap( "<space>(", "<Esc>`>a)<Esc>`<i(<Esc>w" )
vnoremap( "<space>[", "<Esc>`>a]<Esc>`<i[<Esc>w" )
vnoremap( "<space><BS>", "<Esc>`>x`<x" )

return M
