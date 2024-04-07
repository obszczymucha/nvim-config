local mason = prequire( "mason" )
if mason then
  mason.setup()
end

local mason_lspconfig = prequire( "mason-lspconfig" )
if mason_lspconfig then
  mason_lspconfig.setup {
    ensure_installed = { "clangd", "rust_analyzer", "pyright", "ruff_lsp", "tsserver", "lua_ls", "bashls", "sqlls", "cssls", "html", "jdtls", "jsonls" }
  }
end

local lsp_status = prequire( "lsp-status" )
if lsp_status then
  lsp_status.config( {
    status_symbol = "",
    indicator_ok = ""
  } )

  lsp_status.register_progress()
end


local lspconfig = prequire( "lspconfig" )
if not lspconfig then return end

lspconfig.hls.setup {}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false
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

lspconfig.bashls.setup {
  cmd_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.zshrc)" },
  filetypes = { "sh", "zsh" }
}

lspconfig.tsserver.setup {
  on_attach = function( client, bufnr )
    require( "twoslash-queries" ).attach( client, bufnr )
  end
}

lspconfig.pyright.setup {}
lspconfig.ruff_lsp.setup {}

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

lspconfig.rust_analyzer.setup {}
lspconfig.clangd.setup {}
lspconfig.sqlls.setup {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

require 'lspconfig'.html.setup {
  capabilities = capabilities,
}

require 'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}
