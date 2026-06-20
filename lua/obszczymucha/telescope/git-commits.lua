-- luacheck: globals vim
local entry_display = require( "telescope.pickers.entry_display" )
local make_entry = require( "telescope.make_entry" )
local builtin = require( "telescope.builtin" )

local M = {}

-- Git commits picker that lists all commits (--all) and marks the commit at
-- the current HEAD with a colored ">" in a dedicated column.
function M.git_commits( opts )
  opts = opts or {}

  vim.api.nvim_set_hl( 0, "TelescopeGitCommitsHead", { fg = "#c678dd", bold = true } )

  local head = vim.fn.systemlist( "git rev-parse HEAD" )[ 1 ] or ""

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 1 },
      { width = 8 },
      { remaining = true },
    },
  }

  local make_display = function( entry )
    local marker = entry.is_head and { ">", "TelescopeGitCommitsHead" } or { " " }
    return displayer {
      marker,
      { entry.value, "TelescopeResultsIdentifier" },
      entry.msg,
    }
  end

  local entry_maker = function( line )
    if line == "" then return nil end

    local sha, msg = string.match( line, "([^ ]+) (.+)" )
    if not msg then
      sha = line
      msg = "<empty commit message>"
    end

    return make_entry.set_default_entry_mt( {
      value = sha,
      ordinal = sha .. " " .. msg,
      msg = msg,
      is_head = vim.startswith( head, sha ),
      display = make_display,
    }, {} )
  end

  opts.git_command = opts.git_command or {
    "git", "log", "--all",
    "--pretty=oneline", "--abbrev-commit", "--", ".",
  }
  opts.entry_maker = entry_maker

  builtin.git_commits( opts )
end

return M
