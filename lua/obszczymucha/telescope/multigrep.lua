local M = {}

local pickers = require( "telescope.pickers" )
local finders = require( "telescope.finders" )
local make_entry = require( "telescope.make_entry" )
local conf = require( "telescope.config" ).values
local actions = require( "telescope.actions" )
local action_state = require( "telescope.actions.state" )
local multigrep_core = require( "obszczymucha.telescope.multigrep_core" )

M.generate_multigrep_command = multigrep_core.generate_multigrep_command

local function prevent_duplicate_searches( picker, command_generator )
  local original_on_lines = picker._on_lines
  local last_command_str = nil

  picker._on_lines = function( ... )
    local prompt = picker:_get_prompt()
    local command = command_generator( prompt )
    local command_str = vim.inspect( command )

    if last_command_str ~= command_str then
      last_command_str = command_str
      original_on_lines( ... )
    end
  end
end

function M.live_multigrep( search_term )
  local opts = {}
  opts.cwd = opts.cwd or vim.fn.getcwd()

  local finder = finders.new_async_job {
    command_generator = M.generate_multigrep_command,
    entry_maker = make_entry.gen_from_vimgrep( opts ),
    cwd = opts.cwd
  }

  local picker_opts = {
    debounce = 100,
    prompt_title = "Live Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer( opts ),
    sorter = require( "telescope.sorters" ).empty(),
    attach_mappings = function( prompt_bufnr, map )
      local picker = require( "telescope.actions.state" ).get_current_picker( prompt_bufnr )
      prevent_duplicate_searches( picker, M.generate_multigrep_command )

      map( "i", "<CR>", function( bufnr )
        local selection = action_state.get_selected_entry()
        if not selection then return end

        local result = actions.select_default( bufnr )
        vim.schedule( function() vim.cmd( "normal! zz" ) end )
        return result
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
