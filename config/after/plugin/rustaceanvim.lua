local neoconf = prequirev( "neoconf" )
local config = neoconf and neoconf.get( "lspconfig" )

if neoconf and config then
  vim.g.rustaceanvim = {
    server = {
      default_settings = config.rust_analyzer
    },
    dap = {
      configurations = {
        rust = {
          name = "Chuj",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input( 'Path to executable: ', vim.fn.getcwd() .. '/target/x86_64-pc-windows-gnu/debug/',
              'file' )
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          runInTerminal = false
        }
      }
    }
  }
end
