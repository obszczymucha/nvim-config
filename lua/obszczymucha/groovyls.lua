-- This is what's required in build.gradle for the integration to work:
--
-- task printClasspath {
--     doLast {
--         // println "Compile classpath:"
--         configurations.compileClasspath.each { println it }

--         // println "Runtime classpath:"
--         configurations.runtimeClasspath.each { println it }

--         // println "Test compile classpath:"
--         configurations.testCompileClasspath.each { println it }

--         // println "Test runtime classpath:"
--         configurations.testRuntimeClasspath.each { println it }

--         // println "Project classpath:"
--         tasks.withType(Jar) { jarTask ->
--           println jarTask.archiveFile.get().asFile.absolutePath
--         }

--         // Unfortunately this fucking groovy-language-server crap doesn't
--         // accept directories. It only accepts jars. What a piece of shit.
--         // println "${project.buildDir}/classes/java/main"
--     }
-- }

---@diagnostic disable-next-line: unused-local
local debug = require( "obszczymucha.debug" ).debug
local clear = require( "obszczymucha.debug" ).clear
local common = require( "obszczymucha.common" )

local M = {}

local is_initialized = false

local function start_server( classpath_entries )
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  if not vim.lsp.config.groovyls then return end

  vim.lsp.config.groovyls = {
    capabilities = capabilities,
    root_markers = { "", ".git" },
    filetypes = { "groovy" },
    settings = {
      groovy = {
        classpath = classpath_entries
      }
    },
    autostart = true
  }

  --vim.lsp.start_client( config )
end

function M.run()
  local results = {}
  local States = { Init = 0, Parsing = 1, Ok = 2 }
  local state = States.Init

  local function collect_results( _, data )
    if not data then return end

    for _, line in ipairs( data ) do
      if state == States.Ok then return end

      (function()
        if line == "" then return end

        if line == "> Task :app:printClasspath" then
          state = States.Parsing
          return
        end

        if common.starts_with( line, "BUILD SUCCESSFUL" ) then
          state = States.Ok
          return
        end

        table.insert( results, line )
      end)()
    end
  end

  local function print_results()
    -- for _, result in ipairs( results ) do
    --   debug( result )
    -- end

    if state == States.Ok then
      start_server( results )
      is_initialized = true
    end
  end

  local command = { "./gradlew", "app:printClasspath" }
  clear()

  vim.fn.jobstart( command, {
    stdout_buffered = true,
    on_stdout = collect_results,
    on_stderr = collect_results,
    on_exit = print_results
  } )
end

function M.setup()
  local run = function()
    if is_initialized then return end
    R( "obszczymucha.groovyls" ).run()
  end

  vim.api.nvim_create_user_command( "GroovyLS", function()
    is_initialized = false
    run()
  end, { nargs = 0 } )

  vim.api.nvim_create_autocmd( { "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup( "GroovyLS", { clear = true } ),
    pattern = "*.groovy",
    callback = run
  } )
end

M.setup()

return M
