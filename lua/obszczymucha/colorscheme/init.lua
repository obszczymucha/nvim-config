local M = {}
local config = require( "obszczymucha.user-config" )
local state = require( "obszczymucha.colorscheme.state" )

local function extract_scheme_name( line )
  local scheme_name = line:match( "%d+ (.+)" )
  return scheme_name or line
end

local function create_highlighting_sorter()
  local empty_sorter = require( "telescope.sorters" ).empty()
  local wrapped_sorter = setmetatable( {}, { __index = empty_sorter } )

  wrapped_sorter.highlighter = function( _, prompt, line )
    if prompt == "" then return {} end

    local highlights = {}
    local scheme_name = extract_scheme_name( line )
    local positions = require( "telescope.algos.fzy" ).positions( prompt, scheme_name )

    if positions then
      local prefix_length = line:len() - scheme_name:len()
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

local function clear_colorscheme_cache()
  local modules_to_clear = {
    "kanagawa",
    "kanagawa.colors",
    "kanagawa.themes",
    "kanagawa.highlights",
    "plugins.colorscheme",
    "obszczymucha.color-overrides",
    "obszczymucha.colorscheme.schemes"
  }

  for _, module in ipairs( modules_to_clear ) do
    package.loaded[ module ] = nil
  end
end

function M.reload()
  clear_colorscheme_cache()
  require( "plugins.colorscheme" ).config()
  require( "obszczymucha.color-overrides" ).apply()
end

local function apply_colorscheme( scheme_name, save_config )
  if save_config == nil then save_config = true end

  if save_config then
    require( "obszczymucha.user-config" ).set_colorscheme( scheme_name )
    state.preview_override = nil
  else
    state.preview_override = scheme_name
  end

  M.reload()

  if save_config then
    vim.notify( string.format( "Applied color scheme: %s", scheme_name ), vim.log.levels.INFO )
  end
end

local function calculate_fuzzy_score( scheme_name, prompt )
  local fzy = require( "telescope.algos.fzy" )
  local score = fzy.score( prompt, scheme_name )

  if score <= fzy.get_score_floor() then
    return nil
  end

  local lower_prompt = prompt:lower()
  local lower_name = scheme_name:lower()

  if lower_name:sub( 1, #prompt ) == lower_prompt then
    return score - 1000
  elseif lower_name:find( "^" .. lower_prompt ) then
    return score - 500
  end

  return score
end

local function filter_schemes( scheme_list, prompt )
  if prompt == "" then
    local filtered = {}
    for i, name in ipairs( scheme_list ) do
      table.insert( filtered, { name = name, display_index = i } )
    end
    return filtered
  end

  local matches = {}
  for _, name in ipairs( scheme_list ) do
    local score = calculate_fuzzy_score( name, prompt )
    if score then
      table.insert( matches, { name = name, score = score } )
    end
  end

  table.sort( matches, function( a, b ) return a.score < b.score end )

  local filtered = {}
  for i, match in ipairs( matches ) do
    table.insert( filtered, { name = match.name, display_index = i } )
  end

  return filtered
end

local function create_entry_maker( displayer )
  return function( entry )
    local current_scheme = state.preview_override or config.get_colorscheme()
    local marker = entry.name == current_scheme and " •" or ""

    return {
      value = entry.name,
      ordinal = entry.name,
      index = entry.display_index,
      display = function( item )
        return displayer( { { item.index, "Number" }, entry.name .. marker } )
      end
    }
  end
end

local function create_number_mappings( map, telescope_actions, action_state )
  for i = 1, 9 do
    local function select_scheme( prompt_bufnr )
      local picker = action_state.get_current_picker( prompt_bufnr )
      local all_entries = {}

      for entry in picker.manager:iter() do
        table.insert( all_entries, entry )
      end

      if all_entries[ i ] then
        telescope_actions.close( prompt_bufnr )
        apply_colorscheme( all_entries[ i ].value )
      end
    end

    map( "i", tostring( i ), select_scheme )
    map( "n", tostring( i ), select_scheme )
  end
end

M.browse = function()
  local pickers = require( "telescope.pickers" )
  local finders = require( "telescope.finders" )
  local telescope_actions = require( "telescope.actions" )
  local action_state = require( "telescope.actions.state" )
  local entry_display = require( "telescope.pickers.entry_display" )
  local schemes = require( "obszczymucha.colorscheme.schemes" )

  local scheme_list = schemes.get_scheme_list()
  local original_scheme = require( "obszczymucha.colorscheme.state" ).preview_override or config.get_colorscheme()

  local displayer = entry_display.create( {
    separator = " ",
    items = {
      { width = 1 },
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
      width = 40,
      height = 14
    },
    previewer = false,
    default_text = "",
    results_title = false,
    prompt_title = "Color schemes"
  }, {
    prompt_title = "",
    finder = finders.new_dynamic {
      fn = function( prompt )
        return filter_schemes( scheme_list, prompt )
      end,
      entry_maker = create_entry_maker( displayer )
    },
    sorter = create_highlighting_sorter(),
    attach_mappings = function( prompt_bufnr, map )
      local function revert_and_close()
        apply_colorscheme( original_scheme, false )
        telescope_actions.close( prompt_bufnr )
      end

      telescope_actions.select_default:replace( function()
        telescope_actions.close( prompt_bufnr )
        local selection = action_state.get_selected_entry()
        if selection and selection.value then
          apply_colorscheme( selection.value )
        end
      end )

      map( "i", "<Esc>", revert_and_close )
      map( "n", "<Esc>", revert_and_close )
      map( "i", "<A-q>", revert_and_close )
      map( "n", "<A-q>", revert_and_close )

      create_number_mappings( map, telescope_actions, action_state )

      return true
    end,
  } )

  local original_set_selection = picker.set_selection
  picker.set_selection = function( self, row )
    local result = original_set_selection( self, row )
    local entry = self._selection_entry
    if entry and entry.value then
      vim.schedule( function()
        apply_colorscheme( entry.value, false )
      end )
    end
    return result
  end

  picker:find()
end

vim.keymap.set( "n", "<leader>cs", "<cmd>lua R( 'obszczymucha.colorscheme' ).browse()<CR>",
  { desc = "Browse color schemes" } )

return M
