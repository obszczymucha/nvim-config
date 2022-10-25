local g = vim.g
local telescope = require( "telescope.builtin" )
local previewers = require( "telescope.previewers" )
local M = {}

local options = {
  layout_strategy = "vertical",
  layout_config = {
    preview_cutoff = 1
  },
  attach_mappings = function( _, map )
    map( "i", "<A-j>", function( _prompt_bufnr )
      require( "telescope.actions" ).move_selection_next( _prompt_bufnr )
    end )

    map( "i", "<A-k>", function( _prompt_bufnr )
      require( "telescope.actions" ).move_selection_previous( _prompt_bufnr )
    end )

    return true
  end
}

require( "telescope" ).setup {
  defaults = {
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new
  }
}

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

return M
