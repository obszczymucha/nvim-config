local g = vim.g
local telescope = require( "telescope.builtin" )
local M = {}

local function no_ignore_wrapper( f, opts )
  if g.telescope_no_ignore then
    f( opts )
  else
    f()
  end
end

function M.find_files()
  no_ignore_wrapper( telescope.find_files, { no_ignore = true } )
end

function M.live_grep()
  no_ignore_wrapper( telescope.live_grep, { glob_pattern = "*" } )
end

return M

