package.path = "../../?.lua;" .. package.path .. ";../../../lua/?.lua"
require( "vim-mock" ).setup()

local lu, eq = require( "utils" ).luaunit( "assertEquals", "assertTrue", "assertFalse" )
local test_utils = require( "multigrep_test_utils" )
local state = require( "obszczymucha.state.telescope" )

local execute_search = test_utils.execute_search
local has_match = test_utils.has_match

MultigrepCoreSpec = {}

function MultigrepCoreSpec:setUp()
  state.case_sensitivity = "respect"
  state.show_hidden = false
end

function MultigrepCoreSpec:should_find_hello_case_insensitive()
  state.case_sensitivity = "ignore"
  local results = execute_search( "hello" )

  eq( #results, 11 )
  has_match( results, "file1.txt", 2, "Hello world Princess Kenny." )
  has_match( results, "file1.txt", 5, "Running hello test to verify the search works." )
  has_match( results, "file2.txt", 2, "Hello from world." )
  has_match( results, "code.lua", 1, "local function hello()" )
  has_match( results, "code.lua", 2, '  print("Hello world")' )
  has_match( results, "code.lua", 7, "  local result = hello()" )
  has_match( results, "code.lua", 11, "return { hello = hello, test = test }" )
  has_match( results, "code.js", 1, "function hello() {" )
  has_match( results, "code.js", 2, '  console.log("Hello world");' )
  has_match( results, "code.js", 7, "  const result = hello();" )
  has_match( results, "code.js", 11, "module.exports = { hello, test };" )
end

function MultigrepCoreSpec:should_respect_case_when_searching()
  state.case_sensitivity = "respect"
  local results = execute_search( "hello" )

  eq( #results, 7 )
  has_match( results, "file1.txt", 5, "Running hello test to verify the search works." )
  has_match( results, "code.lua", 1, "local function hello()" )
  has_match( results, "code.lua", 7, "  local result = hello()" )
  has_match( results, "code.lua", 11, "return { hello = hello, test = test }" )
  has_match( results, "code.js", 1, "function hello() {" )
  has_match( results, "code.js", 7, "  const result = hello();" )
  has_match( results, "code.js", 11, "module.exports = { hello, test };" )
end

function MultigrepCoreSpec:should_find_fox_in_multiple_files()
  local results = execute_search( "fox" )

  eq( #results, 2 )
  has_match( results, "file1.txt", 1, "The quick brown fox jumps over the lazy dog." )
  has_match( results, "file2.txt", 4, "The fox is not lazy." )
end

function MultigrepCoreSpec:should_find_with_multi_search()
  local results = execute_search( "hello | test" )

  eq( #results, 3 )
  has_match( results, "file1.txt", 5, "Running hello test to verify the search works." )
  has_match( results, "code.lua", 11, "return { hello = hello, test = test }" )
  has_match( results, "code.js", 11, "module.exports = { hello, test };" )
end

function MultigrepCoreSpec:should_filter_by_glob_pattern()
  local results = execute_search( "hello  *.lua" )

  eq( #results, 3 )
  has_match( results, "code.lua", 1, "local function hello()" )
  has_match( results, "code.lua", 7, "  local result = hello()" )
  has_match( results, "code.lua", 11, "return { hello = hello, test = test }" )
end

function MultigrepCoreSpec:should_return_empty_for_no_matches()
  local results = execute_search( "nonexistent_term_xyz" )

  eq( #results, 0 )
end

lu.LuaUnit.run()
