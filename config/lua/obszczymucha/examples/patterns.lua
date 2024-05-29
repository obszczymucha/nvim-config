local function test( line )
  local pattern = "---- ([^:]+)::([^:]+)::([^:%s]+):*(%S*) stdout ----"
  local short_name, module_name, test_name, case_name = line:match( pattern )

  print( string.format( "%s %s %s %s", short_name, module_name, test_name, case_name ) )
end

test( "---- mapping_handler::tests::should_match_keys_to_mappings stdout ----" )
test( "---- mapping_handler::tests::should_match_keys_to_mappings::case_2 stdout ----" )
