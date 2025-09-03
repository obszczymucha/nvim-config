local M = {}
local Popup = require( "nui.popup" )
local event = require( "nui.utils.autocmd" ).event
local state = require( "obszczymucha.state.sandbox" )

local utils = require( "obszczymucha.utils" )
local saturation, brightness = utils.saturation, utils.brightness

local purple = "#9f7fff"
local light_purple = saturation( purple, 0.6 )
local light_purple2 = saturation( purple, 0.9 )
local dark_purple = brightness( purple, 0.4 )

local colors = { "variable", purple, light_purple, light_purple2, dark_purple }
state.current_color = state.current_color or 1

local function create_popup()
  if state.popup then return end

  state.popup = Popup( {
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Sandbox ",
        top_align = "center",
      },
    },
    position = "50%",
    size = {
      width = "50%",
      height = "20%",
    },
    buf_options = {
      modifiable = true,
      readonly = false,
    },
  } )
end

function M.test2()
  local color = colors[ state.current_color ]
  local text = string.format( "[Sand]{%s}[box]{boolean}: Hello! ([%s]{%s})", color, color, color )
  vim.notify( text )
  state.current_color = state.current_color + 1
  if state.current_color > #colors then state.current_color = 1 end
end

function M.test()
  create_popup()

  if state.popup.winid and vim.api.nvim_win_is_valid( state.popup.winid ) then
    state.popup:unmount()
    return
  end

  state.popup:mount()

  local colors_module = require( "obszczymucha.colors" )
  local ns_id = vim.api.nvim_create_namespace( "SandboxHighlights" )

  local lines = {}

  for _, color in ipairs( colors ) do
    local text = string.format( "[Sand]{%s}[box]{boolean}: Hello! ([%s]{%s})", color, color, color )
    table.insert( lines, text )
  end

  vim.api.nvim_buf_set_lines( state.popup.bufnr, 0, -1, false, lines )

  local highlight_groups = colors_module.apply_colored_text( state.popup.bufnr, ns_id )

  state.popup:on( event.BufLeave, function()
    vim.api.nvim_buf_clear_namespace( state.popup.bufnr, ns_id, 0, -1 )
    for _, group in ipairs( highlight_groups ) do
      vim.api.nvim_set_hl( 0, group, {} )
    end

    state.popup:unmount()
  end, { once = true } )
end

return M
