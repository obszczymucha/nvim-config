return {
  on_attach = function( _, bufnr )
    vim.keymap.set( "i", "<C-h>", "<Esc>l<cmd>lua R( 'obszczymucha.documentation' ).show_function_help()<CR>",
      { buffer = bufnr } )
    vim.keymap.set( "n", "<C-h>", "<cmd>lua R( 'obszczymucha.documentation' ).show_function_help()<CR>",
      { buffer = bufnr } )
  end
}
