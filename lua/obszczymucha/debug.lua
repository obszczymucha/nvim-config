local Popup = require( "nui.popup" )
local event = require( "nui.utils.autocmd" ).event
local common = require( "obszczymucha.common" )
local state = require( "obszczymucha.state.debug" )

local M = {}
local buf_name = "Debug"

local function on_data_loaded( callback )
  vim.api.nvim_create_autocmd( "User", {
    group = "DebugWindowEvents",
    pattern = "DebugDataLoaded",
    callback = callback
  } )
end

local function create_buffer( callback )
  if state.buf and vim.api.nvim_buf_is_valid( state.buf ) then return end
  state.buf = common.get_buf_by_name( buf_name )

  if state.buf then
    if callback then callback() end
    return
  end

  state.buf = vim.api.nvim_create_buf( true, true )
  vim.api.nvim_buf_set_name( state.buf, buf_name )

  if callback then callback() end
end

function M.show( split_cmd, split_prefix )
  local needs_set = false
  create_buffer( function() needs_set = true end )

  local split = split_cmd or "vs"
  state.is_vertical = split == "vs"
  local prefix = split_prefix and string.format( "%s ", split_prefix ) or ""
  local width = config.debug.width or 70
  local height = config.debug.height or 12
  local size = state.is_vertical and width or height

  if not state.win or not vim.api.nvim_win_is_valid( state.win ) then
    vim.cmd( string.format( "%s%s%s#%s", prefix or "", size, split, state.buf ) )
    state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_input( "<C-W>p" )
    return
  end

  if needs_set then vim.api.nvim_win_set_buf( state.win, state.buf ) end
  vim.api.nvim_input( "<C-W>p" )
end

function M.is_visible()
  return state.win and vim.api.nvim_win_is_valid( state.win )
end

function M.hide()
  vim.api.nvim_win_close( state.win, true )
end

function M.toggle()
  if M.is_visible() then
    M.hide()
    return
  end

  M.show()
end

function M.toggle_horizontal()
  if M.is_visible() then
    M.hide()
    return
  end

  M.show( "sp", "bel" )
end

local function create_popup( title )
  if state.popup then return end

  state.popup = Popup( {
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = string.format( " %s ", title or "Debug" ),
        top_align = "center",
      },
    },
    position = "50%",
    size = {
      width = "80%",
      height = "60%",
    },
    buf_options = {
      modifiable = true,
      readonly = false,
    },
    bufnr = state.buf
  } )
end

local function remove_shell_color_syntax()
  if not state.buf then return end
  local lines = vim.api.nvim_buf_get_lines( state.buf, 0, -1, false )
  local esc = string.char( 27 )

  local function fix_color( i, line, color )
    local new_line = line:gsub( esc .. "%[1;" .. color .. "m(.+)" .. esc .. "%[0m", "%1" )

    if new_line ~= line then
      vim.api.nvim_buf_set_lines( state.buf, i - 1, i, false, { new_line } )
    end
  end

  for i, line in ipairs( lines ) do
    fix_color( i, line, 31 )
    fix_color( i, line, 32 )
  end
end

local function setup_highlights()
  vim.cmd [[
    highlight TestOk guifg=#50cf50
    highlight TestFailed guifg=#ef2020
    highlight TestWithError guifg=#9070C0
    highlight TestingFile guifg=#ffffff
  ]]
end

local function apply_highlights()
  if not state.buf then return end
  local lines = vim.api.nvim_buf_get_lines( state.buf, 0, -1, false )
  local ns_id = vim.api.nvim_create_namespace( "LuaDebugHighlights" )

  local highlights = {
    { pattern = "%.%.%. Ok$",       target = "Ok",          group = "TestOk" },
    { pattern = "^OK$",             target = "OK",          group = "TestOk" },
    { pattern = "%.%.%. ERROR$",    target = "ERROR",       group = "TestFailed" },
    { pattern = "^[0-9]+%).*",      group = "TestWithError" },
    { pattern = "Testing .*%.%.%.", group = "TestingFile" },
  }

  for i, line in ipairs( lines ) do
    for _, highlight in ipairs( highlights ) do
      local start = line:find( highlight.pattern )

      if start and highlight.target then
        local hl_start = line:find( highlight.target, start )
        vim.api.nvim_buf_add_highlight( state.buf, ns_id, highlight.group, i - 1, hl_start - 1, -1 )
      elseif start then
        vim.api.nvim_buf_add_highlight( state.buf, ns_id, highlight.group, i - 1, start - 1, -1 )
      end
    end
  end
end

function M.toggle_popup( title )
  create_buffer()
  create_popup( title )

  if state.popup.winid and vim.api.nvim_win_is_valid( state.popup.winid ) then
    state.popup:unmount()
    return
  end

  state.popup:mount()
  state.popup:on( event.BufLeave, function()
    state.popup:unmount()
  end, { once = true } )
end

function M.flip()
  M.hide()
  if state.is_vertical then
    M.toggle_horizontal()
  else
    M.toggle()
  end
end

function M.setup()
  local function cleanup()
    if state.win and vim.api.nvim_win_is_valid( state.win ) then
      vim.api.nvim_win_close( state.win, true )
      state.win = nil
    end

    if state.buf and vim.api.nvim_buf_is_valid( state.buf ) then
      vim.api.nvim_buf_delete( state.buf, { force = true } )
      state.buf = nil
    end
  end

  vim.api.nvim_create_user_command( "Dbg", function()
    cleanup()
    R( "obszczymucha.debug" ).show()
  end, { nargs = 0 } )

  vim.api.nvim_create_user_command( "Dbgh", function()
    cleanup()
    R( "obszczymucha.debug" ).show( "sp", "bel" )
  end, { nargs = 0 } )

  on_data_loaded( function()
    remove_shell_color_syntax()
    apply_highlights()
  end )

  setup_highlights()
end

---@diagnostic disable-next-line: unused-function
local function dump2( o )
  local entries = 0

  if type( o ) == 'table' then
    local s = '{'
    for k, v in pairs( o ) do
      if (entries == 0) then s = s .. " " end
      if type( k ) ~= 'number' then k = '"' .. k .. '"' end
      if (entries > 0) then s = s .. ", " end
      s = s .. '[' .. k .. '] = ' .. dump2( v )
      entries = entries + 1
    end

    if (entries > 0) then s = s .. " " end
    return s .. '}'
  else
    return tostring( o )
  end
end

local function is_buf_empty( buffer )
  local count = vim.api.nvim_buf_line_count( buffer )
  local first_line = vim.api.nvim_buf_get_lines( buffer, 0, 1, false )
  return count == 1 and first_line[ 1 ] == ""
end

function M.debug( text )
  create_buffer()

  if type( text ) == "table" then
    vim.api.nvim_buf_set_lines( state.buf, is_buf_empty( state.buf ) and 0 or -1, -1, false, text )
    return
  end

  local t = string.format( "%s", text or "nil" )

  for line in string.gmatch( t, "([^\n]+)" ) do
    vim.api.nvim_buf_set_lines( state.buf, is_buf_empty( state.buf ) and 0 or -1, -1, false, { line } )
  end
end

function M.count()
  M.clear()
  vim.api.nvim_buf_set_lines( state.buf, 0, -1, false, { tostring( vim.api.nvim_buf_line_count( state.buf ) ) } )
end

function M.clear()
  if not state.buf or not vim.api.nvim_buf_is_valid( state.buf ) then return end
  vim.api.nvim_buf_set_lines( state.buf, 0, -1, false, {} )
end

M.setup()

return M
