local M = {}

local pickers = require( "telescope.pickers" )
local finders = require( "telescope.finders" )
local make_entry = require( "telescope.make_entry" )
local conf = require( "telescope.config" ).values
local actions = require( "telescope.actions" )
local multigrep_core = require( "obszczymucha.telescope.multigrep_core" )

M.generate_multigrep_command = multigrep_core.generate_multigrep_command

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
    attach_mappings = function( _, map )
      map( "i", "<CR>", function( prompt_bufnr )
        local result = actions.select_default( prompt_bufnr )
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
