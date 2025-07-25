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
  local max_depth = opts.max_depth or 20

  local directories = {}

  local function scan_dir( path, depth )
    if depth > max_depth then return end

    local items = vim.fn.glob( path .. "/*", false, true )

    for _, item in ipairs( items ) do
      if vim.fn.isdirectory( item ) == 1 then
        local basename = vim.fn.fnamemodify( item, ":t" )

        if not basename:match( "^%." ) then
          table.insert( directories, item )
          scan_dir( item, depth + 1 )
        end
      end
    end
  end

  scan_dir( opts.cwd, 0 )

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
