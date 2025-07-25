local g = vim.g
local telescope = prequirev( "telescope.builtin" )
if not telescope then return end

local previewers = require( "telescope.previewers" )
local actions = require( "telescope.actions" )
local file_browser_actions = require( "telescope" ).extensions.file_browser.actions
local common = require( "obszczymucha.common" )
local action_state = require( "telescope.actions.state" )
local finders = require( "telescope.finders" )
local make_entry = require( "telescope.make_entry" )
local pickers = require( "telescope.pickers" )
local conf = require( "telescope.config" ).values
local oil_dir = require( "obszczymucha.telescope.oil_dir" )

local M = {}

local mappings = {
  i = {
    [ "<A-j>" ] = actions.move_selection_next,
    [ "<A-k>" ] = actions.move_selection_previous,
    [ "<Esc>" ] = actions.close,
    [ "<C-u>" ] = false,
    [ "<C-k>" ] = actions.which_key,
    [ "<C-D>" ] = false,
    [ "<A-u>" ] = actions.preview_scrolling_up,
    [ "<A-d>" ] = actions.preview_scrolling_down
  }
}

local file_browser_mappings = {
  i = common.merge_tables( mappings, {
    [ "<A-D>" ] = file_browser_actions.remove
  } )
}

local options = {
  layout_strategy = "vertical",
  layout_config = {
    preview_cutoff = 1
  }
}

require( "telescope" ).setup {
  defaults = {
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    mappings = mappings,
    layout_strategy = "vertical",
    layout_config = {
      preview_cutoff = 1
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    file_browser = {
      --theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      display_stat = { date = false, size = true },
      hijack_netrw = true,
      mappings = file_browser_mappings
    },
    [ "ui-select" ] = {
      require( "telescope.themes" ).get_dropdown {

      }
    }
  },
  pickers = {
    live_grep = {
      sorting_strategy = "ascending"
    },
  }
}

require( "telescope" ).load_extension( "file_browser" )
require( "telescope" ).load_extension( "dap" )
require( "telescope" ).load_extension( "fzf" )
require( "telescope" ).load_extension( "ui-select" )
require( "telescope" ).load_extension( "bookmarks" )

local function no_ignore_wrapper( f, opts, override )
  if override or g.telescope_no_ignore then
    f( vim.tbl_extend( "force", options, opts ) )
  else
    f( options )
  end
end

function M.find_files( no_ignore )
  no_ignore_wrapper( telescope.find_files, { no_ignore = true, hidden = true }, no_ignore )
end

function M.live_grep( no_ignore )
  no_ignore_wrapper( telescope.live_grep, { glob_pattern = "*" }, no_ignore )
end

function M.current_buffer_fuzzy_find()
  no_ignore_wrapper( telescope.current_buffer_fuzzy_find )
end

function M.buffers()
  telescope.buffers( { layout_strategy = "vertical" } )
end

function M.help_tags()
  telescope.help_tags( { layout_strategy = "vertical" } )
end

function M.highlights()
  telescope.highlights()
end

function M.diagnostics()
  telescope.diagnostics( { layout_strategy = "vertical" } )
end

function M.lsp_dynamic_workspace_symbols()
  telescope.lsp_dynamic_workspace_symbols( { layout_strategy = "vertical", ignore_case = true } )
end

function M.file_browser()
  local opts = {
    layout_strategy = "vertical",
    layout_config = {
      preview_cutoff = 1
    },
    --layout_config = {
    --width = 0.9,
    --preview_width = 0.6
    --},
    path = "%:p:h", -- This opens current buffer's directory.
    quiet = true
  }

  require( "telescope" ).extensions.file_browser.file_browser( opts )
end

function M.resume()
  telescope.resume()
end

function M.registers()
  telescope.registers()
end

function M.git_commits()
  telescope.git_commits()
end

function M.git_branches()
  telescope.git_branches()
end

function M.quickfix_history()
  telescope.quickfixhistory()
end

function M.noice()
  require( "telescope" ).extensions.noice.noice( options )
end

function M.notify()
  local opts = options

  opts.attach_mappings = function( _, map )
    local yank_select_buf_clip = function()
      local buf_select = action_state.get_selected_entry()
      vim.fn.setreg( '+', buf_select.value.message )
      vim.notify( "Yanked (+).", vim.log.levels.INFO )
    end

    map( "i", "<A-y>", yank_select_buf_clip )
    return true
  end

  require( "telescope" ).extensions.notify.notify( opts )
end

function M.breakpoints()
  require( "telescope" ).extensions.dap.list_breakpoints( { layout_strategy = "vertical" } )
end

function M.neoclip()
  local opts = {
    layout_strategy = "vertical",
    layout_config = {
      preview_cutoff = 1,
      preview_height = 0.2,
      vertical = {
        mirror = false,
        prompt_position = "bottom"
      }
    }
  }

  require( "telescope" ).extensions.neoclip.neoclip( opts )
end

function M.live_multigrep( opts )
  opts = opts or {}
  opts.cwd = opts.cwd or vim.fn.getcwd()

  local finder = finders.new_async_job {
    command_generator = function( prompt )
      if not prompt or prompt == "" then return end

      if not prompt:find( "||" ) then
        local tokens = vim.split( prompt, "  " )
        local args = { "rg" }

        if tokens[ 1 ] then
          table.insert( args, "-e" )
          table.insert( args, tokens[ 1 ] )
        end

        for i = 2, #tokens do
          if tokens[ i ] then
            table.insert( args, "-g" )
            table.insert( args, tokens[ i ] )
          end
        end

        vim.list_extend( args, {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case"
        } )

        return args
      end

      local cmd = ""
      local piped_terms = vim.split( prompt, "||" )

      local globs = {}
      for _, term in ipairs( piped_terms ) do
        local tokens = vim.split( vim.trim( term ), "  " )
        if #tokens > 1 then
          for i = 2, #tokens do
            table.insert( globs, tokens[ i ] )
          end
        end
      end

      for i, term in ipairs( piped_terms ) do
        local term_cmd = "rg"
        local tokens = vim.split( vim.trim( term ), "  " )

        if #tokens > 0 then
          term_cmd = term_cmd .. " -e " .. vim.fn.shellescape( tokens[ 1 ] )

          if i == 1 then
            for _, glob in ipairs( globs ) do
              term_cmd = term_cmd .. " -g " .. vim.fn.shellescape( glob )
            end
          end

          term_cmd = term_cmd .. " --color=never --no-heading --with-filename --line-number --column --smart-case"
        end

        if i == 1 then
          cmd = term_cmd
        else
          cmd = cmd .. " | " .. term_cmd
        end
      end

      return { "sh", "-c", cmd }
    end,
    entry_maker = make_entry.gen_from_vimgrep( opts ),
    cwd = opts.cwd
  }

  pickers.new( opts, {
    debounce = 100,
    prompt_title = "Live Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer( opts ),
    sorter = require( "telescope.sorters" ).empty()
  } ):find()
end

function M.oil_dir()
  oil_dir.search_directories()
end

return M
