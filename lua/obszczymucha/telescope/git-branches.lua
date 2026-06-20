-- luacheck: globals vim
local actions = require( "telescope.actions" )
local finders = require( "telescope.finders" )
local make_entry = require( "telescope.make_entry" )
local pickers = require( "telescope.pickers" )
local previewers = require( "telescope.previewers" )
local utils = require( "telescope.utils" )
local entry_display = require( "telescope.pickers.entry_display" )
local strings = require( "plenary.strings" )
local conf = require( "telescope.config" ).values

local M = {}

-- Git branches picker, reimplemented from telescope's builtin git_branches so
-- the current branch is marked with a colored ">" (the builtin hardcodes a
-- plain "*" and does not expose the marker for styling).
function M.git_branches( opts )
  opts = opts or {}

  vim.api.nvim_set_hl( 0, "TelescopeGitBranchesHead", { fg = "#c678dd", bold = true } )

  local format = "%(HEAD)"
    .. "%(refname)"
    .. "%(authorname)"
    .. "%(upstream:lstrip=2)"
    .. "%(committerdate:format-local:%Y/%m/%d %H:%M:%S)"

  local output = utils.get_os_command_output(
    { "git", "for-each-ref", "--perl", "--format", format, "--sort", "-authordate", opts.pattern },
    opts.cwd
  )

  local show_remote_tracking_branches = opts.show_remote_tracking_branches
  if show_remote_tracking_branches == nil then show_remote_tracking_branches = true end

  local results = {}
  local widths = {
    name = 0,
    authorname = 0,
    upstream = 0,
    committerdate = 0,
  }

  local unescape_single_quote = function( v )
    return string.gsub( v, "\\([\\'])", "%1" )
  end

  local parse_line = function( line )
    local fields = vim.split( string.sub( line, 2, -2 ), "''" )
    local entry = {
      head = fields[ 1 ],
      refname = unescape_single_quote( fields[ 2 ] ),
      authorname = unescape_single_quote( fields[ 3 ] ),
      upstream = unescape_single_quote( fields[ 4 ] ),
      committerdate = fields[ 5 ],
    }

    local prefix
    if vim.startswith( entry.refname, "refs/remotes/" ) then
      if show_remote_tracking_branches then
        prefix = "refs/remotes/"
      else
        return
      end
    elseif vim.startswith( entry.refname, "refs/heads/" ) then
      prefix = "refs/heads/"
    else
      return
    end

    local index = 1
    if entry.head ~= "*" then
      index = #results + 1
    end

    entry.name = string.sub( entry.refname, string.len( prefix ) + 1 )
    for key, value in pairs( widths ) do
      widths[ key ] = math.max( value, strings.strdisplaywidth( entry[ key ] or "" ) )
    end
    if string.len( entry.upstream ) > 0 then
      widths.upstream_indicator = 2
    end

    table.insert( results, index, entry )
  end

  for _, line in ipairs( output ) do
    parse_line( line )
  end

  if #results == 0 then
    return
  end

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 1 },
      { width = widths.name },
      { width = widths.authorname },
      { width = widths.upstream_indicator },
      { width = widths.upstream },
      { width = widths.committerdate },
    },
  }

  local make_display = function( entry )
    local marker = entry.head == "*" and { ">", "TelescopeGitBranchesHead" } or { " " }
    return displayer {
      marker,
      { entry.name, "TelescopeResultsIdentifier" },
      { entry.authorname },
      { string.len( entry.upstream ) > 0 and "=>" or "" },
      { entry.upstream, "TelescopeResultsIdentifier" },
      { entry.committerdate },
    }
  end

  pickers
    .new( opts, {
      prompt_title = "Git Branches",
      finder = finders.new_table {
        results = results,
        entry_maker = function( entry )
          entry.value = entry.name
          entry.ordinal = entry.name
          entry.display = make_display
          return make_entry.set_default_entry_mt( entry, opts )
        end,
      },
      previewer = previewers.git_branch_log.new( opts ),
      sorter = conf.file_sorter( opts ),
      attach_mappings = function( _, map )
        actions.select_default:replace( actions.git_checkout )
        map( { "i", "n" }, "<c-t>", actions.git_track_branch )
        map( { "i", "n" }, "<c-r>", actions.git_rebase_branch )
        map( { "i", "n" }, "<c-a>", actions.git_create_branch )
        map( { "i", "n" }, "<c-s>", actions.git_switch_branch )
        map( { "i", "n" }, "<c-d>", actions.git_delete_branch )
        map( { "i", "n" }, "<c-y>", actions.git_merge_branch )
        return true
      end,
    } )
    :find()
end

return M
