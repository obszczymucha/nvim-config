local lsp_status = require( "lsp-status" )
lsp_status.config( {
  status_symbol = "",
  indicator_ok = ""
} )

lsp_status.register_progress()

require 'lspconfig'.hls.setup( {
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
} )
