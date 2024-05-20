require( "obszczymucha.globals" )

local M = {}
local config = require( "obszczymucha.user-config" )

-- Telescope
vim.keymap.set( "n", "<leader>ff", "<cmd>lua R( 'obszczymucha.telescope' ).find_files()<CR>", { desc = "Find files" } )
vim.keymap.set( "n", "<leader>fr", "<cmd>lua R( 'obszczymucha.telescope' ).resume()<CR>", { desc = "Resume find files" } )
vim.keymap.set( "n", "<leader>fg", "<cmd>lua R( 'obszczymucha.telescope' ).live_grep()<CR>", { desc = "Search" } )
vim.keymap.set( "n", "<leader>fF", "<cmd>lua R( 'obszczymucha.telescope' ).find_files( true )<CR>",
  { desc = "Find hidden files" } )
vim.keymap.set( "n", "<leader>fG", "<cmd>lua R( 'obszczymucha.telescope' ).live_grep( true )<CR>",
  { desc = "Search hidden" } )
vim.keymap.set( "n", "<leader>fb", "<cmd>lua R( 'obszczymucha.telescope' ).buffers()<CR>", { desc = "Buffers" } )
vim.keymap.set( "n", "<leader>fh", "<cmd>lua R( 'obszczymucha.telescope' ).help_tags()<CR>", { desc = "Help Tags" } )
vim.keymap.set( "n", "<leader>fH", "<cmd>lua R( 'obszczymucha.telescope' ).highlights()<CR>", { desc = "Highlights" } )
vim.keymap.set( "n", "<leader>fd", "<cmd>lua R( 'obszczymucha.telescope' ).diagnostics()<CR>", { desc = "Diagnostics" } )
vim.keymap.set( "n", "<leader>fn", "<cmd>Telescope noice<CR>", { desc = "Noice", silent = true } )
vim.keymap.set( "n", "<leader>rg", "<cmd>lua R( 'obszczymucha.telescope' ).registers()<CR>", { desc = "Registers" } )
vim.keymap.set( "n", "<leader>gc", "<cmd>lua R( 'obszczymucha.telescope' ).git_commits()<CR>", { desc = "Git commits" } )
vim.keymap.set( "n", "<leader>gb", "<cmd>lua R( 'obszczymucha.telescope' ).git_branches()<CR>", { desc = "Git branches" } )
vim.keymap.set( "n", "<leader>fp", "<cmd>lua R( 'obszczymucha.telescope' ).breakpoints()<CR>", { desc = "Breakpoints" } )
vim.keymap.set( "n", "_", "<cmd>lua R( 'obszczymucha.telescope' ).file_browser()<CR>", { desc = "File browser" } )
vim.keymap.set( "n", "<F37>", "<cmd>lua R( 'obszczymucha.telescope' ).notify()<CR>", { desc = "Notifications" } )

-- For Mac
vim.keymap.set( "n", "<M-F1>", "<cmd>lua R( 'obszczymucha.telescope' ).notify()<CR>", { desc = "Notifications" } )

-- Git
vim.keymap.set( "n", "<leader>gl", "<cmd>GitBlameToggle<CR>", { desc = "Git blame" } )

-- Notifications
if is_wsl then
  vim.keymap.set( "n", "<F38>", "<cmd>lua require('notify').dismiss()<CR>", { desc = "Dismiss notification" } )
else
  vim.keymap.set( "n", "<A-Esc>", "<cmd>lua require('notify').dismiss()<CR>", { desc = "Dismiss notification" } )
end

-- Debug
vim.keymap.set( "n", "<leader>dq", "<cmd>lua require( 'obszczymucha.debug' ).toggle()<CR>",
  { desc = "Toggle test debug" } )
vim.keymap.set( "n", "<leader>dQ", "<cmd>lua require( 'obszczymucha.debug' ).toggle_horizontal()<CR>",
  { desc = "Toggle test debug (horizontal)" } )
vim.keymap.set( "n", "<leader>ds", "<cmd>lua require( 'obszczymucha.debug' ).flip()<CR>", { desc = "Flip test debug" } )
vim.keymap.set( "n", "<leader>dc", "<cmd>lua require( 'obszczymucha.debug' ).clear()<CR>", { desc = "Clear test debug" } )
vim.keymap.set( "n", "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<CR>",
  { desc = "Debug hover", silent = true } )

-- nvim-tree
vim.keymap.set( "n", "<leader>dw", ":NvimTreeToggle<CR>", { silent = true, desc = "NvimTreeToggle" } )

-- Create a file under cursor
vim.keymap.set( "n", "<leader>gf", "<cmd>e <cfile><CR>", { desc = "Create a file under cursor" } )

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

if is_wsl then
  vim.keymap.set( "n", "<A-p>", ":r!pbpaste<CR>", { silent = true } )
  vim.keymap.set( "v", "<A-p>",
    ":<c-u>'<,'>delete | set paste | execute \"normal i\".system(\"pbpaste\") | set nopaste<CR>", { silent = true } )

  --local npaste_cmd = ":set paste | execute \"normal a\".system(\"pbpaste\") | set nopaste<CR>"
  --vim.keymap.set( "n", "<A-S-p>", npaste_cmd, { silent = true } )
  local vpaste_cmd = ":<c-u>'<,'>delete | set paste | execute \"normal i\".system(\"pbpaste\") | set nopaste<CR>"
  vim.keymap.set( "v", "<A-S-p>", vpaste_cmd, { silent = true } )
else
  vim.keymap.set( "n", "<A-p>", "\"+p" )
  vim.keymap.set( "v", "<A-p>", "\"+p" )
  vim.keymap.set( "n", "<A-S-p>", "\"+P" )
  vim.keymap.set( "v", "<A-S-p>", "\"+P" )
  vim.keymap.set( "v", "<A-C-p>", ':<c-u>\'<,\'>s/\\r/\\r/g<cr>' )
end

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

function M.jumplist_count( key )
  local count = vim.v.count

  if count > 1 then
    vim.cmd( "normal! m'" )
    vim.cmd( "normal! " .. count .. key )

    if config.auto_center() then
      vim.cmd( "normal! zz" )
    end
  else
    vim.cmd( "normal! " .. key )
  end
end

local function smart_center_next( template )
  return function()
    local ok, result = pcall( vim.api.nvim_command, string.format( template, config.auto_center() and "zz" or "" ) )

    if not ok then
      local pattern = "E486: "
      local index = string.find( result, pattern )

      if index then
        local message = string.sub( result, index + string.len( pattern ) )
        vim.notify( message, vim.log.levels.INFO )
      else
        vim.notify( result, vim.log.levels.ERROR )
      end
    end
  end
end

-- Navigation
vim.keymap.set( 'n', 'k', "<cmd>lua R( 'obszczymucha.remap' ).jumplist_count( 'k' )<CR>" )
vim.keymap.set( 'n', 'j', "<cmd>lua R( 'obszczymucha.remap' ).jumplist_count( 'j' )<CR>" )
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
vim.keymap.set( "n", "n", smart_center_next( "call smoothie#do( 'n%s' )" ), { silent = true } )
vim.keymap.set( "n", "N", smart_center_next( "call smoothie#do( 'N%s' )" ), { silent = true } )
vim.keymap.set( "n", "<C-o>", function() return config.auto_center() and "<C-o>zz" or "<C-o>" end, { expr = true } )
vim.keymap.set( "n", "<C-i>", function() return config.auto_center() and "<C-i>zz" or "<C-i>" end, { expr = true } )

-- Do I really need this?
vim.keymap.set( "i", "<C-c>", "<Esc>" )

local function remap( name )
  return string.format( string.format( "<cmd>lua R( 'obszczymucha.remap' ).bind( '%s' )<CR>", name ) )
end

local function completion_down()
  local cmp = prequire( "cmp" )
  if not cmp then return end

  if not cmp.visible() then
    cmp.complete()
  end

  cmp.select_next_item()
end

local function completion_up()
  local cmp = prequire( "cmp" )
  if not cmp then return end

  if not cmp.visible() then
    cmp.complete()
  end

  cmp.select_prev_item()
end

local function yank( register )
  return function()
    local line = vim.fn.getcmdline()
    if not line or line == "" then return end

    vim.fn.setreg( register, line )
    vim.notify( string.format( "Yanked (%s)", register ) )

    local esc = vim.api.nvim_replace_termcodes( "<Esc>", true, false, true )
    vim.api.nvim_input( esc )
  end
end

vim.keymap.set( "i", "<A-j>", completion_down, { silent = true } )
vim.keymap.set( "i", "<A-k>", completion_up, { silent = true } )
vim.keymap.set( "i", "<C-k>", remap( "signature_help" ), { silent = true } )
vim.keymap.set( "c", "<A-j>", [[ "\<C-n>" ]], { expr = true } )
vim.keymap.set( "c", "<A-k>", [[ "\<C-p>" ]], { expr = true } )
vim.keymap.set( "c", "<A-y>", yank( '"' ), { silent = true } )
vim.keymap.set( "c", "<A-Y>", yank( '+' ), { silent = true } )

-- Filetype-based mappings. See obszczymucha/kemaps
vim.keymap.set( "n", "gd", remap( "go_to_definition" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gi", remap( "go_to_implementation" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<C-k>", remap( "signature_help" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gj", remap( "peek_definition" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gr", remap( "references" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "K", remap( "documentation" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<leader>rn", remap( "rename" ), { noremap = false, silent = true, desc = "Rename under cursor" } )
vim.keymap.set( "n", "<leader>F", remap( "format_file" ),
  { noremap = false, silent = true, nowait = true, desc = "Format file" } )
vim.keymap.set( "n", "]g", remap( "next_diagnostic" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "[g", remap( "prev_diagnostic" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<leader>o", remap( "outline" ), { noremap = false, silent = true, nowait = true, desc = "Outline" } )
vim.keymap.set( "n", "<leader>ac", remap( "code_action" ), { noremap = false, silent = true, desc = "Code action" } )
vim.keymap.set( "n", "<leader>cl", remap( "code_lens" ), { noremap = false, silent = true, desc = "Code lens" } )
vim.keymap.set( "n", "<leader>tf", remap( "test_file" ), { noremap = false, silent = true, desc = "Test file" } )
vim.keymap.set( "n", "<leader>tt", remap( "test_nearest_method" ),
  { noremap = false, silent = true, desc = "Test nearest method" } )
vim.keymap.set( "n", "<leader>O", remap( "organize_imports" ),
  { noremap = false, silent = true, nowait = true, desc = "Organize imports" } )
vim.keymap.set( "n", "<leader>fc", remap( "compile" ),
  { noremap = false, silent = true, nowait = true, desc = "Compile file" } )
vim.keymap.set( "n", "<leader>j", ":%!jq --sort-keys<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Prettify JSON" } )
vim.keymap.set( "n", "<leader>J", ":%!jq -c<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Minify JSON" } )
vim.keymap.set( "v", "<leader>j", ":'<,'>%!jq<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Prettify JSON" } )
vim.keymap.set( "v", "<leader>J", ":'<,'>%!jq -c<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Minify JSON" } )

vim.keymap.set( "n", "<leader>q", "<cmd> lua R( 'obszczymucha.sandbox' ).test()<CR>", { desc = "Run sandbox code" } )

-- Tab navigation
--vim.keymap.set( "n", "<leader>T", "<cmd>tabe<CR>", { silent = true } )
--vim.keymap.set( "n", "<C-h>", "<cmd>tabp<CR>", { silent = true } )
--vim.keymap.set( "n", "<C-l>", "<cmd>tabn<CR>", { silent = true } )

-- Debugging
vim.keymap.set( "n", "<leader>dt", [[:lua require"dapui".toggle()<CR>]], { silent = true, desc = "Toggle dapui" } )
vim.keymap.set( "n", "<leader>dr", [[:lua require"dap".repl.toggle()<CR>]], { silent = true, desc = "Toggle dap repl" } )
vim.keymap.set( "n", "<F7>", [[:lua require"dap".step_into()<CR>]], { silent = true, desc = "Step into" } )
vim.keymap.set( "n", "<F8>", [[:lua require"dap".step_over()<CR>]], { silent = true, desc = "Step over" } )
vim.keymap.set( "n", "<F9>", [[:lua require"dap".toggle_breakpoint()<CR>]], { silent = true, desc = "Toggle breakpoint" } )
-- <S-F9>
vim.keymap.set( "n", "<F21>", [[:lua require"dap".toggle_breakpoint(vim.fn.input("Condition: "))<CR>]],
  { silent = true, desc = "Toggle conditional breakpoint" } )
vim.keymap.set( "n", "<F10>", [[:lua require"dap".continue()<CR>]], { silent = true, desc = "Continue or attach" } )

local function terminate_dap_session()
  local dap = prequire( "dap" )
  if not dap then
    vim.notify( "DAP not available.", vim.log.levels.WARN )
    return
  end

  vim.notify( "Terminating..." )
  dap.terminate()
  dap.repl.close()
end

-- <C-F10>
vim.keymap.set( "n", "<F34>", terminate_dap_session, { silent = true, desc = "Terminate" } )

-- Surround mappings
vim.keymap.set( "v", "<leader>\"", "<Esc>`>a\"<Esc>`<i\"<Esc>w", { desc = "Surround with \"" } )
vim.keymap.set( "v", "<leader>'", "<Esc>`>a'<Esc>`<i'<Esc>w", { desc = "Surround with '" } )
vim.keymap.set( "v", "<leader>{", "<Esc>`>a}<Esc>`<i{<Esc>w", { desc = "Surround with {}" } )
vim.keymap.set( "v", "<leader>(", "<Esc>`>a)<Esc>`<i(<Esc>w", { desc = "Surround with ()" } )
vim.keymap.set( "v", "<leader>[", "<Esc>`>a]<Esc>`<i[<Esc>w", { desc = "Surround with []" } )
vim.keymap.set( "v", "<leader><", "<Esc>`>a><Esc>`<i<<Esc>w", { desc = "Surround with <>" } )
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
  vim.notify( "Mappings reloaded." )
end

vim.keymap.set( "n", "<leader>r", ":lua require('obszczymucha.remap').reload()<CR>",
  { silent = true, desc = "Reload keymaps" } )
vim.keymap.set( "n", "<A-r>", remap( "reload" ), { silent = true } )
vim.keymap.set( "n", "<A-S-r>", ":LspRestart<CR> | :lua vim.notify( \"LSP restarted.\" )<CR>", { silent = true } )

-- Custom persistable settings
vim.keymap.set( "n", "<leader>cq", config.toggle_auto_center, { desc = "Toggle auto-center" } )

-- Custom search
-- Currently disabled, because noice gives much better search capability.
-- The only problem that needs to be fixed is the E486 when searching for
-- a non-existing phrase.
--vim.keymap.set( 'n', '/', [[<cmd>lua require( "obszczymucha.custom-search" ).forward()<CR>]] )
--vim.keymap.set( 'n', '?', [[<cmd>lua require( "obszczymucha.custom-search" ).backward()<CR>]] )

function M.jump_to_mark_and_center()
  local mark = vim.fn.getchar()
  if type( mark ) == "number" then mark = string.char( mark ) end

  local success = pcall( function()
    vim.cmd( "normal! '" .. mark )
  end )

  if success then
    vim.cmd( "normal! zz" )
  else
    vim.notify( string.format( "Mapping %s not set.", mark ) )
  end
end

function M.define_a_mark()
  local mark = vim.fn.getchar()
  if type( mark ) == "number" then mark = string.char( mark ) end

  vim.cmd( "normal! m" .. mark )
  vim.notify( string.format( "Mark %s defined.", mark ) )
end

vim.keymap.set( "n", "'", ":lua require('obszczymucha.remap').jump_to_mark_and_center()<CR>", { silent = true } )
vim.keymap.set( "n", "m", ":lua require('obszczymucha.remap').define_a_mark()<CR>", { silent = true } )

-- Vsnip
-- Strangely, vim.keymap.set causes some strange characters being shown with this.
vim.api.nvim_set_keymap( "i", "<Tab>", [[luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : "<Tab>"]],
  { expr = true, noremap = true } )
vim.api.nvim_set_keymap( "s", "<Tab>", [[luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : "<Tab>"]],
  { expr = true, noremap = true } )
vim.api.nvim_set_keymap( "i", "<S-Tab>", "<cmd>lua require('luasnip').jump(1)<CR>", { expr = true, noremap = true } )
vim.api.nvim_set_keymap( "s", "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<CR>", { expr = true, noremap = true } )

-- Treesitter
vim.keymap.set( "n", "<S-t>", ":Inspect<CR>", { silent = true } )

-- Mason and Lazy
vim.keymap.set( "n", "<leader>M", ":Mason<CR>", { silent = true } )
vim.keymap.set( "n", "<leader>L", ":Lazy<CR>", { silent = true } )

-- Markdown
vim.keymap.set( "n", "<leader>m", ":MarkdownPreviewToggle<CR>", { silent = true } )

-- WhichKey
vim.keymap.set( "n", "<A-w>", ":WhichKey<CR>", { silent = true } )

-- neoclip
vim.keymap.set( "n", "<leader>Y", ":Telescope neoclip<CR>", { silent = true, desc = "Telescope neoclip" } )

return M
