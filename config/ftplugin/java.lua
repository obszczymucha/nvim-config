local project_name = vim.fn.fnamemodify( vim.fn.getcwd(), ":p:h:t" )
local jdtls_dir = os.getenv( "HOME" ) .. "/.local/share/nvim/mason/packages/jdtls"
local workspace_dir = os.getenv( "HOME" ) .. "/.jdtls/" .. project_name
local java_debug_plugin = os.getenv( "JAVA_DEBUG_PLUGIN_DIR" ) ..
    "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
local vscode_java_test_extension = os.getenv( "VSCODE_JAVA_TEST_EXTENSION_DIR" ) .. "/server/*jar"

local bundles = {
  vim.fn.glob( java_debug_plugin )
}

vim.list_extend( bundles, vim.split( vim.fn.glob( vscode_java_test_extension ), "\n" ) )

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
    "-configuration",
    string.format( "%s/%s", jdtls_dir, os.getenv( "JDTLS_CONFIG" ) ),
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

config[ "on_attach" ] = function( client, bufnr )
  -- With `hotcodereplace = "auto"` the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  require( "jdtls" ).setup_dap( { hotcodereplace = "auto" } )
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require( "jdtls" ).start_or_attach( config )
