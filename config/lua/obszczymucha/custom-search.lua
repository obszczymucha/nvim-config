local Input = require( "nui.input" )
local event = require( "nui.utils.autocmd" ).event

local make_input = function( title, callback )
  return Input( {
    position = {
      row = "90%",
      col = "50%"
    },
    size = {
      width = 40,
    },
    border = {
      style = "rounded",
      text = {
        top = string.format(" %s ", title ),
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Cursor:Cursor,Normal:Normal,FloatBorder:Normal,FloatTitle:Normal",
    },
  }, {
    prompt = "> ",
    on_submit = function( value )
      callback( value )
    end,
  } )
end

local M = {}

local function custom_search( pattern, dir )
  local result = vim.api.nvim_exec( [[
    try
      execute "normal! ]] .. dir .. pattern .. [[\n"
    catch
      echo v:exception
    endtry
  ]], true )

  if result ~= "" then
    local error_code, message = result:match( "(E%d+): (.*)" )

    if error_code == "E486" then
      vim.notify( message, vim.log.levels.INFO )
    else
      vim.notify( result, vim.log.levels.ERROR )
    end
  end
end

function M.forward()
  local input = make_input( "Forward Search", function( pattern ) custom_search( pattern, '/' ) end )

  input:map( "n", "<Esc>", function()
    input:unmount()
  end, { noremap = true } )

  input:map( "i", "<Esc>", function()
    input:unmount()
  end, { noremap = true } )

  input:on( event.BufLeave, function()
    input:unmount()
  end )

  input:mount()
end

function M.backward()
  local input = make_input( "Backward Search", function( pattern ) custom_search( pattern, '?' ) end )

  input:map( "n", "<Esc>", function()
    input:unmount()
  end, { noremap = true } )

  input:map( "i", "<Esc>", function()
    input:unmount()
  end, { noremap = true } )

  input:on( event.BufLeave, function()
    input:unmount()
  end )

  input:mount()
end

return M
