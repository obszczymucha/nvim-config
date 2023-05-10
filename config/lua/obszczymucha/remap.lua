local M = {}
local prequire = require( "obszczymucha.common" ).prequire

-- Telescope
vim.keymap.set( "n", "<leader>ff", "<cmd>lua R( 'obszczymucha.telescope' ).find_files()<CR>" )
vim.keymap.set( "n", "<leader>fr", "<cmd>lua R( 'obszczymucha.telescope' ).resume()<CR>" )
vim.keymap.set( "n", "<leader>fg", "<cmd>lua R( 'obszczymucha.telescope' ).live_grep()<CR>" )
vim.keymap.set( "n", "<leader>fF", "<cmd>lua R( 'obszczymucha.telescope' ).find_files( true )<CR>" )
vim.keymap.set( "n", "<leader>fG", "<cmd>lua R( 'obszczymucha.telescope' ).live_grep( true )<CR>" )
vim.keymap.set( "n", "<leader>fb", "<cmd>lua R( 'obszczymucha.telescope' ).buffers()<CR>" )
vim.keymap.set( "n", "<leader>fh", "<cmd>lua R( 'obszczymucha.telescope' ).help_tags()<CR>" )
vim.keymap.set( "n", "<leader>fH", "<cmd>lua R( 'obszczymucha.telescope' ).highlights()<CR>" )
vim.keymap.set( "n", "<leader>fd", "<cmd>lua R( 'obszczymucha.telescope' ).diagnostics()<CR>" )
vim.keymap.set( "n", "<leader>rg", "<cmd>lua R( 'obszczymucha.telescope' ).registers()<CR>" )
vim.keymap.set( "n", "<leader>gc", "<cmd>lua R( 'obszczymucha.telescope' ).git_commits()<CR>" )
vim.keymap.set( "n", "<leader>gb", "<cmd>lua R( 'obszczymucha.telescope' ).git_branches()<CR>" )
vim.keymap.set( "n", "-", "<cmd>lua R( 'obszczymucha.telescope' ).file_browser()<CR>" )
vim.keymap.set( "n", "<F37>", "<cmd>lua R( 'obszczymucha.telescope' ).notify()<CR>" )
-- For Mac
vim.keymap.set( "n", "<M-F1>", "<cmd>lua R( 'obszczymucha.telescope' ).notify()<CR>" )

-- Git
vim.keymap.set( "n", "<leader>gt", "<cmd>GitBlameToggle<CR>" )

-- Notifications
vim.keymap.set( "n", "<A-Esc>", "<cmd>lua require('notify').dismiss()<CR>" )

-- Debug
vim.keymap.set( "n", "<leader>dq", "<cmd>lua require( 'obszczymucha.debug' ).toggle()<CR>" )
vim.keymap.set( "n", "<leader>dc", "<cmd>lua require( 'obszczymucha.debug' ).clear()<CR>" )

-- Create a file under cursor
vim.keymap.set( "n", "<leader>gf", "<cmd>e <cfile><CR>" )

-- Window management
vim.keymap.set( "n", "<A-v>", "<C-w>v<C-w>w" )
vim.keymap.set( "n", "<A-V>", "<C-w>v<C-w>w<cmd>lua R( 'obszczymucha.telescope' ).find_files()<CR>" )
vim.keymap.set( "n", "<A-s>", "<C-w>s<C-w>w" )
vim.keymap.set( "n", "<A-S>", "<C-w>s<C-w>w<cmd>lua R( 'obszczymucha.telescope' ).find_files()<CR>" )
vim.keymap.set( "n", "<S-A-j>", "<C-w>j" )
vim.keymap.set( "n", "<S-A-k>", "<C-w>k" )
vim.keymap.set( "n", "<S-A-h>", "<C-w>h" )
vim.keymap.set( "n", "<S-A-l>", "<C-w>l" )

-- Quit
vim.keymap.set( "n", "<A-q>", "<cmd>q<CR>" )

-- Harpoon
vim.keymap.set( "n", "<A-a>", [[:lua require( "obszczymucha.harpoon" ).add_file()<CR>]], { silent = true } )
vim.keymap.set( "n", "<A-f>", [[:lua require( "harpoon.ui" ).toggle_quick_menu()<CR>]], { silent = true } )
vim.keymap.set( "n", "<A-1>", [[:lua require( "harpoon.ui" ).nav_file( 1 )<CR>]], { silent = true } )
vim.keymap.set( "n", "<A-2>", [[:lua require( "harpoon.ui" ).nav_file( 2 )<CR>]], { silent = true } )
vim.keymap.set( "n", "<A-3>", [[:lua require( "harpoon.ui" ).nav_file( 3 )<CR>]], { silent = true } )
vim.keymap.set( "n", "<A-4>", [[:lua require( "harpoon.ui" ).nav_file( 4 )<CR>]], { silent = true } )
vim.keymap.set( "n", "<A-5>", [[:lua require( "harpoon.ui" ).nav_file( 5 )<CR>]], { silent = true } )
vim.keymap.set( "n", "<A-6>", [[:lua require( "harpoon.ui" ).nav_file( 6 )<CR>]], { silent = true } )

-- Moving lines
vim.keymap.set( "n", "<C-A-j>", "<cmd>m .+1<CR>==" )
vim.keymap.set( "n", "<C-A-k>", "<cmd>m .-2<CR>==" )
vim.keymap.set( "i", "<C-A-j>", "<Esc><cmd>m .+1<CR>==gi" )
vim.keymap.set( "i", "<C-A-k>", "<Esc><cmd>m .-2<CR>==gi" )
vim.keymap.set( "v", "<C-A-j>", ":m '>+1<CR>gv=gv" )
vim.keymap.set( "v", "<C-A-k>", ":m '<-2<CR>gv=gv" )

-- Copy / paste
vim.keymap.set( "x", "<leader>p", "\"_dP" )
vim.keymap.set( "n", "<leader>y", "\"+y" )
vim.keymap.set( "v", "<leader>y", "\"+y" )
vim.keymap.set( "n", "<A-p>", "\"+p" )
vim.keymap.set( "v", "<A-p>", "\"+p" )
vim.keymap.set( "n", "<A-S-p>", "\"+P" )
vim.keymap.set( "v", "<A-S-p>", "\"+P" )
vim.keymap.set( "v", "<A-C-p>", ':<c-u>\'<,\'>s/\\r/\\r/g<cr>' )
vim.keymap.set( "n", "<leader>d", "\"_d" )
vim.keymap.set( "v", "<leader>d", "\"_d" )
vim.keymap.set( "n", "<leader>c", "\"_c" )
vim.keymap.set( "n", "<leader>x", "\"_x" )

-- Smoothie
---@diagnostic disable-next-line: unused-function, unused-local
local function smoothie_smart_down()
  --local row, _ = unpack( vim.api.nvim_win_get_cursor( 0 ) )
  --local middle = math.floor( vim.api.nvim_win_get_height( 0 ) / 2 )

  ---@diagnostic disable-next-line: unused-function
  local line = function( pos ) return vim.api.nvim_eval( string.format( 'line( "%s" )', pos ) ) end
  local current = line( "." )
  local top = line( "w0" )
  local relative = current - top + 1
  local middle = math.floor( vim.api.nvim_win_get_height( 0 ) / 2 )
  --print(string.format("middle: %s, relative: %s", middle, relative))

  if relative < middle then
    vim.cmd( [[call smoothie#do( "M" )]] )
  else
    vim.cmd( [[call smoothie#do( "\<C-d>" )]] )
  end
end

---@diagnostic disable-next-line: unused-local, unused-function
local function smoothie_smart_up()
  ---@diagnostic disable-next-line: unused-function
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

function M.smoothie_down()
  vim.cmd( [[call smoothie#do( "\<C-d>" )]] )
end

function M.smoothie_up()
  vim.cmd( [[call smoothie#do( "\<C-u>" )]] )
end

function M.smoothie_down2()
  vim.cmd( [[call smoothie#do( "M\<C-d>" )]] )
end

function M.smoothie_up2()
  vim.cmd( [[call smoothie#do( "M\<C-u>" )]] )
end

local function smoothie_page_down()
  vim.cmd( [[call smoothie#do( "\<C-f>" )]] )
end

local function smoothie_page_up()
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

vim.keymap.set( "n", "<A-e>", "<C-e>j" )
vim.keymap.set( "n", "<A-y>", "<C-y>k" )
vim.keymap.set( "n", "<A-j>", "<C-e>j" )
vim.keymap.set( "n", "<A-k>", "<C-y>k" )
--vim.keymap.set( "n", "<A-d>", function() smoothie_smart_down() end )
--vim.keymap.set( "n", "<A-u>", function() smoothie_smart_up() end )
vim.keymap.set( "n", "<A-d>", "<cmd>lua R( 'obszczymucha.remap' ).smoothie_down2()<CR>" )
vim.keymap.set( "n", "<A-u>", "<cmd>lua R( 'obszczymucha.remap' ).smoothie_up2()<CR>" )
vim.keymap.set( "n", "<C-d>", "<cmd>lua R( 'obszczymucha.remap' ).smoothie_down()<CR>" )
vim.keymap.set( "n", "<C-u>", "<cmd>lua R( 'obszczymucha.remap' ).smoothie_up()<CR>" )
vim.keymap.set( "n", "<C-f>", function() smoothie_page_down() end )
vim.keymap.set( "n", "<C-b>", function() smoothie_page_up() end )
vim.keymap.set( "n", "G", [[:call smoothie#do( "G" )<CR>]], { silent = true } )
vim.keymap.set( "n", "gg", [[:call smoothie#do( "gg" )<CR>]], { silent = true } )
vim.keymap.set( "n", "zz", [[:call smoothie#do( "zz" )<CR>]], { silent = true } )
vim.keymap.set( "n", "zt", [[:call smoothie#do( "zt" )<CR>]], { silent = true } )
vim.keymap.set( "n", "zb", [[:call smoothie#do( "zb" )<CR>]], { silent = true } )
vim.keymap.set( "n", "zq", [[:call smoothie#do( "zt" )<CR>]], { silent = true } )
vim.keymap.set( "n", "M", [[:call smoothie#do( "M" )<CR>]], { silent = true } )
vim.keymap.set( "n", "H", [[:call smoothie#do( "H" )<CR>]], { silent = true } )
vim.keymap.set( "n", "L", [[:call smoothie#do( "L" )<CR>]], { silent = true } )
vim.keymap.set( "n", "n", [[:call smoothie#do( "nzz" )<CR>]], { silent = true } )
vim.keymap.set( "n", "N", [[:call smoothie#do( "Nzz" )<CR>]], { silent = true } )
vim.keymap.set( "n", "<C-o>", "<C-o>zz" )
vim.keymap.set( "n", "<C-i>", "<C-i>zz" )

-- Do I really need this?
vim.keymap.set( "i", "<C-c>", "<Esc>" )

local function remap( name )
  return string.format( string.format( "<cmd>lua R( 'obszczymucha.remap' ).bind( '%s' )<CR>", name ) )
end

local function completion_down_or( orFunction )
  local cmp = prequire( "cmp" )
  if not cmp then return end

  if cmp.visible() then
    cmp.select_next_item()
  elseif orFunction then
    orFunction()
  end
end

local function completion_up_or( orFunction )
  local cmp = prequire( "cmp" )
  if not cmp then return end

  if cmp.visible() then
    cmp.select_prev_item()
  elseif orFunction then
    orFunction()
  end
end

vim.keymap.set( "i", "<A-j>", function() completion_down_or() end )
vim.keymap.set( "i", "<A-k>", function() completion_up_or() end )
vim.keymap.set( "i", "<C-k>", remap( "signature_help" ), { silent = true } )

-- wildmenu is the completion menu in the command line
vim.keymap.set( "c", "<A-j>", [[wildmenumode() ? "\<C-n>" : "\<C-j>"]], { expr = true } )
vim.keymap.set( "c", "<A-k>", [[wildmenumode() ? "\<C-p>" : "\<C-k>"]], { expr = true } )

-- Filetype-based mappings. See obszczymucha/kemaps
vim.keymap.set( "n", "gd", remap( "go_to_definition" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gi", remap( "go_to_implementation" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<C-k>", remap( "signature_help" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gj", remap( "peek_definition" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gr", remap( "references" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "K", remap( "documentation" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<leader>rn", remap( "rename" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<leader>F", remap( "format_file" ), { noremap = false, silent = true, nowait = true } )
vim.keymap.set( "n", "]g", remap( "next_diagnostic" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "[g", remap( "prev_diagnostic" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<leader>o", remap( "outline" ), { noremap = false, silent = true, nowait = true } )
vim.keymap.set( "n", "<leader>ac", remap( "code_action" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<leader>cl", remap( "code_lens" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<leader>tf", remap( "test_file" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<leader>tt", remap( "test_nearest_method" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<leader>O", remap( "organize_imports" ), { noremap = false, silent = true, nowait = true } )
vim.keymap.set( "n", "<leader>fc", remap( "compile" ), { noremap = false, silent = true, nowait = true } )
vim.keymap.set( "n", "<leader>j", ":%!jq --sort-keys<CR>", { noremap = false, silent = true, nowait = true } )
vim.keymap.set( "n", "<leader>J", ":%!jq -c<CR>", { noremap = false, silent = true, nowait = true } )
vim.keymap.set( "v", "<leader>j", ":'<,'>%!jq<CR>", { noremap = false, silent = true, nowait = true } )
vim.keymap.set( "v", "<leader>J", ":'<,'>%!jq -c<CR>", { noremap = false, silent = true, nowait = true } )

function M.test()
  print( "Hello!" )
end

vim.keymap.set( "n", "<leader>q", "<cmd> lua R( 'obszczymucha.remap' ).test()<CR>" )

-- Tab navigation
--vim.keymap.set( "n", "<leader>T", "<cmd>tabe<CR>", { silent = true } )
--vim.keymap.set( "n", "<C-h>", "<cmd>tabp<CR>", { silent = true } )
--vim.keymap.set( "n", "<C-l>", "<cmd>tabn<CR>", { silent = true } )

-- Debugging
vim.keymap.set( "n", "<leader>dt", [[:lua require'dapui'.toggle()<CR>]], { silent = true } )
vim.keymap.set( "n", "<leader>dr", [[:lua require'dap'.repl.toggle()<CR>]], { silent = true } )
vim.keymap.set( "n", "<F7>", [[:lua require'dap'.step_into()<CR>]], { silent = true } )
vim.keymap.set( "n", "<F8>", [[:lua require'dap'.step_over()<CR>]], { silent = true } )
vim.keymap.set( "n", "<F9>", [[:lua require'dap'.toggle_breakpoint()<CR>]], { silent = true } )
vim.keymap.set( "n", "<F10>", [[:lua require'dap'.continue()<CR>]], { silent = true } )

-- Surround mappings
vim.keymap.set( "v", "<leader>\"", "<Esc>`>a\"<Esc>`<i\"<Esc>w" )
vim.keymap.set( "v", "<leader>'", "<Esc>`>a'<Esc>`<i'<Esc>w" )
vim.keymap.set( "v", "<leader>{", "<Esc>`>a}<Esc>`<i{<Esc>w" )
vim.keymap.set( "v", "<leader>(", "<Esc>`>a)<Esc>`<i(<Esc>w" )
vim.keymap.set( "v", "<leader>[", "<Esc>`>a]<Esc>`<i[<Esc>w" )
vim.keymap.set( "v", "<leader><BS>", "<Esc>`>x`<x" )
vim.keymap.set( "n", "<leader><BS>", "\"_v%<Esc>`>x`<x" )
vim.keymap.set( "i", "<A-W>", remap( "fast_continuous_wrap" ), { silent = true } )
vim.keymap.set( "i", "<A-w>", remap( "fast_word_wrap" ), { silent = true } )

-- Treehopper
vim.keymap.set( "o", "m", [[:<C-U>lua require'tsht'.nodes()<CR>]], { noremap = false, silent = true } )
vim.keymap.set( "x", "m", [[:lua require'tsht'.nodes()<CR>]], { silent = true } )

-- This automatically closes the find references window when e is pressd. I've no idea how this works.
vim.api.nvim_create_autocmd( "FileType", {
  callback = function()
    local bufnr = vim.fn.bufnr( '%' )
    vim.keymap.set( "n", "e", function()
      vim.api.nvim_command( [[execute "normal! \<cr>"]] )
      vim.api.nvim_command( bufnr .. 'bd' )
    end, { buffer = bufnr } )
  end,
  pattern = "qf",
} )

vim.keymap.set( "n", "<Esc>", function()
  for _, id in pairs( vim.api.nvim_list_wins() ) do
    local buf = vim.api.nvim_win_get_buf( id )
    local filetype = vim.api.nvim_buf_get_option( buf, "filetype" )

    if filetype == "qf" then
      vim.api.nvim_win_close( id, false )
      return
    end
  end
end, { silent = true } )

-- Reloading
function M.reload()
  R( "obszczymucha.remap" )
  print( "Mappings reloaded." )
end

vim.keymap.set( "n", "<leader>r", ":lua require('obszczymucha.remap').reload()<CR>", { silent = true } )
vim.keymap.set( "n", "<A-r>", remap( "reload" ), { silent = true } )
vim.keymap.set( "n", "<A-S-r>", ":LspRestart<CR> | :echo \"LSP restarted.\"<CR>", { silent = true } )

return M
