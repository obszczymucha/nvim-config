local osv = prequirev( "osv" )
if not osv then return end

local dap = prequirev( "dap" )
if not dap then return end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to a running Neovim instance"
  }
}

dap.adapters.nlua = function( callback, config )
  callback( { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 } )
end

vim.keymap.set( "n", "<leader>dL", [[:lua require'osv'.launch({port = 8086})<CR>]], { silent = true, desc = "Start LUA debug server" } )
