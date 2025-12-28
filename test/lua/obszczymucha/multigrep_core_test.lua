package.path = "../../?.lua;" .. package.path .. ";../../../lua/?.lua"
require( "vim-mock" ).setup()

local lu, eq = require( "utils" ).luaunit( "assertEquals", "assertTrue", "assertFalse" )

local multigrep_core = require( "obszczymucha.telescope.multigrep_core" )
local state = require( "obszczymucha.state.telescope" )

MultigrepCoreSpec = {}

local FIXTURE_DIR = "../../fixtures/multigrep"

local function execute_search( prompt )
  local command = multigrep_core.generate_multigrep_command( prompt )
  if not command then return {} end

  table.insert( command, FIXTURE_DIR )

  local escaped_args = {}
  for _, arg in ipairs( command ) do
    if arg:match( "%s" ) or arg:match( "[\"']" ) then
      local escaped = arg:gsub( "'", "'\\''" )
      table.insert( escaped_args, "'" .. escaped .. "'" )
    else
      table.insert( escaped_args, arg )
    end
  end

  local cmd_str = table.concat( escaped_args, " " )
  local handle = io.popen( cmd_str )
  if not handle then return {} end

  local results = {}
  for line in handle:lines() do
    table.insert( results, line )
  end
  handle:close()

  return results, cmd_str
end

local function has_match( results, filename, line_num, expected_content )
  local expected_line = string.format( "%s:%d:%s", filename, line_num, expected_content )
  for _, line in ipairs( results ) do
    if line == expected_line then
      return
    end
  end
  lu.fail( string.format( "Expected exact line: %s", expected_line ) )
end

function MultigrepCoreSpec:setUp()
  state.case_sensitivity = "respect"
  state.show_hidden = false
end

function MultigrepCoreSpec:should_find_hello_case_insensitive()
  state.case_sensitivity = "ignore"
  local results = execute_search( "hello" )

  eq( #results, 11 )
  has_match( results, "file1.txt", 2, "Hello world" )
  has_match( results, "file1.txt", 5, "hello test" )
  has_match( results, "file2.txt", 2, "Hello from" )
  has_match( results, "code.lua", 1, "function hello()" )
  has_match( results, "code.lua", 2, 'print("Hello world")'  )
  has_match( results, "code.lua", 7, "hello()" )
  has_match( results, "code.lua", 11, "hello = hello, test = test" )
  has_match( results, "code.js", 1, "function hello() {" )
  has_match( results, "code.js", 2, 'console.log("Hello world");'  )
  has_match( results, "code.js", 7, "hello();" )
  has_match( results, "code.js", 11, "hello, test" )
end

function MultigrepCoreSpec:should_respect_case_when_searching()
  state.case_sensitivity = "respect"
  local results = execute_search( "hello" )

  eq( #results, 7 )
  has_match( results, "file1.txt", 5, "hello test" )
  has_match( results, "code.lua", 1, "function hello()" )
  has_match( results, "code.lua", 7, "hello()" )
  has_match( results, "code.lua", 11, "hello = hello, test = test" )
  has_match( results, "code.js", 1, "function hello() {" )
  has_match( results, "code.js", 7, "hello();" )
  has_match( results, "code.js", 11, "hello, test" )
end

function MultigrepCoreSpec:should_find_fox_in_multiple_files()
  local results = execute_search( "fox" )

  eq( #results, 2 )
  has_match( results, "file1.txt", 1, "fox" )
  has_match( results, "file2.txt", 4, "fox" )
end

function MultigrepCoreSpec:should_find_with_multi_search()
  local results = execute_search( "hello | test" )

  eq( #results, 3 )
  has_match( results, "file1.txt", 5, "hello test" )
  has_match( results, "code.lua", 11, "hello = hello, test = test" )
  has_match( results, "code.js", 11, "hello, test" )
end

function MultigrepCoreSpec:should_filter_by_glob_pattern()
  local results = execute_search( "hello  *.lua" )

  eq( #results, 3 )
  has_match( results, "code.lua", 1, "function hello()" )
  has_match( results, "code.lua", 7, "hello()" )
  has_match( results, "code.lua", 11, "hello = hello, test = test" )
end

function MultigrepCoreSpec:should_return_empty_for_no_matches()
  local results = execute_search( "nonexistent_term_xyz" )

  eq( #results, 0 )
end

lu.LuaUnit.run()
