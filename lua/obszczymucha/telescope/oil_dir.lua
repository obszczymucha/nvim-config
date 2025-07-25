local pickers = require( "telescope.pickers" )
local finders = require( "telescope.finders" )
local conf = require( "telescope.config" ).values
local actions = require( "telescope.actions" )
local action_state = require( "telescope.actions.state" )
local utils = require( "obszczymucha.utils" )

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

local function add_untracked_directories( cwd, tracked_dirs )
  local untracked_dirs = vim.fn.systemlist( "cd " ..
    vim.fn.shellescape( cwd ) .. " && git ls-files --others --directory --exclude-standard" )

  for _, dir in ipairs( untracked_dirs ) do
    if dir:match( "/$" ) then
      local full_path = cwd .. "/" .. dir:gsub( "/$", "" )

      if vim.fn.isdirectory( full_path ) == 1 then
        tracked_dirs[ full_path ] = true
      end
    end
  end
end

local function scan_git_directories( cwd )
  local tracked_dirs = get_tracked_directories( cwd )
  add_untracked_directories( cwd, tracked_dirs )

  local directories = {}

  for dir, _ in pairs( tracked_dirs ) do
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

function M.search_directories( opts )
  opts = opts or {}
  opts.cwd = opts.cwd or utils.get_project_root_dir()

  local max_depth = opts.max_depth or 3

  local directories = is_git_repository( opts.cwd )
      and scan_git_directories( opts.cwd )
      or scan_filesystem_directories( opts.cwd, max_depth )

  local finder = finders.new_table( {
    results = directories,
    entry_maker = function( entry )
      return {
        value = entry,
        display = vim.fn.fnamemodify( entry, ":~:." ),
        ordinal = entry,
      }
    end,
  } )

  local function open_oil( prompt_bufnr )
    local selection = action_state.get_selected_entry()
    actions.close( prompt_bufnr )

    if selection then
      vim.cmd( "Oil --float " .. vim.fn.fnameescape( selection.value ) )
    end
  end

  pickers.new( opts, {
    prompt_title = "Open Directory",
    results_title = false,
    finder = finder,
    sorter = conf.generic_sorter( opts ),
    layout_config = {
      width = 60,
    },
    attach_mappings = function( _, map )
      actions.select_default:replace( open_oil )

      map( "i", "<CR>", open_oil )
      map( "n", "<CR>", open_oil )
      map( "i", "<C-u>", actions.results_scrolling_up )
      map( "n", "<C-u>", actions.results_scrolling_up )
      map( "i", "<C-d>", actions.results_scrolling_down )
      map( "n", "<C-d>", actions.results_scrolling_down )

      return true
    end,
  } ):find()
end

return M
