-- Workaround: OLS doesn't show diagnostics on file open, only after save.
-- https://github.com/DanielGavin/ols/issues/1206
vim.api.nvim_create_autocmd( "LspAttach", {
  group = vim.api.nvim_create_augroup( "OdinLspAttach", { clear = true } ),
  buffer = 0,
  callback = function( args )
    local client = vim.lsp.get_client_by_id( args.data.client_id )
    if client and client.name == "ols" then
      vim.lsp.buf_notify( args.buf, "textDocument/didSave", {
        textDocument = { uri = vim.uri_from_bufnr( args.buf ) },
      } )
    end
  end,
} )
