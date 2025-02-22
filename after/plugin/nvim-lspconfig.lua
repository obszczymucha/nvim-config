local mason = prequirev( "mason" )
if mason then
  mason.setup()
end

local mason_lspconfig = prequirev( "mason-lspconfig" )
if mason_lspconfig then
  mason_lspconfig.setup {
    ensure_installed = {
      "clangd",
      "rust_analyzer",
      "pyright",
      "ruff",
      "ts_ls",
      "lua_ls",
      "bashls",
      "sqlls",
      "cssls",
      "html",
      "jdtls",
      "jsonls",
      "gopls"
    }
  }
end

local lspconfig = prequirev( "lspconfig" )
if not lspconfig then return end

local neoconf = prequirev( "neoconf" )
if neoconf then neoconf.setup {} end

if lspconfig.hls then lspconfig.hls.setup {} end

if lspconfig.lua_ls then
  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        },
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
end


if lspconfig.bashls then
  lspconfig.bashls.setup {
    cmd_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.zshrc)" },
    filetypes = { "sh", "zsh" }
  }
end

if lspconfig.ts_ls then
  lspconfig.ts_ls.setup {
    on_attach = function( client, bufnr )
      require( "twoslash-queries" ).attach( client, bufnr )
    end
  }
end

if lspconfig.pyright then lspconfig.pyright.setup {} end
if lspconfig.ruff then lspconfig.ruff.setup {} end

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

-- TODO: Can we constraint this to python only?
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

local function custom_on_publish_diagnostics( a, params, client_id, c )
  filter( params.diagnostics, filter_diagnostics )
  vim.lsp.diagnostic.on_publish_diagnostics( a, params, client_id, c )
end

vim.lsp.handlers[ "textDocument/publishDiagnostics" ] = vim.lsp.with( custom_on_publish_diagnostics, {} )

if lspconfig.clangd then lspconfig.clangd.setup {} end
if lspconfig.sqlls then lspconfig.sqlls.setup {} end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if lspconfig.cssls then lspconfig.cssls.setup { capabilities = capabilities } end
if lspconfig.html then lspconfig.html.setup { capabilities = capabilities } end
if lspconfig.jsonls then lspconfig.jsonls.setup { capabilities = capabilities } end
if lspconfig.gopls then lspconfig.gopls.setup {} end
--local root_pattern = require( "lspconfig.util" ).root_pattern

--if lspconfig.groovyls then
--lspconfig.groovyls.setup {
--capabilities = capabilities,
--root_dir = root_pattern( "", ".git" )
--}
--end
