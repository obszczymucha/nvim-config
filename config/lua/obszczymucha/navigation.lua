local M = {}
local config = require( "obszczymucha.user-config" )

-- I position the current line either at the top, top 14%, bottom 14% or bottom.
-- Call me with 'k' or 'j'.
function M.readable_pos( direction )
  local lines = vim.fn.winheight( 0 )
  local relative_positions = { 0, 0.14, 1 - 0.14, 1 }
  local positions = {}

  for _, relative_pos in ipairs( relative_positions ) do
    table.insert( positions, math.floor( lines * relative_pos ) )
  end

  local current = vim.fn.line( "." ) - vim.fn.line( "w0" )
  local target, key

  if direction == "j" then
    if current == lines - 1 then return end

    for _, pos in ipairs( positions ) do
      if current < pos then
        target = pos
        break
      end
    end

    key = "<C-y>"
  else
    if current == 0 then return end

    for i = #positions, 1, -1 do
      if current > positions[ i ] then
        target = positions[ i ]
        break
      end
    end

    key = "<C-e>"
  end

  if not target then return end

  local delta = math.abs( target - current )
  key = vim.api.nvim_replace_termcodes( key, true, false, true )
  local combo = string.format( "call smoothie#do('%s%s')", delta, key )
  vim.cmd( combo )
end

function M.jump_to_mark_and_center()
  local mark = vim.fn.getchar()
  if type( mark ) == "number" then mark = string.char( mark ) end

  local success = pcall( function()
    vim.cmd( "normal! '" .. mark )
  end )

  if success then
    vim.cmd( "normal! zz" )
  else
    vim.notify( string.format( "Mapping %s not set.", mark ) )
  end
end

function M.jump_count( key )
  local count = vim.v.count

  if count > 1 then
    vim.cmd( "normal! m'" )
    vim.cmd( "normal! " .. count .. key )

    if config.auto_center() then
      vim.cmd( "normal! zz" )
    end
  else
    vim.cmd( "normal! " .. key )
  end
end

---@diagnostic disable-next-line: unused-function, unused-local
local function smoothie_smart_down()
  --local row, _ = unpack( vim.api.nvim_win_get_cursor( 0 ) )
  --local middle = math.floor( vim.api.nvim_win_get_height( 0 ) / 2 )

  local line = vim.fn.line
  local current = line( "." )
  local top = line( "w0" )
  local relative = current - top + 1
  local middle = math.floor( vim.api.nvim_win_get_height( 0 ) / 2 )
  --print(string.format("middle: %s, relative: %s", middle, relative))

  if relative < middle then
    vim.cmd( [[call smoothie#do( "M" )]] )
  else
    vim.cmd( [[call smoothie#do( "\<C-d>" )]] )
  end
end

---@diagnostic disable-next-line: unused-local, unused-function
local function smoothie_smart_up()
  local line = vim.fn.line
  local current = line( "." )
  local top = line( "w0" )
  local relative = current - top + 1
  local middle = math.ceil( vim.api.nvim_win_get_height( 0 ) / 2 )

  if relative > middle then
    vim.cmd( [[call smoothie#do( "M" )]] )
  else
    vim.cmd( [[call smoothie#do( "\<C-u>" )]] )
  end
end

function M.smoothie_down()
  vim.cmd( [[call smoothie#do( "\<C-d>" )]] )
end

function M.smoothie_up()
  vim.cmd( [[call smoothie#do( "\<C-u>" )]] )
end

function M.smoothie_down2()
  vim.cmd( [[call smoothie#do( "M\<C-d>" )]] )
end

function M.smoothie_up2()
  vim.cmd( [[call smoothie#do( "M\<C-u>" )]] )
end

function M.smoothie_page_down()
  vim.cmd( [[call smoothie#do( "\<C-f>" )]] )
end

function M.smoothie_page_up()
  vim.cmd( [[call smoothie#do( "\<C-b>" )]] )
end

function M.smart_search_result( template )
  local ok, result = pcall( vim.api.nvim_command, string.format( template, config.auto_center() and "zz" or "" ) )

  if not ok then
    local pattern = "E486: "
    local index = string.find( result, pattern )

    if index then
      local message = string.sub( result, index + string.len( pattern ) )
      vim.notify( message, vim.log.levels.INFO )
    else
      vim.notify( result, vim.log.levels.ERROR )
    end
  end
end

function M.go_to_context()
  local context = prequirev( "treesitter-context" )
  if not context then return end

  context.go_to_context( vim.v.count1 )
end

return M
