local Popup = require( "nui.popup" )
local event = require( "nui.utils.autocmd" ).event
local state = require( "obszczymucha.state.dap-repl-popup" )
local M = {}

local function create_popup()
  if state.popup then return end

  state.popup = Popup( {
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Output ",
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

  state.popup:map( "n", "<leader>dq", function()
    vim.api.nvim_win_close( state.popup.winid, true )
  end )
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
  local lines = vim.api.nvim_buf_get_lines( state.buf, 0, -1, false )
  local ns_id = vim.api.nvim_create_namespace( "LuaDebugHighlights" )

  local highlights = {
    { pattern = ".*%*%*%* FAILED %*%*%*", target = ".*",         group = "TestFailed" },
    { pattern = "^Failed:$",              target = ".*",         group = "TestFailed" },
    { pattern = " passed$",               target = "passed",     group = "TestOk" },
    { pattern = ".* passed.$",            group = "TestOk" },
    { pattern = "[^%s]-Spec",             target = "[^%s]-Spec", group = "TestingFile" },
  }

  for i, line in ipairs( lines ) do
    for _, highlight in ipairs( highlights ) do
      local start = line:find( highlight.pattern )

      if start and highlight.target then
        local hl_start = line:find( highlight.target, start )
        vim.api.nvim_buf_set_extmark( state.buf, ns_id, i - 1, hl_start - 1, {
          end_col = #line,
          hl_group = highlight.group
        } )
      elseif start then
        vim.api.nvim_buf_set_extmark( state.buf, ns_id, i - 1, start - 1, {
          end_col = #line,
          hl_group = highlight.group
        } )
      end
    end
  end
end

function M.toggle_popup()
end

function M.toggle()
  if not state.popup then
    local bufnr = vim.fn.bufnr( "dap-repl" )

    if bufnr <= 0 then
      vim.notify( "No dap repl buffer found.", vim.log.levels.WARN )
      return
    end

    state.buf = state.buf or bufnr
    create_popup()
    vim.api.nvim_create_autocmd( "TextChanged", {
      buffer = state.buf,
      callback = apply_highlights
    } )
  end

  if state.popup.winid and vim.api.nvim_win_is_valid( state.popup.winid ) then
    state.popup:unmount()
    return
  end

  apply_highlights()
  state.popup:mount()
  state.popup:on( event.BufLeave, function()
    state.popup:unmount()
  end, { once = true } )
end

setup_highlights()

return M
