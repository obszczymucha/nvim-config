local M = {}

local prefixes = {
  action = "[a]",
  command = "[c]",
  editable_command = "[e]"
}

local module_names = {
  action = "obszczymucha.actions.actions",
  command = "obszczymucha.actions.commands",
  editable_command = "obszczymucha.actions.editable_commands"
}

local function find_action_definition( action_name, action_type )
  local module_name = module_names[ action_type ]
  local lua_path = module_name and module_name:gsub( "%.", "/" ) .. ".lua"
  local file_path = lua_path and vim.api.nvim_get_runtime_file( "lua/" .. lua_path, false )[ 1 ]

  if not file_path then return nil end

  local bufnr = vim.fn.bufadd( file_path )

  if not vim.api.nvim_buf_is_loaded( bufnr ) then
    vim.fn.bufload( bufnr )
  end

  local parser = vim.treesitter.get_parser( bufnr, "lua" )
  if not parser then return nil end

  local tree = parser:parse()[ 1 ]
  local root = tree:root()
  local query = vim.treesitter.query.parse( "lua", [[
    (field
      name: (identifier) @field_name
      (#eq? @field_name "name")
      value: (string (string_content) @name_value))
  ]] )

  for id, node in query:iter_captures( root, bufnr, 0, -1 ) do
    local capture_name = query.captures[ id ]

    if capture_name == "name_value" and node and type( node.range ) == "function" then
      local str_text = vim.treesitter.get_node_text( node, bufnr )

      if str_text == action_name then
        local start_row, start_col, _, _ = node:range()
        return { file = file_path, line = start_row + 1, col = start_col + 1 }
      end
    end
  end

  return nil
end

local actions_list = require( module_names.action )
local commands_list = require( module_names.command )
local editable_commands_list = require( module_names.editable_command )

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
      width = 50,
      height = 14
    },
    attach_mappings = function( _, map )
      map( "i", "<A-q>", telescope_actions.close )
      map( "n", "<A-q>", telescope_actions.close )

      local function open_action_definition( prompt_bufnr )
        local selection = action_state.get_selected_entry()
        local location = selection and selection.value and
            find_action_definition( selection.value.name, selection.value.type )

        if not location then
          vim.notify( "Could not find action definition.", vim.log.levels.WARN )
          return
        end

        telescope_actions.close( prompt_bufnr )
        vim.cmd( "edit " .. location.file )
        vim.api.nvim_win_set_cursor( 0, { location.line, location.col - 1 } )
      end

      map( "i", "<A-e>", open_action_definition )
      map( "n", "<A-e>", open_action_definition )

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
