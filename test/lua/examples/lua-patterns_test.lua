package.path = "../../?.lua;" .. package.path .. ";../../../lua/?.lua"

local lu, eq = require( "utils" ).luaunit( "assertEquals" )

---@diagnostic disable-next-line: different-requires
local common = require( "obszczymucha.common" )

RustTestSpec = {
  -- Had to extract the pattern as common, because this pattern should match multiple cases.
  -- It would be nice to have parametrized tests to avoid this.
  pattern = "---- ([^:]+)::([^:]+)::([^:%s]+):*(%S*) stdout ----"
}

function RustTestSpec:should_parse_rust_test_name()
  -- Given
  local input = "---- mapping_handler::tests::should_match_keys_to_mappings stdout ----"

  -- When
  local short_name, module_name, test_name, case_name = input:match( RustTestSpec.pattern )

  -- Then
  eq( short_name, "mapping_handler" )
  eq( module_name, "tests" )
  eq( test_name, "should_match_keys_to_mappings" )
  eq( case_name, "" )
end

function RustTestSpec:should_parse_rstest_test_name_with_case_name()
  -- Given
  local input = "---- mapping_handler::tests::should_match_keys_to_mappings::case_2 stdout ----"

  -- When
  local short_name, module_name, test_name, case_name = input:match( RustTestSpec.pattern )

  -- Then
  eq( short_name, "mapping_handler" )
  eq( module_name, "tests" )
  eq( test_name, "should_match_keys_to_mappings" )
  eq( case_name, "case_2" )
end

LuaTestSpec = {
  -- Had to extract the pattern as common, because this pattern should match multiple cases.
  -- It would be nice to have parametrized tests to avoid this.
  pattern = function( filename )
    return "#*%s*" .. filename .. ":(%d+):%s*expected: ?(.*)"
  end
}

-- The # at the start of the pattern is a strange phenomena that only shows
-- when printing the output of the tests in neovim (<leader>dq).
-- When running ./test.sh in shell, there is no fucking #...
function LuaTestSpec:should_parse_line_number_with_hash_at_the_start()
  -- Given
  local input = "#   common_test.lua:27: expected: \"upa.jas\""
  local filename = "common_test.lua"
  local escaped_filename = common.escape_filename( filename )
  local pattern = LuaTestSpec.pattern( escaped_filename )

  -- When
  local line_number = input:match( pattern )

  -- Then
  eq( line_number, "27" )
end

function LuaTestSpec:should_parse_line_number()
  -- Given
  local input = "common_test.lua:27: expected: \"upa.jas\""
  local filename = "common_test.lua"
  local escaped_filename = common.escape_filename( filename )
  local pattern = LuaTestSpec.pattern( escaped_filename )

  -- When
  local line_number = input:match( pattern )

  -- Then
  eq( line_number, "27" )
end

function LuaTestSpec:should_parse_expected_value()
  -- Given
  local input = "common_test.lua:27: expected: \"upa.jas\""
  local filename = "common_test.lua"
  local escaped_filename = common.escape_filename( filename )
  local pattern = LuaTestSpec.pattern( escaped_filename )

  -- When
  local _, expected = input:match( pattern )

  -- Then
  eq( expected, "\"upa.jas\"" )
end

function LuaTestSpec:should_parse_general_lua_error()
  -- Given
  local input = "lua: lua_patterns_test.lua:4: module 'common' not found:"
  local filename = "lua_patterns_test.lua"
  local escaped_filename = common.escape_filename( filename )
  local pattern = "#*%s*lua: " .. escaped_filename .. ":(%d+): (.*)"

  -- When
  local line_number, error_name = input:match( pattern )

  -- Then
  eq( line_number, "4" )
  eq( error_name, "module 'common' not found:" )
end

function LuaTestSpec:should_parse_general_lua_error2()
  -- Given
  local input = "lua: lua-patterns_test.lua:4: module 'common' not found:"
  local filename = "lua-patterns_test.lua"
  local escaped_filename = common.escape_filename( filename )
  local pattern = "#*%s*lua: " .. escaped_filename .. ":(%d+): (.*)"

  -- When
  local line_number, error_name = input:match( pattern )

  -- Then
  eq( line_number, "4" )
  eq( error_name, "module 'common' not found:" )
end

lu.LuaUnit.run()
