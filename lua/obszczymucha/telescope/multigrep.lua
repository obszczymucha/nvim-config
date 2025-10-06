local M = {}

local pickers = require( "telescope.pickers" )
local make_entry = require( "telescope.make_entry" )
local conf = require( "telescope.config" ).values
local actions = require( "telescope.actions" )
local action_state = require( "telescope.actions.state" )
local core = require( "obszczymucha.telescope.multigrep_core" )
local job_finder = require( "obszczymucha.telescope.custom_job_finder" )
local state = require( "obszczymucha.state.telescope" )
local case_sensitivity = require( "obszczymucha.telescope.case-sensitivity" )
local utils = require( "telescope.utils" )

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

      -- Clear results buffer before starting new search
      if picker.results_bufnr and vim.api.nvim_buf_is_valid( picker.results_bufnr ) then
        vim.schedule( function()
          if vim.api.nvim_buf_is_valid( picker.results_bufnr ) then
            vim.api.nvim_buf_set_lines( picker.results_bufnr, 0, -1, false, {} )
          end
        end )
      end

      original_on_lines( ... )
    end
  end
end

function M.live_multigrep( search_term )
  local opts = {}
  opts.cwd = opts.cwd or vim.fn.getcwd()

  local current_search_terms = {}

  local custom_entry_maker = function( line )
    local entry = make_entry.gen_from_vimgrep( opts )( line )
    local original_display = entry.display

    -- Capture current search terms for this specific entry
    local captured_terms = vim.deepcopy( current_search_terms )

    entry.display = function( e )
      local display_str, hl = original_display( e )
      local filename = utils.path_tail( e.filename or e.value )

      -- Find where filename starts in the display string
      local filename_start = display_str:find( filename, 1, true )
      if filename_start then
        hl = hl or {}
        table.insert( hl, {
          { filename_start - 1, filename_start - 1 + #filename },
          "TelescopeFilename"
        } )
      end

      -- Find where content starts in the display string
      -- Content is stored in e.text and appears after filename:line:col:
      local content_start = nil
      if e.text then
        content_start = display_str:find( e.text, 1, true )
      end

      -- Highlight search terms in the content only
      for _, term in ipairs( captured_terms ) do
        if term and term ~= "" then
          local case_sensitive = state.case_sensitivity == "respect"
          local search_str, display_search

          if case_sensitive then
            search_str = term
            display_search = display_str
          else
            search_str = term:lower()
            display_search = display_str:lower()
          end

          local search_start = content_start or 1
          while true do
            local match_start, match_end = display_search:find( search_str, search_start, true )
            if not match_start then break end

            -- Only highlight if match is in content portion
            if not content_start or match_start >= content_start then
              hl = hl or {}
              table.insert( hl, {
                { match_start - 1, match_end },
                "TelescopeMatching"
              } )
            end

            search_start = match_end + 1
          end
        end
      end

      return display_str, hl
    end

    return entry
  end

  local function command_generator_with_term_tracking( prompt )
    -- Extract search terms from prompt
    current_search_terms = {}
    if prompt and prompt ~= "" then
      local AND_SEPARATOR = " | "
      local GLOB_SEPARATOR = "  "

      -- Clean trailing separators
      local clean = prompt
      for i = #AND_SEPARATOR, 1, -1 do
        local sep = AND_SEPARATOR:sub( 1, i )
        if clean:sub( - #sep ) == sep then
          clean = clean:sub( 1, -(#sep + 1) )
          break
        end
      end

      -- Split by AND_SEPARATOR to get all terms
      local terms = vim.split( clean, AND_SEPARATOR )
      for _, term in ipairs( terms ) do
        -- Extract search text before glob separator
        local tokens = vim.split( vim.trim( term ), GLOB_SEPARATOR )
        if tokens[ 1 ] and tokens[ 1 ] ~= "" then
          table.insert( current_search_terms, tokens[ 1 ] )
        end
      end
    end

    return core.generate_multigrep_command( prompt )
  end

  local finder = job_finder {
    command_generator = command_generator_with_term_tracking,
    entry_maker = custom_entry_maker,
    cwd = opts.cwd
  }

  local function get_prompt_title()
    local case_part = state.case_sensitivity .. " case"

    if state.show_hidden then
      case_part = case_part .. ", hidden"
    end

    return string.format( "Live Multi Grep (%s)", case_part )
  end

  local picker_opts = {
    debounce = 100,
    prompt_title = get_prompt_title(),
    finder = finder,
    previewer = conf.grep_previewer( opts ),
    sorter = require( "telescope.sorters" ).empty(),
    sorting_strategy = "ascending",
    attach_mappings = function( prompt_bufnr, map )
      local picker = require( "telescope.actions.state" ).get_current_picker( prompt_bufnr )
      prevent_duplicate_searches( picker, command_generator_with_term_tracking )

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

      map( "i", "<A-.>", function()
        state.show_hidden = not state.show_hidden
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
