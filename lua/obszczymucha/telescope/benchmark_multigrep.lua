-- Benchmark script for multigrep functionality
-- Usage: nvim --headless -c "luafile benchmark_multigrep.lua" -c "qa"

local multigrep_core = require( "obszczymucha.telescope.multigrep_core" )

local function execute_command( cmd )
  local result = vim.system( cmd, { text = true } ):wait()
  return result.stdout or "", result.code
end

local function benchmark_command( name, prompt, iterations )
  iterations = iterations or 10
  print( string.format( "=== %s ===", name ) )

  local cmd = multigrep_core.generate_multigrep_command( prompt )

  if not cmd then
    print( "  ERROR: No command generated" )
    return 0, {}
  end

  print( string.format( "Command for prompt '%s':", prompt ) )

  if type( cmd ) == "table" then
    print( "  " .. table.concat( cmd, " " ) )
  else
    print( "  " .. tostring( cmd ) )
  end

  local total_time = 0
  local times = {}
  local result_count = nil

  for i = 1, iterations do
    local start_time = vim.loop.hrtime()
    local output = execute_command( cmd )
    local end_time = vim.loop.hrtime()
    local duration = (end_time - start_time) / 1e9

    local lines = 0
    for _ in output:gmatch( "[^\n]+" ) do
      lines = lines + 1
    end

    if result_count == nil then
      result_count = lines
    end

    table.insert( times, duration )
    total_time = total_time + duration

    print( string.format( "  Run %d: %.4fs (results: %d)", i, duration, lines ) )
  end

  local avg_time = total_time / iterations
  print( string.format( "  Average: %.4fs", avg_time ) )
  print( "" )

  return avg_time, times, result_count
end

local function run_benchmark()
  print( "=== Multigrep Lua-based Benchmark (Neovim) ===" )
  print( "Testing directory: " .. vim.fn.getcwd() )
  print( "" )

  local results = {}

  local test_cases = {
    { "Single term",               "function" },
    { "Double term (current awk)", "function || return" },
    { "Triple term (current awk)", "function || return || local" },
    { "With glob pattern",         "function || return  *.lua" }
  }

  for _, test_case in ipairs( test_cases ) do
    local name, prompt = test_case[ 1 ], test_case[ 2 ]
    local avg_time, times, result_count = benchmark_command( name, prompt )
    results[ name ] = { avg_time = avg_time, times = times, result_count = result_count }
  end

  print( "=== Performance Summary ===" )

  local baseline = results[ "Single term" ].avg_time

  for _, test_case in ipairs( test_cases ) do
    local name = test_case[ 1 ]
    local data = results[ name ]
    local relative = (data.avg_time / baseline - 1) * 100
    print( string.format( "%-30s: %.4fs (%+.1f%%) - %d results",
      name, data.avg_time, relative, data.result_count or 0 ) )
  end

  local results_file = "BENCHMARK_RESULTS.md"
  local f = io.open( results_file, "w" )

  if not f then
    print( "Error: Could not open " .. results_file .. " for writing" )
    return
  end

  f:write( "# Multigrep Benchmark Results\n\n" )
  f:write( "**Date:** " .. os.date( "%Y-%m-%d %H:%M:%S" ) .. "\n" )
  f:write( "**Directory:** " .. vim.fn.getcwd() .. "\n\n" )
  f:write( "| Test Case | Average Time | Relative | Results |\n" )
  f:write( "|-----------|--------------|----------|---------|\n" )

  for _, test_case in ipairs( test_cases ) do
    local name = test_case[ 1 ]
    local data = results[ name ]
    local relative = (data.avg_time / baseline - 1) * 100
    f:write( string.format( "| %s | %.4fs | %+.1f%% | %d |\n",
      name, data.avg_time, relative, data.result_count or 0 ) )
  end

  f:close()
  print( "\nResults saved to: " .. results_file )
end

run_benchmark()
