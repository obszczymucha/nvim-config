local g = vim.g
local telescope = prequirev( "telescope.builtin" )
if not telescope then return end

local previewers = require( "telescope.previewers" )
local actions = require( "telescope.actions" )
local file_browser_actions = require( "telescope" ).extensions.file_browser.actions
local common = require( "obszczymucha.common" )

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
    mappings = mappings
  },
  extensions = {
    file_browser = {
      --theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      display_stat = { date = false, size = true },
      hijack_netrw = true,
      mappings = file_browser_mappings
    },
  },
}

require( "telescope" ).load_extension( "file_browser" )
require( "telescope" ).load_extension( "dap" )

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

function M.noice()
  require( "telescope" ).extensions.noice.noice( options )
end

function M.notify()
  require( "telescope" ).extensions.notify.notify( options )
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

return M
