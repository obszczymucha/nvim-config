require( "obszczymucha.globals" )

local M = {}
local config = require( "obszczymucha.user-config" )
local map = vim.keymap.set

-- Git
map( "n", "gl", "<cmd>GitMessenger<CR>", { silent = true, desc = "Git blame" } )

-- Notifications
if is_wsl then
  map( "n", "<F38>", "<cmd>lua require('notify').dismiss()<CR>", { desc = "Dismiss notification" } )
elseif is_macos then
  map( "n", "<F37>", "<cmd>lua require('notify').dismiss()<CR>", { desc = "Dismiss notification" } )
else
  map( "n", "<A-Esc>", "<cmd>lua require('notify').dismiss()<CR>", { desc = "Dismiss notification" } )
end

local function remap( name )
  return string.format( string.format( "<cmd>lua R( 'obszczymucha.remap' ).bind( '%s' )<CR>", name ) )
end

-- Debug
map( "n", "<leader>dv", "<cmd>lua require( 'obszczymucha.debug' ).toggle()<CR>",
  { desc = "Toggle test debug" } )
map( "n", "<leader>dV", "<cmd>lua require( 'obszczymucha.debug' ).toggle_horizontal()<CR>",
  { desc = "Toggle test debug (horizontal)" } )
map( "n", "<leader>dq", remap( "show_test_results" ), { noremap = true, desc = "Show test results (popup)" } )
map( "n", "<leader>ds", "<cmd>lua require( 'obszczymucha.debug' ).flip()<CR>", { desc = "Flip test debug" } )
map( "n", "<leader>dc", "<cmd>lua require( 'obszczymucha.debug' ).clear()<CR>", { desc = "Clear test debug" } )
map( "n", "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<CR>",
  { desc = "Debug hover", silent = true } )

-- File management
map( "n", "<leader>gf", "<cmd>e <cfile><CR>", { desc = "Create a file under cursor" } )

-- Window management
-- map( "n", "<A-v>", "<C-w>v<C-w>w" )
-- map( "n", "<A-s>", "<C-w>s<C-w>w" )
map( "n", "<S-A-j>", "<C-w>j" )
map( "n", "<S-A-k>", "<C-w>k" )

if is_macos then
  map( "n", "<S-Left>", "<C-w>h" )
  map( "n", "<S-Right>", "<C-w>l" )
  map( "n", "<S-Down>", "<C-w>j" )
  map( "n", "<S-Up>", "<C-w>k" )
else
  map( "n", "<S-A-h>", "<C-w>h" )
  map( "n", "<S-A-l>", "<C-w>l" )
end

map( "n", "<M-C-h>", "<C-w>10<" )
map( "n", "<M-C-l>", "<C-w>10>" )
map( "n", "<M-C-u>", "<C-w>5-" )
map( "n", "<M-C-d>", "<C-w>5+" )

-- Quit
map( "n", "<A-q>", "<cmd>q<CR>", { desc = "Exit" } )

-- Moving lines
if is_wsl then
  -- Alacritty doesn't want to send Ctrl+Alt, so the only way is to use AHK.
  -- AHK is sending ^[[1;5R for <C-A-j> and ^[[1;5S for <C-A-k>.
  -- These map to <C-F3> (F27) and <C-F4> (F28) respectively.
  map( "n", "<F27>", "<cmd>m .+1<CR>==" )
  map( "n", "<F28>", "<cmd>m .-2<CR>==" )
  map( "i", "<F27>", "<Esc><cmd>m .+1<CR>==gi" )
  map( "i", "<F28>", "<Esc><cmd>m .-2<CR>==gi" )
  map( "v", "<F27>", ":m '>+1<CR>gv=gv" )
  map( "v", "<F28>", ":m '<-2<CR>gv=gv" )
elseif is_windows then
  map( "n", "<C-F3>", "<cmd>m .+1<CR>==" )
  map( "n", "<C-F4>", "<cmd>m .-2<CR>==" )
  map( "i", "<C-F3>", "<Esc><cmd>m .+1<CR>==gi" )
  map( "i", "<C-F4>", "<Esc><cmd>m .-2<CR>==gi" )
  map( "v", "<C-F3>", ":m '>+1<CR>gv=gv" )
  map( "v", "<C-F4>", ":m '<-2<CR>gv=gv" )
else
  map( "n", "<C-A-j>", "<cmd>m .+1<CR>==" )
  map( "n", "<C-A-k>", "<cmd>m .-2<CR>==" )
  map( "i", "<C-A-j>", "<Esc><cmd>m .+1<CR>==gi" )
  map( "i", "<C-A-k>", "<Esc><cmd>m .-2<CR>==gi" )
  map( "v", "<C-A-j>", ":m '>+1<CR>gv=gv" )
  map( "v", "<C-A-k>", ":m '<-2<CR>gv=gv" )
end

-- Copy / paste
map( "x", "<leader>p", "\"_dP" )
map( "n", "<leader>y", "\"+y" )

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

  map( "v", "<leader>y", copy, { silent = true } )
else
  map( "v", "<leader>y", "\"+y" )
end

if is_wsl or is_macos then
  map( "n", "<A-p>", ":lua vim.api.nvim_put(vim.fn.systemlist('pbpaste'), '', true, true)<CR>",
    { noremap = true, silent = true } )
  map( "n", "<A-P>", ":lua vim.api.nvim_put(vim.fn.systemlist('pbpaste'), '', false, true)<CR>",
    { noremap = true, silent = true } )
else
  map( "n", "<A-p>", "\"+p" )
  map( "v", "<A-p>", "\"+p" )
  map( "n", "<A-S-p>", "\"+P" )
  map( "v", "<A-S-p>", "\"+P" )
  map( "v", "<A-C-p>", ':<c-u>\'<,\'>s/\\r/\\r/g<cr>' )
end

map( "n", "<leader>d", "\"_d" )
map( "v", "<leader>d", "\"_d" )
map( "n", "<leader>c", "\"_c" )
map( "n", "<leader>x", "\"_x" )

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
map( 'n', 'k', "<cmd>lua R( 'obszczymucha.navigation' ).jump_count( 'k' )<CR>" )
map( 'n', 'j', "<cmd>lua R( 'obszczymucha.navigation' ).jump_count( 'j' )<CR>" )
map( "n", "<A-j>", "<C-y>", { noremap = true } )
map( "n", "<A-k>", "<C-e>", { noremap = true } )
map( "n", "<C-e>", "<C-e>j", { noremap = true } )
map( "n", "<C-y>", "<C-y>k", { noremap = true } )
-- map( "n", "<A-d>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_smart_down()<CR>" )
-- map( "n", "<A-u>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_smart_up()<CR>" )
map( "n", "<A-d>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_down2()<CR>" )
map( "n", "<A-u>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_up2()<CR>" )
map( "n", "<C-d>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_down()<CR>" )
map( "n", "<C-u>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_up()<CR>" )
map( "n", "<C-f>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_page_down()<CR>" )
map( "n", "<C-b>", "<cmd>lua R( 'obszczymucha.navigation' ).smoothie_page_up()<CR>" )
map( "n", "G", [[:call smoothie#do( "G" )<CR>]], { silent = true } )
map( "n", "gg", [[:call smoothie#do( "gg" )<CR>]], { silent = true } )
map( "n", "zz", [[:call smoothie#do( "zz" )<CR>]], { silent = true } )
map( "n", "zt", [[:call smoothie#do( "zt" )<CR>]], { silent = true } )
map( "n", "zb", [[:call smoothie#do( "zb" )<CR>]], { silent = true } )
map( "n", "zk", ":lua R( 'obszczymucha.navigation' ).readable_pos('k')<CR>",
  { silent = true, noremap = true, desc = "Cycle readable position up" } )
map( "n", "zj", ":lua R( 'obszczymucha.navigation' ).readable_pos('j')<CR>",
  { silent = true, noremap = true, desc = "Cycle readable position down" } )
map( "n", "M", [[:call smoothie#do( "M" )<CR>]], { silent = true } )
map( "n", "H", [[:call smoothie#do( "H" )<CR>]], { silent = true } )
map( "n", "L", [[:call smoothie#do( "L" )<CR>]], { silent = true } )
map( "n", "n",
  "<cmd>lua R( 'obszczymucha.navigation' ).smart_search_result( \"call smoothie#do( 'n%s' )\" )<CR>", { silent = true } )
map( "n", "N",
  "<cmd>lua R( 'obszczymucha.navigation' ).smart_search_result( \"call smoothie#do( 'N%s' )\" )<CR>", { silent = true } )
map( "n", "<C-o>", function() return config.auto_center() and "<C-o>zz" or "<C-o>" end, { expr = true } )
map( "n", "<C-i>", function() return config.auto_center() and "<C-i>zz" or "<C-i>" end, { expr = true } )
map( "n", "gk", ":lua R( 'obszczymucha.navigation' ).go_to_context()<CR>",
  { silent = true, desc = "Go to Treesitter context" } )

map( "i", "<A-0>", "<C-o>0" )
map( "i", "<A-4>", "<C-o>$" )
map( "i", "<A-6>", "<C-o>^" )

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

local function send( keys )
  return function()
    vim.api.nvim_feedkeys( vim.api.nvim_replace_termcodes( keys, true, false, true ), "n", false )
  end
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

map( "i", "<A-j>", completion_down, { silent = true } )
map( "i", "<A-k>", completion_up, { silent = true } )
map( "i", "<C-k>", remap( "signature_help" ), { silent = true } )
map( "c", "<A-j>", send( "<Down>" ), { silent = true } )
map( "c", "<A-k>", send( "<Up>" ), { silent = true } )
map( "c", "<S-A-j>", completion_down, { silent = true } )
map( "c", "<S-A-k>", completion_up, { silent = true } )
map( "c", "<A-y>", yank( '"' ), { silent = true } )
map( "c", "<A-Y>", yank( '+' ), { silent = true } )

-- Filetype-based mappings. See obszczymucha/kemaps
map( "n", "gd", remap( "go_to_definition" ), { noremap = false, silent = true } )
map( "n", "gs", remap( "go_to_declaration" ), { noremap = false, silent = true } )
map( "n", "gt", remap( "type_definition" ), { noremap = false, silent = true } )
map( "n", "gi", remap( "go_to_implementation" ), { noremap = false, silent = true } )
map( "n", "<C-k>", remap( "signature_help" ), { noremap = false, silent = true } )
map( "n", "gj", remap( "peek_definition" ), { noremap = false, silent = true } )
map( "n", "gr", remap( "references" ), { noremap = false, silent = true } )
map( "n", "<C-K>", remap( "documentation" ), { noremap = false, silent = true } )
map( "n", "<C-j>", vim.diagnostic.open_float, { noremap = false, silent = true } )
map( "n", "<leader>rn", remap( "rename" ), { noremap = false, silent = true, desc = "Rename under cursor" } )
map( "n", "<leader>F", remap( "format_file" ),
  { noremap = false, silent = true, nowait = true, desc = "Format file" } )
map( "n", "]g", remap( "next_diagnostic" ), { noremap = false, silent = true } )
map( "n", "[g", remap( "prev_diagnostic" ), { noremap = false, silent = true } )
map( "n", "<leader>o", remap( "outline" ), { noremap = false, silent = true, nowait = true, desc = "Outline" } )
map( "n", "<leader>ac", remap( "code_action" ), { noremap = false, silent = true, desc = "Code action" } )
map( "n", "<leader>cl", remap( "code_lens" ), { noremap = false, silent = true, desc = "Code lens" } )
map( "n", "<leader>tf", remap( "test_file" ), { noremap = false, silent = true, desc = "Test file" } )
map( "n", "<leader>tt", remap( "test_nearest_method" ),
  { noremap = false, silent = true, desc = "Test nearest method" } )
map( "n", "<leader>O", remap( "organize_imports" ),
  { noremap = false, silent = true, nowait = true, desc = "Organize imports" } )
map( "n", "<leader>fc", remap( "compile" ),
  { noremap = false, silent = true, nowait = true, desc = "Compile file" } )
map( "n", "<leader>j", ":%!jq --sort-keys<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Prettify JSON" } )
map( "v", "<leader>j", ":'<,'>%!jq<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Prettify JSON" } )
map( "n", "<leader>J", ":%!jq -c<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Minify JSON" } )
map( "v", "<leader>J", ":'<,'>%!jq -c<CR>",
  { noremap = false, silent = true, nowait = true, desc = "Minify JSON" } )

map( "n", "<leader>q", "<cmd> lua R( 'obszczymucha.sandbox' ).test()<CR>", { desc = "Run sandbox code" } )

-- Tab navigation
--map( "n", "<leader>T", "<cmd>tabe<CR>", { silent = true } )
--map( "n", "<C-h>", "<cmd>tabp<CR>", { silent = true } )
--map( "n", "<C-l>", "<cmd>tabn<CR>", { silent = true } )

-- Debugging
map( "n", "<leader>dt", [[:lua require"dapui".toggle()<CR>]], { silent = true, desc = "Toggle dapui" } )
map( "n", "<leader>dr", [[:lua require"dap".repl.toggle()<CR>]], { silent = true, desc = "Toggle dap repl" } )
map( "n", "<F7>", [[:lua require"dap".step_into()<CR>]], { silent = true, desc = "Step into" } )
map( "n", "<F8>", [[:lua require"dap".step_over()<CR>]], { silent = true, desc = "Step over" } )
-- <S-F8
map( "n", "<F20>", [[:lua require"dap".step_out()<CR>]], { silent = true, desc = "Step out" } )
map( "n", "<F9>", [[:lua require"dap".toggle_breakpoint()<CR>]], { silent = true, desc = "Toggle breakpoint" } )
-- <S-F9>
map( "n", "<F21>", [[:lua require"dap".toggle_breakpoint(vim.fn.input("Condition: "))<CR>]],
  { silent = true, desc = "Toggle conditional breakpoint" } )
map( "n", "<F10>", [[:lua require"dap".continue()<CR>]], { silent = true, desc = "Continue or attach" } )

local function terminate_dap_session()
  local dap = prequirev( "dap" )
  if not dap then return end

  vim.notify( "Terminating..." )
  dap.terminate()
  dap.repl.close()
end

-- <C-F10>
map( "n", "<F34>", terminate_dap_session, { silent = true, desc = "Terminate" } )

-- Surround mappings
map( "v", "<leader>\"", "<Esc>`>a\"<Esc>`<i\"<Esc>w", { desc = "Surround with \"" } )
map( "v", "<leader>'", "<Esc>`>a'<Esc>`<i'<Esc>w", { desc = "Surround with '" } )
map( "v", "<leader>`", "<Esc>`>a`<Esc>`<i`<Esc>w", { desc = "Surround with `" } )
map( "v", "<leader>{", "<Esc>`>a}<Esc>`<i{<Esc>w", { desc = "Surround with {}" } )
map( "v", "<leader>(", "<Esc>`>a)<Esc>`<i(<Esc>w", { desc = "Surround with ()" } )
map( "v", "<leader>[", "<Esc>`>a]<Esc>`<i[<Esc>w", { desc = "Surround with []" } )
map( "v", "<leader><", "<Esc>`>a><Esc>`<i<<Esc>w", { desc = "Surround with <>" } )
map( "v", "<leader><BS>", "<Esc>`>x`<x" )
map( "n", "<leader><BS>", "\"_v%<Esc>`>x`<x" )
map( "i", "<A-W>", remap( "fast_continuous_wrap" ), { silent = true } )
map( "i", "<A-w>", remap( "fast_word_wrap" ), { silent = true } )

-- This automatically closes the find references window when e is pressd. I've no idea how this works.
vim.api.nvim_create_autocmd( "FileType", {
  callback = function()
    local bufnr = vim.fn.bufnr( '%' )
    map( "n", "e", function()
      vim.api.nvim_command( [[execute "normal! \<cr>"]] )
      vim.api.nvim_command( bufnr .. 'bd' )
    end, { buffer = bufnr } )
  end,
  pattern = "qf",
} )

map( "n", "<Esc>", function()
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

map( "n", "<leader>r", ":lua require('obszczymucha.remap').reload()<CR>",
  { silent = true, desc = "Reload keymaps" } )
map( "n", "<A-r>", remap( "reload" ), { silent = true } )
map( "n", "<A-S-r>", ":LspRestart<CR> | :lua vim.notify( \"LSP restarted.\" )<CR>", { silent = true } )

-- Custom search
-- Currently disabled, because noice gives much better search capability.
-- The only problem that needs to be fixed is the E486 when searching for
-- a non-existing phrase.
--map( 'n', '/', [[<cmd>lua require( "obszczymucha.custom-search" ).forward()<CR>]] )
--map( 'n', '?', [[<cmd>lua require( "obszczymucha.custom-search" ).backward()<CR>]] )

function M.define_a_mark()
  local mark = vim.fn.getchar()
  ---@diagnostic disable-next-line: cast-local-type
  if type( mark ) == "number" then mark = string.char( mark ) end

  vim.cmd( "normal! m" .. mark )
  vim.notify( string.format( "Mark %s defined.", mark ) )
end

map( "n", "'", ":lua require('obszczymucha.navigation').jump_to_mark_and_center()<CR>", { silent = true } )
map( "n", "m", ":lua require('obszczymucha.remap').define_a_mark()<CR>", { silent = true } )

-- Snippets
-- Strangely, map causes some strange characters being shown with this.
vim.api.nvim_set_keymap( "i", "<Tab>", [[luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : "<Tab>"]],
  { expr = true, noremap = true } )
vim.api.nvim_set_keymap( "s", "<Tab>", [[luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : "<Tab>"]],
  { expr = true, noremap = true } )
vim.api.nvim_set_keymap( "i", "<S-Tab>", "<cmd>lua require('luasnip').jump(1)<CR>", { expr = true, noremap = true } )
vim.api.nvim_set_keymap( "s", "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<CR>", { expr = true, noremap = true } )

-- Other
map( "n", "<A-t>", ":Inspect<CR>", { silent = true, desc = "Inspect Treesitter element" } )
map( "n", "<leader>M", ":Mason<CR>", { silent = true, desc = "Open Mason" } )
map( "n", "<leader>L", ":Lazy<CR>", { silent = true, desc = "Open Lazy" } )
map( "n", "<leader>m", ":MarkdownPreviewToggle<CR>", { silent = true, desc = "Toggle markdown preview" } )
map( "n", "<A-w>", ":WhichKey<CR>", { silent = true, desc = "Show keymaps" } )
map( "n", "<leader>h", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
  { silent = true, desc = "Toggle inlay hints" } )
map( "n", "<C-q>", ":copen<CR>", { noremap = true, silent = true, desc = "Open quickfix" } )
map( "n", "<leader>fm", ":messages<CR>", { noremap = true, silent = true, desc = "Open messages" } )

map( "n", "<A-'>", ":vs<CR>",
  { noremap = true, silent = true, desc = "Split vertically" } )
map( "n", "<A-\">", ":bel sp<CR>",
  { noremap = true, silent = true, desc = "Split horizontally" } )

function M.reload()
  R( "obszczymucha.remap" )
  vim.notify( "Mappings reloaded." )
end

-- map( "n", "<F1>", ":lua print('Princess Kenny')<CR>", { noremap = true, silent = true } )
map( "n", "<F1>", ":redraw<CR>", { noremap = true, silent = true } )

-- Command mode mappings
map( "c", "<A-b>", "<S-Left>", { noremap = true } )
map( "c", "<A-w>", "<S-Right>", { noremap = true } )
map( "c", "<A-h>", "<Left>", { noremap = true } )
map( "c", "<A-l>", "<Right>", { noremap = true } )
map( "c", "<A-4>", "<End>", { noremap = true } )
map( "c", "<A-0>", "<Home>", { noremap = true } )

map( "n", "<A-e>", ":e<CR>", { noremap = true, silent = true } )
map( "n", "ciq", "ci\"", { noremap = true, silent = true } )
map( "n", "diq", "di\"", { noremap = true, silent = true } )
map( "n", "viq", "vi\"", { noremap = true, silent = true } )

map( "n", "zx", "zf%", { noremap = true, silent = true, desc = "Fold current context" } )

return M
