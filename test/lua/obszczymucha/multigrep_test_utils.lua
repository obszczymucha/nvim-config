local M = {}

local FIXTURE_DIR = "../../fixtures/multigrep"

function M.execute_search( prompt )
  local multigrep_core = require( "obszczymucha.telescope.multigrep_core" )
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

function M.has_match( results, expected_filename, line_num, expected_content )
  local expected_line = string.format( "%s:%d:%s", expected_filename, line_num, expected_content )

  for _, line in ipairs( results ) do
    for filename, line_number, content in line:gmatch( ".*/(.-):(%d-):%d-:(.*)" ) do
      if filename == expected_filename and tonumber( line_number ) == line_num then
        if content == expected_content then
          return
        else
          error( string.format( "Was: %s  Expected: %s", content, expected_content ), 2 )
        end
      end
    end
  end

  error( string.format( "Expected exact line: %s", expected_line ), 2 )
end

return M
