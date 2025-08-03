local M = {}

local prefixes = {
  action = "[a]",
  command = "[c]",
  editable_command = "[e]"
}

local action_type_to_module_name = {
  action = "obszczymucha.actions.actions",
  command = "obszczymucha.actions.commands",
  editable_command = "obszczymucha.actions.editable_commands"
}

local function should_display_action( action )
  local filetype_mismatch = action.filetypes and not vim.tbl_contains( action.filetypes, vim.bo.filetype )
  if filetype_mismatch then return false end
  if action.condition and type( action.condition ) == "function" and not action.condition() then return false end

  return true
end

local function create_highlighting_sorter()
  local empty_sorter = require( "telescope.sorters" ).empty()
  local wrapped_sorter = setmetatable( {}, { __index = empty_sorter } )

  wrapped_sorter.highlighter = function( _, prompt, line )
    if prompt == "" then return {} end

    local highlights = {}
    -- Extract just the action name from the display line
    -- Format is "N [prefix] action_name"
    local action_name = line:match( "%d+ %[.-%] (.+)" )
    if not action_name then
      -- Fallback: try to match the whole line as action name
      action_name = line
    end

    local positions = require( "telescope.algos.fzy" ).positions( prompt, action_name )
    if positions then
      -- Calculate offset: length of everything before the action name
      local prefix_length = line:len() - action_name:len()

      for _, pos in ipairs( positions ) do
        table.insert( highlights, {
          start = pos + prefix_length,
          finish = pos + prefix_length
        } )
      end
    end

    return highlights
  end

  return wrapped_sorter
end

local function find_action_definition( action_name, action_type )
  local module_name = action_type_to_module_name[ action_type ]
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

local actions = {}

for action_type, module_name in pairs( action_type_to_module_name ) do
  local actions_list = require( module_name )
  for _, item in ipairs( actions_list ) do
    local action = vim.deepcopy( item )
    action.type = action_type
    if should_display_action( action ) then
      table.insert( actions, action )
    end
  end
end

table.sort( actions, function( a, b )
  local score_a = a.score or 500
  local score_b = b.score or 500
  if score_a ~= score_b then
    return score_a < score_b
  end
  return a.name < b.name
end )

M.browse = function()
  local pickers = require( "telescope.pickers" )
  local finders = require( "telescope.finders" )
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
      { width = 1 },
      { width = max_prefix },
      { remaining = true },
    },
  } )


  local picker = pickers.new( {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        mirror = false,
        prompt_position = "bottom"
      },
      width = 50,
      height = 14
    },
    previewer = false,
    default_text = "",
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

      for i = 1, 9 do
        local function execute_action( prompt_bufnr )
          local current_picker = action_state.get_current_picker( prompt_bufnr )
          local all_entries = {}

          for entry in current_picker.manager:iter() do
            table.insert( all_entries, entry )
          end

          if all_entries[ i ] then
            telescope_actions.close( prompt_bufnr )
            local action = all_entries[ i ].value
            if action.type == "action" then
              action.action()
            elseif action.type == "command" then
              vim.cmd( action.action )
            elseif action.type == "editable_command" then
              vim.fn.feedkeys( ":" .. action.action )
            end
          else
            vim.notify( "Debug - No entry found for index " .. i .. ". Available entries: " .. #all_entries,
              vim.log.levels.WARN )
          end
        end

        map( "i", tostring( i ), execute_action )
        map( "n", tostring( i ), execute_action )
      end

      return true
    end,
    results_title = false,
    prompt_title = "Actions"
  }, {
    prompt_title = "",
    finder = finders.new_dynamic {
      fn = function( prompt )
        local filtered_actions = {}

        if prompt == "" then
          -- No filtering, use original order
          for i, action in ipairs( actions ) do
            local action_copy = vim.deepcopy( action )
            action_copy.display_index = i
            table.insert( filtered_actions, action_copy )
          end
        else
          -- Apply fuzzy matching manually
          local matches = {}
          for _, action in ipairs( actions ) do
            local score = require( "telescope.algos.fzy" ).score( prompt, action.name )
            if score > require( "telescope.algos.fzy" ).get_score_floor() then
              -- Boost score for prefix matches (lower score = better)
              local bonus = 0
              if action.name:lower():sub( 1, #prompt ) == prompt:lower() then
                bonus = -1000 -- Strong bonus for exact prefix match
              elseif action.name:lower():find( "^" .. prompt:lower() ) then
                bonus = -500  -- Bonus for case-insensitive prefix
              end

              table.insert( matches, { action = action, score = score + bonus } )
            end
          end

          -- Sort by fuzzy score (lower is better)
          table.sort( matches, function( a, b ) return a.score < b.score end )

          -- Assign sequential indices
          for i, match in ipairs( matches ) do
            local action_copy = vim.deepcopy( match.action )
            action_copy.display_index = i
            action_copy.fuzzy_score = match.score
            table.insert( filtered_actions, action_copy )
          end
        end

        return filtered_actions
      end,
      entry_maker = function( entry )
        local telescope_entry = {
          value = entry,
          ordinal = entry.name,
          index = entry.display_index
        }
        telescope_entry.display = function( item )
          local prefix = prefixes[ entry.type ] or ""
          return displayer( { { item.index, "Number" }, { prefix, "Label" }, entry.name } )
        end
        return telescope_entry
      end
    },
    sorter = create_highlighting_sorter(),
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
  } )

  local original_create_window = picker._create_window

  picker._create_window = function( self, bufnr, popup_opts, nowrap )
    popup_opts.borderhighlight = "ActionsTelescopeBorder"
    return original_create_window( self, bufnr, popup_opts, nowrap )
  end

  picker:find()
end

vim.keymap.set( "n", "<leader>fa", "<cmd>lua R( 'obszczymucha.actions' ).browse()<CR>", { desc = "Browse actions" } )

return M
