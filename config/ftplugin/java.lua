local jdtls = prequire( "jdtls" )
if not jdtls then return end

local home = os.getenv( "HOME" )
local mason_dir = home .. "/.local/share/nvim/mason/packages/"
local project_name = vim.fn.fnamemodify( vim.fn.getcwd(), ":p:h:t" )
local workspace_dir = home .. "/.jdtls/" .. project_name
local debug_plugin_dir = mason_dir .. "java-debug-adapter/extension"
local test_extension_dir = mason_dir .. "java-test/extension"
local java_debug_plugin = debug_plugin_dir .. "/server/com.microsoft.java.debug.plugin-*.jar"
local vscode_java_test_extension = test_extension_dir .. "/server/*jar"

local bundles = {
  vim.fn.glob( java_debug_plugin, 1 )
}

vim.list_extend( bundles, vim.split( vim.fn.glob( vscode_java_test_extension ), "\n" ) )

local jdtls_dir = mason_dir .. "jdtls"
local platform_config =
    vim.fn.has( "mac" ) == 1 and "config_mac"
    or vim.fn.has( "win32" ) == 1 and "config_win"
    or "config_linux"
local jdtls_config = string.format( "%s/%s", jdtls_dir, platform_config )

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "java", -- Requires 17
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    string.format( "-javaagent:%s/lombok.jar", jdtls_dir ),
    string.format( "-Xbootclasspath/a:%s", jdtls_dir ),
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    -- 💀
    "-jar",
    vim.fn.glob( string.format( "%s/plugins/org.eclipse.equinox.launcher_*.jar", jdtls_dir ) ),
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    "-configuration", jdtls_config,
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    "-data", workspace_dir
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require( "jdtls.setup" ).find_root( { ".git", "mvnw", "gradlew" } ),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don"t plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles
  }
}

local java_cmds = vim.api.nvim_create_augroup( 'java_cmds', { clear = true } )
local function enable_codelens( bufnr )
  pcall( vim.lsp.codelens.refresh )

  vim.api.nvim_create_autocmd( 'BufWritePost', {
    buffer = bufnr,
    group = java_cmds,
    desc = 'refresh codelens',
    callback = function()
      pcall( vim.lsp.codelens.refresh )
    end,
  } )
end

config[ "on_attach" ] = function( _, bufnr )
  -- With `hotcodereplace = "auto"` the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  jdtls.setup_dap( { hotcodereplace = "auto" } )
  require( "jdtls.dap" ).setup_dap_main_class_configs()
  enable_codelens( bufnr )
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach( config )

-- Keymaps
vim.keymap.set( "n", "<leader>gt", [[:lua require( "jdtls.tests" ).goto_subjects()<CR>]],
  { silent = true, desc = "Go to test/subject" } )
vim.keymap.set( "n", "<leader>gT", [[:lua require( "jdtls.tests" ).generate()<CR>]],
  { silent = true, desc = "Generate tests" } )
