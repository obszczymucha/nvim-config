-- luacheck: globals vim
local pickers = require( "telescope.pickers" )
local finders = require( "telescope.finders" )
local conf = require( "telescope.config" ).values
local actions = require( "telescope.actions" )
local action_state = require( "telescope.actions.state" )
local utils = require( "obszczymucha.utils" )
local path_utils = require( "obszczymucha.path-utils" )

local M = {}

function M.search_directories( opts )
  opts = opts or {}
  opts.cwd = opts.cwd or utils.get_project_root_dir()

  local max_depth = opts.max_depth or 3
  local directories = path_utils.scan_directories( opts.cwd, max_depth )

  local finder = finders.new_table( {
    results = directories,
    entry_maker = function( entry )
      local display = vim.fn.fnamemodify( entry, ":~:." )
      return {
        value = entry,
        display = display,
        ordinal = display,
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
