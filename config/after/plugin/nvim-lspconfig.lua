local lsp_status = require( "lsp-status" )
lsp_status.config( {
  status_symbol = "",
  indicator_ok = ""
} )

lsp_status.register_progress()

require 'lspconfig'.hls.setup {}

require 'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file( "", true ),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require 'lspconfig'.bashls.setup {
  cmd_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.zshrc)" },
  filetypes = { "sh", "zsh" }
}

require 'lspconfig'.tsserver.setup {}

require 'lspconfig'.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 140
        }
      }
    }
  }
}
