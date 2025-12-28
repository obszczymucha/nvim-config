package.path = "../../?.lua;" .. package.path .. ";../../../lua/?.lua"
require( "vim-mock" ).setup()

local lu, is_table, is_true = require( "utils" ).luaunit( "assertIsTable", "assertTrue" )

local path_utils = require( "obszczymucha.path-utils" )

PathUtilsSpec = {}

function PathUtilsSpec:should_scan_git_repository_with_directory()
  local fixture_path = "../../fixtures/git-repo"
  local directories = path_utils.scan_directories( fixture_path, 3 )

  is_table( directories )
  is_true( #directories > 0, "Should find directories in git repo" )

  local found_dirs = {}
  for _, dir in ipairs( directories ) do
    local relative_path = dir:gsub( "^.*/fixtures/git%-repo/", "" )
    found_dirs[ relative_path ] = true
  end

  is_true( found_dirs[ "src" ], "Should find src directory" )
  is_true( found_dirs[ "docs" ], "Should find docs directory" )
end

function PathUtilsSpec:should_scan_git_worktree_with_file()
  local fixture_path = "../../fixtures/git-worktree"
  local directories = path_utils.scan_directories( fixture_path, 3 )

  is_table( directories )
  is_true( #directories > 0, "Should find directories in git worktree" )

  local found_dirs = {}
  for _, dir in ipairs( directories ) do
    local relative_path = dir:gsub( "^.*/fixtures/git%-worktree/", "" )
    found_dirs[ relative_path ] = true
  end

  is_true( found_dirs[ "client" ], "Should find client directory" )
  is_true( found_dirs[ "server" ], "Should find server directory" )
  is_true( found_dirs[ "proto" ], "Should find proto directory" )
end

function PathUtilsSpec:should_scan_regular_directory_with_find()
  local fixture_path = "../../fixtures/regular-dir"
  local directories = path_utils.scan_directories( fixture_path, 3 )

  is_table( directories )
  is_true( #directories > 0, "Should find directories in regular directory" )

  local found_dirs = {}
  for _, dir in ipairs( directories ) do
    local relative_path = dir:gsub( "^.*/fixtures/regular%-dir/", "" )
    found_dirs[ relative_path ] = true
  end

  is_true( found_dirs[ "documents" ], "Should find documents directory" )
  is_true( found_dirs[ "downloads" ], "Should find downloads directory" )
  is_true( found_dirs[ "projects" ], "Should find projects directory" )
  is_true( found_dirs[ "projects/project1" ], "Should find nested project directories" )
  is_true( found_dirs[ "projects/project2" ], "Should find nested project directories" )
end

function PathUtilsSpec:should_sort_directories_by_depth_then_name()
  local fixture_path = "../../fixtures/regular-dir"
  local directories = path_utils.scan_directories( fixture_path, 3 )

  is_true( #directories >= 5, "Should have multiple directories for sorting test" )

  -- Check that top-level directories come before nested ones
  local depths = {}
  for _, dir in ipairs( directories ) do
    local relative_path = dir:gsub( "^.*/fixtures/regular%-dir/", "" )
    local depth = select( 2, relative_path:gsub( "/", "" ) )
    table.insert( depths, depth )
  end

  -- Verify depths are non-decreasing (sorted by depth first)
  for i = 2, #depths do
    is_true( depths[ i ] >= depths[ i - 1 ], "Directories should be sorted by depth first" )
  end
end

os.exit( lu.LuaUnit.run() )

