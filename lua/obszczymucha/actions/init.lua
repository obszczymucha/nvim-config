local M = {}

local prefixes = {
  action = "[a]",
  command = "[c]",
  editable_command = "[e]"
}

local actions_list = require( "obszczymucha.actions.actions" )
local commands_list = require( "obszczymucha.actions.commands" )
local editable_commands_list = require( "obszczymucha.actions.editable_commands" )

local actions = {}

for _, item in ipairs( actions_list ) do
  local action = vim.deepcopy( item )
  action.type = "action"
  table.insert( actions, action )
end

for _, item in ipairs( commands_list ) do
  local action = vim.deepcopy( item )
  action.type = "command"
  table.insert( actions, action )
end

for _, item in ipairs( editable_commands_list ) do
  local action = vim.deepcopy( item )
  action.type = "editable_command"
  table.insert( actions, action )
end

M.browse = function()
  local pickers = require( "telescope.pickers" )
  local finders = require( "telescope.finders" )
  local conf = require( "telescope.config" ).values
  local telescope_actions = require( "telescope.actions" )
  local action_state = require( "telescope.actions.state" )
  local entry_display = require( "telescope.pickers.entry_display" )

  local max_prefix = 1
  for _, prefix in pairs( prefixes ) do
    max_prefix = math.max( max_prefix, #prefix )
  end

  local displayer = entry_display.create( {
    separator = " ",
    items = {
      { width = max_prefix },
      { remaining = true },
    },
  } )

  local function make_display( entry )
    local prefix = prefixes[ entry.value.type ] or ""
    return displayer( { { prefix, "Label" }, entry.value.name } )
  end

  pickers.new( {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        mirror = false,
        prompt_position = "bottom"
      },
      width = 60,
      height = 18
    },
    attach_mappings = function( _, map )
      map( "i", "<A-q>", telescope_actions.close )
      map( "n", "<A-q>", telescope_actions.close )

      return true
    end,
    results_title = false,
    prompt_title = "Actions"
  }, {
    prompt_title = "",
    finder = finders.new_table {
      results = actions,
      entry_maker = function( entry )
        return {
          value = entry,
          display = make_display,
          ordinal = entry.name,
        }
      end,
    },
    sorter = conf.generic_sorter( {} ),
    attach_mappings = function( prompt_bufnr )
      telescope_actions.select_default:replace( function()
        telescope_actions.close( prompt_bufnr )

        local selection = action_state.get_selected_entry()

        if selection and selection.value then
          if selection.value.type == "action" then
            selection.value.action()
          elseif selection.value.type == "command" then
            vim.cmd( selection.value.action )
          elseif selection.value.type == "editable_command" then
            vim.fn.feedkeys( ":" .. selection.value.action )
          end
        end
      end )
      return true
    end,
  } ):find()
end

vim.keymap.set( "n", "<leader>fa", "<cmd>lua R( 'obszczymucha.actions' ).browse()<CR>", { desc = "Browse actions" } )

return M
