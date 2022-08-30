local o = vim.opt
local g = vim.g
local api = vim.api
local cmd = vim.cmd
local inoremap = require( "obszczymucha.keymap" ).inoremap
local nnoremap = require( "obszczymucha.keymap" ).nnoremap
local vnoremap = require( "obszczymucha.keymap" ).vnoremap
local imap = require( "obszczymucha.keymap" ).imap
local vmap = require( "obszczymucha.keymap" ).vmap
local nmap = require( "obszczymucha.keymap" ).nmap
local xmap = require( "obszczymucha.keymap" ).xmap
local omap = require( "obszczymucha.keymap" ).omap

-- If hidden is not set, TextEdit might fail.
o.hidden = false

-- Some servers have issues with backup files
o.backup = false
o.writebackup = true

-- You will have a bad experience with diagnostic messages with the default of 4000.
o.updatetime = 300

-- Don't give |ins-completion-menu| messages.
o.shortmess:append( 'c' )

-- Always show signcolumns
o.signcolumn = 'yes'

-- Use tab for trigger completion with characters ahead and navigate.
-- Use command ':verbose imap <tab>' to make sure tab is not mapped by another plugin.
inoremap( "<TAB>", [[coc#pum#visible() ? coc#pum#next(1) : coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request( 'doKeymap', [ 'snippets-expand-jump', '' ])\<CR>" : CheckBackspace() ? "\<Tab>" : coc#refresh()]], { silent = true, expr = true } )
inoremap( "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { expr = true } )

-- snippets
-- Use <C-l> for trrigger snippet expand.
imap( "<C-l>", "<Plug>(coc-snippets-expand)" )

-- Use <C-j> for select text for visual placeholder of snippet.
vmap( "<C-j>", "<Plug>(coc-snippets-select)" )

-- Use <C-j> for jump to next placeholder, it's default of coc.nvim
g.coc_snippet_next = "<c-j>"

-- Use <C-k> for jump to previous placeholder, it's default of coc.nvim
g.coc_snippet_prev = "<c-k>"

-- Use <C-j> for both expand and jump (make expand higher priority).
imap( "<C-j>", "<Plug>(coc-snippets-expand-jump)" )

-- Use <leader>x for convert visual selected code to snippet
xmap( "<leader>x", "<Plug>(coc-convert-snippet)" )

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
inoremap( "<CR>", [[coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { silent = true, expr = true } )

api.nvim_exec( [[
function! CheckBackspace() abort
  let col = col( '.' ) - 1
  return !col || getline( '.' )[ col - 1 ]  =~# '\s'
endfunction
]], false )

g.coc_snippet_next = "<tab>"

-- Use <c-space> to trigger completion.
inoremap( "<c-space>", [[coc#refresh()]], { silent = true, expr = true } )

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap( "[g", [[<Plug>(coc-diagnostic-prev)]], { silent = true } )
nmap( "]g", [[<Plug>(coc-diagnostic-next)]], { silent = true } )

-- GoTo code navigation.
nmap( "gd", [[<Plug>(coc-definition)]], { silent = true } )
nmap( "gy", [[<Plug>(coc-type-definition)]], { silent = true } )
nmap( "gi", [[<Plug>(coc-implementation)]], { silent = true } )
nmap( "gr", [[<Plug>(coc-references)]], { silent = true } )

-- Use K to show documentation in preview window.
nnoremap( "K", "<cmd>call ShowDocumentation()<CR>", { silent = true } )

api.nvim_exec( [[
function! ShowDocumentation()
  if CocAction( 'hasProvider', 'hover' )
    call CocActionAsync( 'doHover' )
  else
    call feedkeys( 'K', 'in' )
  endif
endfunction
]], false )

-- Highlight the symbol and its references when holding the cursor.
cmd( "autocmd CursorHold * silent call CocActionAsync( 'highlight' )" )

-- Symbol renaming.
nmap( "<leader>rn", [[<Plug>(coc-rename)]] )

-- Formatting selected code.
xmap( "<leader>f", [[<Plug>(coc-format-selected)]] )
nmap( "<leader>f", [[<Plug>(coc-format-selected)]] )

-- Add `:Format` command to format current buffer.
cmd( [[command! -nargs=0 Format :call CocActionAsync('format')]] )

-- Formatting the entire file.
nnoremap( "<leader>F", "<cmd>Format<CR>", { silent = true } )

cmd( [[
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
]], false )

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
xmap( "<leader>a", [[<Plug>(coc-codeaction-selected)]] )
nmap( "<leader>a", [[<Plug>(coc-codeaction-selected)]] )

-- Remap keys for a pplying codeAction to the current buffer.
nmap( "<leader>ac", [[<Plug>(coc-codeaction)]] )
-- Apply AutoFix to problem on the current line.
nmap( "<leader>qf", [[<Plug>(coc-fix-current)]] )

-- Run the Code Lens action on the current line.
nmap( "<leader>cl", [[<Plug>(coc-codelens-action)]] )

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap( "if", [[<Plug>(coc-funcobj-i)]] )
omap( "if", [[<Plug>(coc-funcobj-i)]] )
xmap( "af", [[<Plug>(coc-funcobj-a)]] )
omap( "af", [[<Plug>(coc-funcobj-a)]] )
xmap( "ic", [[<Plug>(coc-classobj-i)]] )
omap( "ic", [[<Plug>(coc-classobj-i)]] )
xmap( "ac", [[<Plug>(coc-classobj-a)]] )
omap( "ac", [[<Plug>(coc-classobj-a)]] )

-- Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap( "<C-f>", [[coc#float#has_scroll() ? coc#float#scroll( 1 ) : "\<C-f>"]], { silent = true, nowait = true, expr = true } )
nnoremap( "<C-b>", [[coc#float#has_scroll() ? coc#float#scroll( 0 ) : "\<C-b>"]], { silent = true, nowait = true, expr = true } )
inoremap( "<C-f>", [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll( 1 )\<cr>" : "\<Right>"]], { silent = true, nowait = true, expr = true } )
inoremap( "<C-b>", [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll( 0 )\<cr>" : "\<Left>"]], { silent = true, nowait = true, expr = true } )
vnoremap( "<C-f>", [[coc#float#has_scroll() ? coc#float#scroll( 1 ) : "\<C-f>"]], { silent = true, nowait = true, expr = true } )
vnoremap( "<C-b>", [[coc#float#has_scroll() ? coc#float#scroll( 0 ) : "\<C-b>"]], { silent = true, nowait = true, expr = true } )

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
nmap( "<C-s>", [[<Plug>(coc-range-select)]], { silent = true } )
xmap( "<C-s>", [[<Plug>(coc-range-select)]], { silent = true } )

-- Add `:Fold` command to fold current buffer.
cmd( [[command! -nargs=? Fold :call CocAction( 'fold', <f-args> )]] )

-- Add `:OR` command for organize imports of the current buffer.
cmd( [[command! -nargs=0 OR :call CocActionAsync( 'runCommand', 'editor.action.organizeImport' )]] )

-- Add shortcut to organize imports.
nnoremap( "<leader>O", "<cmd>OR<CR>", { silent = true } )

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
--cmd([[set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}]] )

-- Mappings for CoCList
-- Show all diagnostics.
nnoremap( "<space>a", [[:<C-u>CocList diagnostics<cr>]], { silent = true, nowait = true } )
-- Manage extensions.
nnoremap( "<space>e", [[:<C-u>CocList extensions<cr>]], { silent = true, nowait = true } )
-- Show commands.
nnoremap( "<space>c", [[:<C-u>CocList commands<cr>]], { silent = true, nowait = true } )
-- Find symbol of current document.
nnoremap( "<space>o", [[:<C-u>CocList outline<cr>]], { silent = true, nowait = true } )
-- Search workspace symbols.
nnoremap( "<space>s", [[:<C-u>CocList -I symbols<cr>]], { silent = true, nowait = true } )
-- Do default action for next item.
nnoremap( "<space>j", [[:<C-u>CocNext<cr>]], { silent = true, nowait = true } )
-- Do default action for previous item.
nnoremap( "<space>k", [[:<C-u>CocPrev<cr>]], { silent = true, nowait = true } )
-- Resume latest coc list.
nnoremap( "<space>p", [[:<C-u>CocListResume<cr>]], { silent = true, nowait = true } )

g.coc_global_extensions = {
  "coc-marketplace",
  "coc-tsserver",
  "coc-snippets",
  "coc-pairs",
  "coc-json",
  "coc-eslint",
  "coc-css",
  "coc-clangd"
}

