local M = {}

local pickers = require( "telescope.pickers" )
local make_entry = require( "telescope.make_entry" )
local conf = require( "telescope.config" ).values
local actions = require( "telescope.actions" )
local action_state = require( "telescope.actions.state" )
local core = require( "obszczymucha.telescope.multigrep_core" )
local job_finder = require( "obszczymucha.telescope.custom_job_finder" )
local state = require( "obszczymucha.telescope.state" )
local case_sensitivity = require( "obszczymucha.telescope.case-sensitivity" )

local refresh = false

local function prevent_duplicate_searches( picker, command_generator )
  local original_on_lines = picker._on_lines
  local last_command_str = nil

  picker._on_lines = function( ... )
    local prompt = picker:_get_prompt()
    local command = command_generator( prompt )
    local command_str = vim.inspect( command )

    if refresh or last_command_str ~= command_str then
      refresh = false
      last_command_str = command_str
      original_on_lines( ... )
    end
  end
end

function M.live_multigrep( search_term )
  local opts = {}
  opts.cwd = opts.cwd or vim.fn.getcwd()

  local finder = job_finder {
    command_generator = core.generate_multigrep_command,
    entry_maker = make_entry.gen_from_vimgrep( opts ),
    cwd = opts.cwd
  }

  local function get_prompt_title()
    return string.format( "Live Multi Grep (%s case)", state.case_sensitivity )
  end

  local picker_opts = {
    debounce = 100,
    prompt_title = get_prompt_title(),
    finder = finder,
    previewer = conf.grep_previewer( opts ),
    sorter = require( "telescope.sorters" ).empty(),
    attach_mappings = function( prompt_bufnr, map )
      local picker = require( "telescope.actions.state" ).get_current_picker( prompt_bufnr )
      prevent_duplicate_searches( picker, core.generate_multigrep_command )

      map( "i", "<CR>", function( bufnr )
        local selection = action_state.get_selected_entry()
        if not selection then return end

        local result = actions.select_default( bufnr )
        vim.schedule( function() vim.cmd( "normal! zz" ) end )
        return result
      end )

      map( "i", "<A-i>", function()
        state.case_sensitivity = case_sensitivity.next( state.case_sensitivity )
        local new_title = get_prompt_title()
        picker.prompt_title = new_title

        if picker.prompt_border then
          picker.prompt_border:change_title( new_title )
        end

        refresh = true
        picker:_on_lines( {} )
      end )

      return true
    end
  }

  if search_term then
    picker_opts.default_text = search_term
  end

  pickers.new( opts, picker_opts ):find()
end

return M
