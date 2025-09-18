local utils = require( "obszczymucha.utils" )
local mason = prequirev( "mason" )
if mason then
  mason.setup()
end

local neoconf = prequirev( "neoconf" )
if neoconf then neoconf.setup {} end

local mason_lspconfig = prequirev( "mason-lspconfig" )
if mason_lspconfig then
  mason_lspconfig.setup {
    automatic_enable = {
      exclude = {
        "rust_analyzer"
      }
    },
    ensure_installed = {
      "clangd",
      "rust_analyzer",
      "pyright",
      "ruff",
      "ts_ls",
      "bashls",
      "sqlls",
      "cssls",
      "html",
      "jdtls",
      "jsonls",
      "gopls"
    },
    -- Disable automatic setup to prevent duplicates
    automatic_setup = false,
  }
end

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

local original_handler = vim.lsp.handlers[ "textDocument/publishDiagnostics" ]

vim.lsp.handlers[ "textDocument/publishDiagnostics" ] = function( err, params, ctx, config )
  local client = ctx and vim.lsp.get_client_by_id( ctx.client_id )

  if client and client.name == "gopls" then
    local root_dir = "file://" .. utils.get_project_root_dir()

    if not vim.startswith( params.uri, root_dir ) then
      params.diagnostics = {}
      original_handler( err, params, ctx, config )
    end
  end

  filter( params.diagnostics, filter_diagnostics )
  original_handler( err, params, ctx, config )
end
