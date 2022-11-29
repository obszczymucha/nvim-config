local g = vim.g
local telescope = require( "telescope.builtin" )
local previewers = require( "telescope.previewers" )
local actions = require( "telescope.actions" )
local M = {}

local mappings = {
  i = {
    [ "<A-j>" ] = actions.move_selection_next,
    [ "<A-k>" ] = actions.move_selection_previous,
    [ "<Esc>" ] = actions.close,
    [ "<C-u>" ] = false
  }
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
      hijack_netrw = true,
      mappings = mappings
    },
  },
}

require( "telescope" ).load_extension "file_browser"

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

function M.file_browser()
  local opts = {
    layout_config = {
      preview_width = 0.6
    }
  }

  require( "telescope" ).extensions.file_browser.file_browser( opts )
end

return M
