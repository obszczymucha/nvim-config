local M = {}

local function sort_by_depth_then_name( directories )
  table.sort( directories, function( a, b )
    local depth_a = select( 2, a:gsub( "/", "" ) )
    local depth_b = select( 2, b:gsub( "/", "" ) )

    if depth_a == depth_b then
      return a < b
    end

    return depth_a < depth_b
  end )
end

local function is_git_repository( cwd )
  return vim.fn.isdirectory( cwd .. "/.git" ) == 1 or vim.fn.finddir( ".git", cwd .. ";." ) ~= ""
end

local function get_tracked_directories( cwd )
  local tracked_files = vim.fn.systemlist( "cd " .. vim.fn.shellescape( cwd ) .. " && git ls-files" )
  local tracked_dirs = {}

  for _, file in ipairs( tracked_files ) do
    local dir = vim.fn.fnamemodify( cwd .. "/" .. file, ":h" )

    while dir ~= cwd and dir ~= "/" do
      tracked_dirs[ dir ] = true
      dir = vim.fn.fnamemodify( dir, ":h" )
    end
  end

  return tracked_dirs
end

local function get_untracked_directories( cwd )
  local untracked_dirs = vim.fn.systemlist( "cd " ..
    vim.fn.shellescape( cwd ) .. " && git ls-files --others --directory --exclude-standard" )
  local dirs = {}

  for _, dir in ipairs( untracked_dirs ) do
    if dir:match( "/$" ) then
      local full_path = cwd .. "/" .. dir:gsub( "/$", "" )

      if vim.fn.isdirectory( full_path ) == 1 then
        dirs[ full_path ] = true
      end
    end
  end

  return dirs
end

local function scan_git_directories( cwd )
  local tracked_dirs = get_tracked_directories( cwd )
  local untracked_dirs = get_untracked_directories( cwd )

  local all_dirs = {}

  for dir, _ in pairs( tracked_dirs ) do
    all_dirs[ dir ] = true
  end

  for dir, _ in pairs( untracked_dirs ) do
    all_dirs[ dir ] = true
  end

  local directories = {}

  for dir, _ in pairs( all_dirs ) do
    table.insert( directories, dir )
  end

  sort_by_depth_then_name( directories )
  return directories
end

local function scan_filesystem_directories( cwd, max_depth )
  local find_cmd = string.format( "find -L %s -maxdepth %d -type d -not -path '*/.*' 2>/dev/null",
    vim.fn.shellescape( cwd ), max_depth )
  local found_dirs = vim.fn.systemlist( find_cmd )
  local directories = {}

  for _, dir in ipairs( found_dirs ) do
    if dir ~= cwd then
      table.insert( directories, dir )
    end
  end

  sort_by_depth_then_name( directories )

  return directories
end

function M.scan_directories( cwd, max_depth )
  max_depth = max_depth or 3

  if is_git_repository( cwd ) then
    return scan_git_directories( cwd )
  else
    return scan_filesystem_directories( cwd, max_depth )
  end
end

return M

