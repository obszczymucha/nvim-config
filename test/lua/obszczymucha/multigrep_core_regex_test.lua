package.path = "../../?.lua;" .. package.path .. ";../../../lua/?.lua"
require( "vim-mock" ).setup()

local lu, eq = require( "utils" ).luaunit( "assertEquals", "assertTrue", "assertFalse" )
local test_utils = require( "multigrep_test_utils" )
local state = require( "obszczymucha.state.telescope" )

local execute_search = test_utils.execute_search
local has_match = test_utils.has_match

MultigrepRegexSpec = {}

function MultigrepRegexSpec:setUp()
  state.case_sensitivity = "respect"
  state.show_hidden = false
end

function MultigrepRegexSpec:should_find_with_literal_and_regex()
  local results = execute_search( "hello |~ t.*t" )

  eq( #results, 4 )
  has_match( results, "file1.txt", 5, "Running hello test to verify the search works." )
  has_match( results, "code.lua", 11, "return { hello = hello, test = test }" )
  has_match( results, "code.js", 11, "module.exports = { hello, test };" )
end

function MultigrepRegexSpec:should_find_with_regex_dot_wildcard()
  local results = execute_search( "lazy |~ lazy.*" )

  eq( #results, 2 )
  has_match( results, "file1.txt", 1, "The quick brown fox jumps over the lazy dog." )
  has_match( results, "file2.txt", 4, "The fox is not lazy." )
end

function MultigrepRegexSpec:should_find_with_regex_word_pattern()
  local results = execute_search( "world |~ world.*Kenny" )

  eq( #results, 1 )
  has_match( results, "file1.txt", 2, "Hello world Princess Kenny." )
end

function MultigrepRegexSpec:should_find_with_regex_in_function()
  local results = execute_search( "function |~ function.*\\(" )

  eq( #results, 4 )
  has_match( results, "code.lua", 1, "local function hello()" )
  has_match( results, "code.lua", 6, "local function test()" )
  has_match( results, "code.js", 1, "function hello() {" )
  has_match( results, "code.js", 6, "function test() {" )
end

lu.LuaUnit.run()
