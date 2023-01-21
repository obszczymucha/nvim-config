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
  on_attach = function()
    -- Documentation
    vim.keymap.set( "i", "<C-h>", "<Esc>l<cmd>lua R( 'obszczymucha.documentation' ).show_function_help()<CR>" )
    vim.keymap.set( "n", "<C-h>", "<cmd>lua R( 'obszczymucha.documentation' ).show_function_help()<CR>" )
  end
}

require 'lspconfig'.bashls.setup {
  cmd_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.zshrc)" },
  filetypes = { "sh", "zsh" }
}

require 'lspconfig'.tsserver.setup {}
require 'lspconfig'.pyright.setup {}

local function filter( arr, func )
  -- Filter in place
  -- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
  local new_index = 1
  local size_orig = #arr
  for old_index, v in ipairs( arr ) do
    if func( v, old_index ) then
      arr[ new_index ] = v
      new_index = new_index + 1
    end
  end
  for i = new_index, size_orig do arr[ i ] = nil end
end

local function filter_diagnostics( diagnostic )
  -- Only filter out Pyright stuff for now
  if diagnostic.source ~= "Pyright" then
    return true
  end

  -- pyspock's given method
  if diagnostic.message == '"given" is not accessed' then
    return false
  end

  -- pyspock's expect method
  if diagnostic.message == '"expect" is not accessed' then
    return false
  end

  -- pyspock's where method
  if diagnostic.message == '"where" is not accessed' then
    return false
  end

  -- Allow variables starting with an underscore
  if string.match( diagnostic.message, '"_.+" is not accessed' ) then
    return false
  end

  return true
end

local function custom_on_publish_diagnostics( a, params, client_id, c, config )
  filter( params.diagnostics, filter_diagnostics )
  vim.lsp.diagnostic.on_publish_diagnostics( a, params, client_id, c, config )
end

vim.lsp.handlers[ "textDocument/publishDiagnostics" ] = vim.lsp.with( custom_on_publish_diagnostics, {} )

require 'lspconfig'.rust_analyzer.setup {}
