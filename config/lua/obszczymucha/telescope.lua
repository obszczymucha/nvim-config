local g = vim.g
local telescope = require( "telescope.builtin" )
local previewers = require( "telescope.previewers" )
local M = {}

M.layout_strategy = 'vertical'

require( "telescope" ).setup {
  defaults = {
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new
  }
}

local function no_ignore_wrapper( f, opts, override )
  if override or g.telescope_no_ignore then
    f( opts )
  else
    f( { layout_strategy = M.layout_strategy } )
  end
end

function M.find_files( no_ignore )
  no_ignore_wrapper( telescope.find_files, { layout_strategy = M.layout_strategy, no_ignore = true, hidden = true },
    no_ignore )
end

function M.live_grep( no_ignore )
  no_ignore_wrapper( telescope.live_grep, { layout_strategy = M.layout_strategy, glob_pattern = "*" }, no_ignore )
end

return M
