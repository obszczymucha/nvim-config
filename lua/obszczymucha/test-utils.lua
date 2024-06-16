local M = {}

function M.resolve_source_filename( test_filename, relative_source_filename )
  local test_directory = test_filename:match( "^(.*[/\\])" )
  local combined_path = test_directory .. relative_source_filename
  local parts = {}

  for part in string.gmatch( combined_path, "[^/\\]+" ) do
    if part == ".." then
      table.remove( parts )
    elseif part ~= "." then
      table.insert( parts, part )
    end
  end

  return table.concat( parts, "/" )
end

return M
