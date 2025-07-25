local pickers = require( "telescope.pickers" )
local finders = require( "telescope.finders" )
local conf = require( "telescope.config" ).values
local actions = require( "telescope.actions" )
local action_state = require( "telescope.actions.state" )
local utils = require( "obszczymucha.utils" )

local M = {}

function M.search_directories( opts )
  opts = opts or {}
  opts.cwd = opts.cwd or utils.get_project_root_dir()

  local directories = {}
  local tracked_dirs = {}
  local tracked_files = vim.fn.systemlist( "git ls-files --directory " .. vim.fn.shellescape( opts.cwd ) )

  for _, file in ipairs( tracked_files ) do
    if file:match( "/$" ) then
      local full_path = opts.cwd .. "/" .. file:gsub( "/$", "" )
      tracked_dirs[ full_path ] = true
    else
      local dir = vim.fn.fnamemodify( opts.cwd .. "/" .. file, ":h" )

      while dir ~= opts.cwd and dir ~= "/" do
        tracked_dirs[ dir ] = true
        dir = vim.fn.fnamemodify( dir, ":h" )
      end
    end
  end

  local untracked_dirs = vim.fn.systemlist( "git ls-files --others --directory --exclude-standard " ..
    vim.fn.shellescape( opts.cwd ) )
  for _, dir in ipairs( untracked_dirs ) do
    if dir:match( "/$" ) then
      local full_path = opts.cwd .. "/" .. dir:gsub( "/$", "" )
      tracked_dirs[ full_path ] = true
    end
  end

  for dir, _ in pairs( tracked_dirs ) do
    if vim.fn.isdirectory( dir ) == 1 then
      table.insert( directories, dir )
    end
  end

  table.sort( directories )

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
      return true
    end,
  } ):find()
end

return M
