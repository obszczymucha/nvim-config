require( "obszczymucha.globals" )

local M = {}
local config = require( "obszczymucha.user-config" )

-- Telescope
vim.keymap.set( "n", "<leader>fs", "<cmd>lua R( 'obszczymucha.telescope' ).find_files()<CR>", { desc = "Find files" } )
vim.keymap.set( "n", "<leader>fS", "<cmd>lua R( 'obszczymucha.telescope' ).find_files( true )<CR>",
  { desc = "Find hidden files" } )
vim.keymap.set( "n", "<leader>fr", "<cmd>lua R( 'obszczymucha.telescope' ).resume()<CR>", { desc = "Resume find files" } )
-- vim.keymap.set( "n", "<leader>fe", "<cmd>lua R( 'obszczymucha.telescope' ).live_grep()<CR>", { desc = "Search" } )
vim.keymap.set( "n", "<leader>fe", "<cmd>lua R( 'obszczymucha.telescope' ).live_multigrep()<CR>", { desc = "Search" } )
vim.keymap.set( "n", "<leader>fE", "<cmd>lua R( 'obszczymucha.telescope' ).live_grep( true )<CR>",
  { desc = "Search hidden" } )
vim.keymap.set( "n", "<leader>/", "<cmd>lua R( 'obszczymucha.telescope' ).current_buffer_fuzzy_find()<CR>",
  { desc = "Current buffer fuzzy find" } )
vim.keymap.set( "n", "<leader>fb", "<cmd>lua R( 'obszczymucha.telescope' ).buffers()<CR>", { desc = "Buffers" } )
vim.keymap.set( "n", "<leader>fh", "<cmd>lua R( 'obszczymucha.telescope' ).help_tags()<CR>", { desc = "Help Tags" } )
vim.keymap.set( "n", "<leader>fH", "<cmd>lua R( 'obszczymucha.telescope' ).highlights()<CR>", { desc = "Highlights" } )
vim.keymap.set( "n", "<leader>fd", "<cmd>lua R( 'obszczymucha.telescope' ).diagnostics()<CR>", { desc = "Diagnostics" } )
vim.keymap.set( "n", "<leader>rg", "<cmd>lua R( 'obszczymucha.telescope' ).registers()<CR>", { desc = "Registers" } )
vim.keymap.set( "n", "<leader>gc", "<cmd>lua R( 'obszczymucha.telescope' ).git_commits()<CR>", { desc = "Git commits" } )
vim.keymap.set( "n", "<leader>gb", "<cmd>lua R( 'obszczymucha.telescope' ).git_branches()<CR>", { desc = "Git branches" } )
vim.keymap.set( "n", "<leader>fp", "<cmd>lua R( 'obszczymucha.telescope' ).breakpoints()<CR>", { desc = "Breakpoints" } )
vim.keymap.set( "n", "<leader>fq", "<cmd>lua R( 'obszczymucha.telescope' ).quickfix_history()<CR>",
  { desc = "Quickfix history" } )
vim.keymap.set( "n", "_", "<cmd>lua R( 'obszczymucha.telescope' ).file_browser()<CR>", { desc = "File browser" } )
vim.keymap.set( "n", "<leader>fn", "<cmd>lua R( 'obszczymucha.telescope' ).notify()<CR>", { desc = "Notifications" } )
vim.keymap.set( "n", "<leader>fy", "<cmd>lua R( 'obszczymucha.telescope' ).neoclip()<CR>",
  { silent = true, desc = "Neoclip" } )
vim.keymap.set( "n", "<leader>fg", "<cmd>lua R( 'obszczymucha.telescope' ).oil_dir()<CR>",
  { desc = "Directory search (Oil)" } )

-- For Mac
vim.keymap.set( "n", "<M-F1>", "<cmd>lua R( 'obszczymucha.telescope' ).notify()<CR>", { desc = "Notifications" } )

-- Git
vim.keymap.set( "n", "gl", "<cmd>GitMessenger<CR>", { silent = true, desc = "Git blame" } )

-- Notifications
if is_wsl then
  vim.keymap.set( "n", "<F38>", "<cmd>lua require('notify').dismiss()<CR>", { desc = "Dismiss notification" } )
elseif is_macos then
  vim.keymap.set( "n", "<F37>", "<cmd>lua require('notify').dismiss()<CR>", { desc = "Dismiss notification" } )
else
  vim.keymap.set( "n", "<A-Esc>", "<cmd>lua require('notify').dismiss()<CR>", { desc = "Dismiss notification" } )
end

local function remap( name )
  return string.format( string.format( "<cmd>lua R( 'obszczymucha.remap' ).bind( '%s' )<CR>", name ) )
end

-- Debug
vim.keymap.set( "n", "<leader>dv", "<cmd>lua require( 'obszczymucha.debug' ).toggle()<CR>",
  { desc = "Toggle test debug" } )
vim.keymap.set( "n", "<leader>dV", "<cmd>lua require( 'obszczymucha.debug' ).toggle_horizontal()<CR>",
  { desc = "Toggle test debug (horizontal)" } )
vim.keymap.set( "n", "<leader>dq", remap( "show_test_results" ), { noremap = true, desc = "Show test results (popup)" } )
vim.keymap.set( "n", "<leader>ds", "<cmd>lua require( 'obszczymucha.debug' ).flip()<CR>", { desc = "Flip test debug" } )
vim.keymap.set( "n", "<leader>dc", "<cmd>lua require( 'obszczymucha.debug' ).clear()<CR>", { desc = "Clear test debug" } )
vim.keymap.set( "n", "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<CR>",
  { desc = "Debug hover", silent = true } )

-- File management
vim.keymap.set( "n", "<leader>gf", "<cmd>e <cfile><CR>", { desc = "Create a file under cursor" } )

-- Window management
-- vim.keymap.set( "n", "<A-v>", "<C-w>v<C-w>w" )
-- vim.keymap.set( "n", "<A-s>", "<C-w>s<C-w>w" )
vim.keymap.set( "n", "<S-A-j>", "<C-w>j" )
vim.keymap.set( "n", "<S-A-k>", "<C-w>k" )

if is_macos then
  vim.keymap.set( "n", "<S-Left>", "<C-w>h" )
  vim.keymap.set( "n", "<S-Right>", "<C-w>l" )
else
  vim.keymap.set( "n", "<S-A-h>", "<C-w>h" )
  vim.keymap.set( "n", "<S-A-l>", "<C-w>l" )
end

vim.keymap.set( "n", "<A-<>", "<C-w>5<" )
vim.keymap.set( "n", "<A->>", "<C-w>5>" )
vim.keymap.set( "n", "<A-,>", "<C-w>5-" )
vim.keymap.set( "n", "<A-.>", "<C-w>5+" )

-- Quit
vim.keymap.set( "n", "<A-q>", "<cmd>q<CR>", { desc = "Exit" } )

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
if is_wsl then
  -- Alacritty doesn't want to send Ctrl+Alt, so the only way is to use AHK.
  -- AHK is sending ^[[1;5R for <C-A-j> and ^[[1;5S for <C-A-k>.
  -- These map to <C-F3> (F27) and <C-F4> (F28) respectively.
  vim.keymap.set( "n", "<F27>", "<cmd>m .+1<CR>==" )
  vim.keymap.set( "n", "<F28>", "<cmd>m .-2<CR>==" )
  vim.keymap.set( "i", "<F27>", "<Esc><cmd>m .+1<CR>==gi" )
  vim.keymap.set( "i", "<F28>", "<Esc><cmd>m .-2<CR>==gi" )
  vim.keymap.set( "v", "<F27>", ":m '>+1<CR>gv=gv" )
  vim.keymap.set( "v", "<F28>", ":m '<-2<CR>gv=gv" )
elseif is_windows then
  vim.keymap.set( "n", "<C-F3>", "<cmd>m .+1<CR>==" )
  vim.keymap.set( "n", "<C-F4>", "<cmd>m .-2<CR>==" )
  vim.keymap.set( "i", "<C-F3>", "<Esc><cmd>m .+1<CR>==gi" )
  vim.keymap.set( "i", "<C-F4>", "<Esc><cmd>m .-2<CR>==gi" )
  vim.keymap.set( "v", "<C-F3>", ":m '>+1<CR>gv=gv" )
  vim.keymap.set( "v", "<C-F4>", ":m '<-2<CR>gv=gv" )
else
  vim.keymap.set( "n", "<C-A-j>", "<cmd>m .+1<CR>==" )
  vim.keymap.set( "n", "<C-A-k>", "<cmd>m .-2<CR>==" )
  vim.keymap.set( "i", "<C-A-j>", "<Esc><cmd>m .+1<CR>==gi" )
  vim.keymap.set( "i", "<C-A-k>", "<Esc><cmd>m .-2<CR>==gi" )
  vim.keymap.set( "v", "<C-A-j>", ":m '>+1<CR>gv=gv" )
  vim.keymap.set( "v", "<C-A-k>", ":m '<-2<CR>gv=gv" )
end

-- Copy / paste
vim.keymap.set( "x", "<leader>p", "\"_dP" )
vim.keymap.set( "n", "<leader>y", "\"+y" )

if is_wsl then
  local function copy()
    local original_report = vim.o.report
    vim.o.report = 99999
    -- When yanking into a named register, the unnamed register also gets the value.
    -- So we need to grab whatever is in the unnamed register, then restore it.
    local current = vim.fn.getreg( '"' )
    vim.cmd( 'normal! "vy' )
    local text = vim.fn.getreg( "v" )
    vim.fn.setreg( '"', current )

    local clip = os.getenv( "CLIP" )

    if not clip then
      vim.notify( "CLIP environment variable not defined.", vim.log.levels.ERROR )
      return
    end

    vim.fn.system( clip, text )
    vim.o.report = original_report
    vim.notify( "Copied to clipboard." )
  end

  vim.keymap.set( "v", "<leader>y", copy, { silent = true } )
else
  vim.keymap.set( "v", "<leader>y", "\"+y" )
end

if is_wsl or is_macos then
  vim.keymap.set( "n", "<A-p>", ":lua vim.api.nvim_put(vim.fn.systemlist('pbpaste'), '', true, true)<CR>",
    { noremap = true, silent = true } )
  vim.keymap.set( "n", "<A-P>", ":lua vim.api.nvim_put(vim.fn.systemlist('pbpaste'), '', false, true)<CR>",
    { noremap = true, silent = true } )
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

-- Navigation
vim.keymap.set( 'n', 'k', "<cmd>lua R( 'obszczymucha.navigation' ).jump_count( 'k' )<CR>" )
vim.keymap.set( 'n', 'j', "<cmd>lua R( 'obszczymucha.navigation' ).jump_count( 'j' )<CR>" )
vim.keymap.set( "n", "<A-j>", "<C-y>", { noremap = true } )
vim.keymap.set( "n", "<A-k>", "<C-e>", { noremap = true } )
vim.keymap.set( "n", "<C-e>", "<C-e>j", { noremap = true } )
vim.keymap.set( "n", "<C-y>", "<C-y>k", { noremap = true } )
-- vim.keymap.set( "n", "<A-d>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_smart_down()<CR>" )
-- vim.keymap.set( "n", "<A-u>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_smart_up()<CR>" )
vim.keymap.set( "n", "<A-d>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_down2()<CR>" )
vim.keymap.set( "n", "<A-u>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_up2()<CR>" )
vim.keymap.set( "n", "<C-d>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_down()<CR>" )
vim.keymap.set( "n", "<C-u>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_up()<CR>" )
vim.keymap.set( "n", "<C-f>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_page_down()<CR>" )
vim.keymap.set( "n", "<C-b>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_page_up()<CR>" )
vim.keymap.set( "n", "G", [[:call smoothie#do( "G" )<CR>]], { silent = true } )
vim.keymap.set( "n", "gg", [[:call smoothie#do( "gg" )<CR>]], { silent = true } )
vim.keymap.set( "n", "zz", [[:call smoothie#do( "zz" )<CR>]], { silent = true } )
vim.keymap.set( "n", "zt", [[:call smoothie#do( "zt" )<CR>]], { silent = true } )
vim.keymap.set( "n", "zb", [[:call smoothie#do( "zb" )<CR>]], { silent = true } )
vim.keymap.set( "n", "zk", ":lua R( 'obszczymucha.navigation' ).readable_pos('k')<CR>",
  { silent = true, noremap = true, desc = "Cycle readable position up" } )
vim.keymap.set( "n", "zj", ":lua R( 'obszczymucha.navigation' ).readable_pos('j')<CR>",
  { silent = true, noremap = true, desc = "Cycle readable position down" } )
vim.keymap.set( "n", "M", [[:call smoothie#do( "M" )<CR>]], { silent = true } )
vim.keymap.set( "n", "H", [[:call smoothie#do( "H" )<CR>]], { silent = true } )
vim.keymap.set( "n", "L", [[:call smoothie#do( "L" )<CR>]], { silent = true } )
vim.keymap.set( "n", "n",
  "<cmd>lua R( 'obszczymucha.navigation' ).smart_search_result( \"call smoothie#do( 'n%s' )\" )<CR>", { silent = true } )
vim.keymap.set( "n", "N",
  "<cmd>lua R( 'obszczymucha.navigation' ).smart_search_result( \"call smoothie#do( 'N%s' )\" )<CR>", { silent = true } )
vim.keymap.set( "n", "<C-o>", function() return config.auto_center() and "<C-o>zz" or "<C-o>" end, { expr = true } )
vim.keymap.set( "n", "<C-i>", function() return config.auto_center() and "<C-i>zz" or "<C-i>" end, { expr = true } )
vim.keymap.set( "n", "gk", ":lua R( 'obszczymucha.navigation' ).go_to_context()<CR>",
  { silent = true, desc = "Go to Treesitter context" } )

-- Do I really need this?
vim.keymap.set( "i", "<C-c>", "<Esc>" )

local function completion_down()
  local cmp = prequirev( "cmp" )
  if not cmp then return end

  if not cmp.visible() then
    cmp.complete()
  end

  cmp.select_next_item()
end

local function completion_up()
  local cmp = prequirev( "cmp" )
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
-- vim.keymap.set( "c", "<A-j>", [[ "\<C-n>" ]], { expr = true } )
-- vim.keymap.set( "c", "<A-k>", [[ "\<C-p>" ]], { expr = true } )
vim.keymap.set( "c", "<A-j>", completion_down, { silent = true } )
vim.keymap.set( "c", "<A-k>", completion_up, { silent = true } )
vim.keymap.set( "c", "<A-y>", yank( '"' ), { silent = true } )
vim.keymap.set( "c", "<A-Y>", yank( '+' ), { silent = true } )

-- Filetype-based mappings. See obszczymucha/kemaps
vim.keymap.set( "n", "gd", remap( "go_to_definition" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gD", remap( "type_definition" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gi", remap( "go_to_implementation" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<C-k>", remap( "signature_help" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gj", remap( "peek_definition" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "gr", remap( "references" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<C-K>", remap( "documentation" ), { noremap = false, silent = true } )
vim.keymap.set( "n", "<C-j>", vim.diagnostic.open_float, { noremap = false, silent = true } )
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
  local dap = prequirev( "dap" )
  if not dap then return end

  vim.notify( "Terminating..." )
  dap.terminate()
  dap.repl.close()
end

-- <C-F10>
vim.keymap.set( "n", "<F34>", terminate_dap_session, { silent = true, desc = "Terminate" } )

-- Surround mappings
vim.keymap.set( "v", "<leader>\"", "<Esc>`>a\"<Esc>`<i\"<Esc>w", { desc = "Surround with \"" } )
vim.keymap.set( "v", "<leader>'", "<Esc>`>a'<Esc>`<i'<Esc>w", { desc = "Surround with '" } )
vim.keymap.set( "v", "<leader>`", "<Esc>`>a`<Esc>`<i`<Esc>w", { desc = "Surround with `" } )
vim.keymap.set( "v", "<leader>{", "<Esc>`>a}<Esc>`<i{<Esc>w", { desc = "Surround with {}" } )
vim.keymap.set( "v", "<leader>(", "<Esc>`>a)<Esc>`<i(<Esc>w", { desc = "Surround with ()" } )
vim.keymap.set( "v", "<leader>[", "<Esc>`>a]<Esc>`<i[<Esc>w", { desc = "Surround with []" } )
vim.keymap.set( "v", "<leader><", "<Esc>`>a><Esc>`<i<<Esc>w", { desc = "Surround with <>" } )
vim.keymap.set( "v", "<leader><BS>", "<Esc>`>x`<x" )
vim.keymap.set( "n", "<leader><BS>", "\"_v%<Esc>`>x`<x" )
vim.keymap.set( "i", "<A-W>", remap( "fast_continuous_wrap" ), { silent = true } )
vim.keymap.set( "i", "<A-w>", remap( "fast_word_wrap" ), { silent = true } )

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
    local filetype = vim.api.nvim_get_option_value( "filetype", { buf = buf } )

    if filetype == "qf" then
      vim.api.nvim_win_close( id, false )
      return
    end
  end

  local flash = prequire( "flash.plugins.char" )

  if flash and flash.state and flash.state.visible then
    flash.state:hide()
  end
end, { silent = true } )

vim.keymap.set( "n", "<leader>r", ":lua require('obszczymucha.remap').reload()<CR>",
  { silent = true, desc = "Reload keymaps" } )
vim.keymap.set( "n", "<A-r>", remap( "reload" ), { silent = true } )
vim.keymap.set( "n", "<A-S-r>", ":LspRestart<CR> | :lua vim.notify( \"LSP restarted.\" )<CR>", { silent = true } )

-- Custom persistable settings
vim.keymap.set( "n", "<leader>cq", config.toggle_auto_center, { desc = "Toggle auto-center" } )
vim.keymap.set( "n", "<leader>ca", config.toggle_alpha_nrformats, { desc = "Toggle alpha nrformats" } )

-- Custom search
-- Currently disabled, because noice gives much better search capability.
-- The only problem that needs to be fixed is the E486 when searching for
-- a non-existing phrase.
--vim.keymap.set( 'n', '/', [[<cmd>lua require( "obszczymucha.custom-search" ).forward()<CR>]] )
--vim.keymap.set( 'n', '?', [[<cmd>lua require( "obszczymucha.custom-search" ).backward()<CR>]] )

function M.define_a_mark()
  local mark = vim.fn.getchar()
  ---@diagnostic disable-next-line: cast-local-type
  if type( mark ) == "number" then mark = string.char( mark ) end

  vim.cmd( "normal! m" .. mark )
  vim.notify( string.format( "Mark %s defined.", mark ) )
end

vim.keymap.set( "n", "'", ":lua require('obszczymucha.navigation').jump_to_mark_and_center()<CR>", { silent = true } )
vim.keymap.set( "n", "m", ":lua require('obszczymucha.remap').define_a_mark()<CR>", { silent = true } )

-- Snippets
-- Strangely, vim.keymap.set causes some strange characters being shown with this.
vim.api.nvim_set_keymap( "i", "<Tab>", [[luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : "<Tab>"]],
  { expr = true, noremap = true } )
vim.api.nvim_set_keymap( "s", "<Tab>", [[luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : "<Tab>"]],
  { expr = true, noremap = true } )
vim.api.nvim_set_keymap( "i", "<S-Tab>", "<cmd>lua require('luasnip').jump(1)<CR>", { expr = true, noremap = true } )
vim.api.nvim_set_keymap( "s", "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<CR>", { expr = true, noremap = true } )

-- Other
vim.keymap.set( "n", "<S-t>", ":Inspect<CR>", { silent = true, desc = "Inspect Treesitter element" } )
vim.keymap.set( "n", "<leader>M", ":Mason<CR>", { silent = true, desc = "Open Mason" } )
vim.keymap.set( "n", "<leader>L", ":Lazy<CR>", { silent = true, desc = "Open Lazy" } )
vim.keymap.set( "n", "<leader>m", ":MarkdownPreviewToggle<CR>", { silent = true, desc = "Toggle markdown preview" } )
vim.keymap.set( "n", "<A-w>", ":WhichKey<CR>", { silent = true, desc = "Show keymaps" } )
vim.keymap.set( "n", "<leader>h", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
  { silent = true, desc = "Toggle inlay hints" } )
vim.keymap.set( "n", "<C-q>", ":copen<CR>", { noremap = true, silent = true, desc = "Open quickfix" } )
vim.keymap.set( "n", "<leader>fm", ":messages<CR>", { noremap = true, silent = true, desc = "Open messages" } )

vim.keymap.set( "n", "<A-'>", ":vs<CR>",
  { noremap = true, silent = true, desc = "Split vertically" } )
vim.keymap.set( "n", "<A-\">", ":bel sp<CR>",
  { noremap = true, silent = true, desc = "Split horizontally" } )

function M.reload()
  R( "obszczymucha.remap" )
  vim.notify( "Mappings reloaded." )
end

-- vim.keymap.set( "n", "<F1>", ":lua print('Princess Kenny')<CR>", { noremap = true, silent = true } )
vim.keymap.set( "n", "<F1>", ":redraw<CR>", { noremap = true, silent = true } )

-- Command mode mappings
vim.keymap.set( "c", "<A-b>", "<S-Left>", { noremap = true } )
vim.keymap.set( "c", "<A-w>", "<S-Right>", { noremap = true } )
vim.keymap.set( "c", "<A-h>", "<Left>", { noremap = true } )
vim.keymap.set( "c", "<A-l>", "<Right>", { noremap = true } )
vim.keymap.set( "c", "<A-4>", "<End>", { noremap = true } )
vim.keymap.set( "c", "<A-0>", "<Home>", { noremap = true } )

return M
