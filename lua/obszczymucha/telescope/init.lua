local telescope = prequirev( "telescope.builtin" )
if not telescope then return end

local previewers = require( "telescope.previewers" )
local actions = require( "telescope.actions" )
local action_state = require( "telescope.actions.state" )
local actions_set = require( "telescope.actions.set" )
local file_browser_actions = require( "telescope" ).extensions.file_browser.actions
local common = require( "obszczymucha.common" )
local finders = require( "telescope.finders" )
local make_entry = require( "telescope.make_entry" )
local oil_dir = require( "obszczymucha.telescope.oil-dir" )
local window_utils = require( "obszczymucha.utils.window" )
local state = require( "obszczymucha.state.telescope" )

local M = {}
local g = vim.g

local options = {
  layout_strategy = "vertical",
  layout_config = {
    width = 80,
    preview_cutoff = 1,
    vertical = {
      mirror = false,
      prompt_position = "bottom"
    }
  }
}

local function select_vertical( prompt_bufnr )
  local selection = action_state.get_selected_entry()
  if not selection then return end

  local win_id = window_utils.get_last_visible_win_id()

  if win_id then
    actions.close( prompt_bufnr )
    vim.api.nvim_set_current_win( win_id )
    vim.cmd( "edit " .. (selection.path or selection.filename or selection.value) )
  else
    actions.select_vertical( prompt_bufnr )
  end

  vim.schedule( function() vim.cmd( "normal! zz" ) end )
end

local function select_horizontal( prompt_bufnr )
  local selection = action_state.get_selected_entry()
  if not selection then return end

  actions_set.edit( prompt_bufnr, "belowright new" )
end

local function safe_select_default( prompt_bufnr )
  local selection = action_state.get_selected_entry()
  if selection then
    actions.select_default( prompt_bufnr )
  end
end

local mappings = {
  i = {
    [ "<CR>" ] = safe_select_default,
    [ "<A-j>" ] = actions.move_selection_next,
    [ "<A-k>" ] = actions.move_selection_previous,
    [ "<Esc>" ] = actions.close,
    [ "<C-u>" ] = false,
    [ "<C-k>" ] = actions.which_key,
    [ "<C-D>" ] = false,
    [ "<A-U>" ] = actions.preview_scrolling_up,
    [ "<A-D>" ] = actions.preview_scrolling_down,
    [ "<A-l>" ] = select_vertical,
    [ "<A-h>" ] = select_horizontal,
    [ "<M-q>" ] = actions.close,
    [ "<A-b>" ] = function()
      vim.cmd( "normal! b" )
    end,
    [ "<A-w>" ] = function()
      vim.cmd( "normal! w" )
    end,
    [ "<A-d>" ] = function()
      vim.cmd( "normal! dw" )
    end,
    [ "<A-u>" ] = function()
      vim.cmd( "normal! u" )
    end
  }
}


if is_macos then
  mappings.i[ "<Left>" ] = select_horizontal
  mappings.i[ "<Right>" ] = select_vertical
end

local function get_find_command()
  local find_command = { "fd", "--type", "f", "--color", "never" }

  if state.show_hidden then
    table.insert( find_command, "--hidden" )
    table.insert( find_command, "--no-ignore" )
  end

  return find_command
end

local function toggle_hidden_files( prompt_bufnr )
  local current_picker = action_state.get_current_picker( prompt_bufnr )
  state.show_hidden = not state.show_hidden

  local new_finder = finders.new_oneshot_job(
    get_find_command(),
    { entry_maker = make_entry.gen_from_file( {} ) }
  )

  current_picker:refresh( new_finder, { reset_prompt = false } )
end

local file_browser_mappings = {
  i = common.merge_tables( mappings, {
    [ "<A-D>" ] = file_browser_actions.remove
  } )
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

function M.find_files()
  local opts = vim.tbl_extend( "force", options, {
    attach_mappings = function( _, map )
      for mode, mode_mappings in pairs( mappings ) do
        for key, func in pairs( mode_mappings ) do
          map( mode, key, func )
        end
      end

      if is_macos then
        map( "i", "<M-.>", toggle_hidden_files )
      else
        map( "i", "<A-.>", toggle_hidden_files )
      end

      return true
    end,
    finder = finders.new_oneshot_job(
      get_find_command(),
      { entry_maker = make_entry.gen_from_file( {} ) }
    )
  } )

  require( "telescope.pickers" ).new( opts, {
    prompt_title = "Find Files",
    finder = opts.finder,
    sorter = require( "telescope.config" ).values.file_sorter( opts ),
    previewer = require( "telescope.config" ).values.file_previewer( opts ),
    attach_mappings = opts.attach_mappings,
  } ):find()
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
  local opts = vim.tbl_extend( "force", options, {
    attach_mappings = function( _ )
      local yank_select_buf_clip = function( prompt_bufnr )
        local buf_select = action_state.get_selected_entry()
        vim.fn.setreg( '"', buf_select.value )
        vim.notify( "Yanked.", vim.log.levels.INFO )
        actions.close( prompt_bufnr )
      end

      actions.select_default:replace( yank_select_buf_clip )

      return true
    end
  } )

  telescope.highlights( opts )
end

function M.diagnostics()
  local opts = vim.tbl_extend( "force", options, {
    attach_mappings = function( _, map )
      local yank_select_buf_clip = function()
        local buf_select = action_state.get_selected_entry()
        local entry = buf_select.value
        local position = entry.lnum .. ":" .. entry.col
        local type = entry.type
        local message = entry.text
        local filename = entry.filename
        local content =
            "Position: " .. position .. "\n" ..
            "Type: " .. type .. "\n" ..
            "Message: " .. message .. "\n" ..
            "File: " .. filename
        vim.fn.setreg( '+', content )
        vim.notify( "Copied (+).", vim.log.levels.INFO )
      end

      map( "i", "<A-y>", yank_select_buf_clip )

      return true
    end
  } )

  telescope.diagnostics( opts )
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
    path = "%:p:h",
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
  local opts = vim.tbl_extend( "force", options, {
    attach_mappings = function( _, map )
      local yank_select_buf_clip = function()
        local buf_select = action_state.get_selected_entry()
        vim.fn.setreg( '+', buf_select.value.message )
        vim.notify( "Copied (+).", vim.log.levels.INFO )
      end

      map( "i", "<A-y>", yank_select_buf_clip )

      return true
    end
  } )

  require( "telescope" ).extensions.notify.notify( opts )
end

function M.breakpoints()
  require( "telescope" ).extensions.dap.list_breakpoints( { layout_strategy = "vertical" } )
end

function M.neoclip()
  local opts = {
    layout_strategy = "vertical",
    layout_config = {
      width = 70,
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

function M.oil_dir()
  oil_dir.search_directories()
end

return M
