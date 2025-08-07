---@diagnostic disable-next-line: unused-function, unused-local
local function create_popup()
  local Popup = require( "nui.popup" )
  local event = require( "nui.utils.autocmd" ).event

  vim.api.nvim_set_hl( 0, 'MyPopupFloat', {
    bg = '#1c1c1c', -- Darker background (adjust color to your preference)
  } )

  -- Create a popup that stays visible without focus by default
  local popup = Popup( {
    enter = false,    -- Don't focus the popup when it opens
    focusable = true, -- Allow focusing, but don't focus by default
    relative = "editor",
    position = {
      row = 1,
      col = vim.o.columns - 21
    },
    size = {
      width = 30,
      height = 3,
    },
    border = {
      style = "single",
      text = {
        top = " Notes ",
        top_align = "center",
      },
    },
    buf_options = {
      modifiable = false,
      readonly = true,
    },
    win_options = {
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      winblend = 10
    },
  } )

  -- Mount the popup
  popup:mount()

  vim.api.nvim_set_option_value( 'readonly', false, { buf = popup.bufnr } )
  vim.api.nvim_set_option_value( 'modifiable', true, { buf = popup.bufnr } )
  vim.api.nvim_buf_set_lines( popup.bufnr, 0, -1, false, { "I stay visible!" } )
  vim.api.nvim_set_option_value( 'modifiable', false, { buf = popup.bufnr } )
  vim.api.nvim_set_option_value( 'readonly', true, { buf = popup.bufnr } )

  -- Keymaps for controlling the popup
  vim.keymap.set( 'n', '<leader>sp', function()
    popup:show()
  end, { desc = "Show persistent popup" } )

  vim.keymap.set( 'n', '<leader>hp', function()
    popup:hide()
  end, { desc = "Hide persistent popup" } )

  -- New keymap to focus the popup
  vim.keymap.set( 'n', '<leader>fp', function()
    -- Get the window ID of the popup
    local win_id = popup.winid
    if win_id and vim.api.nvim_win_is_valid( win_id ) then
      -- Focus the popup window
      vim.api.nvim_set_current_win( win_id )
    end
  end, { desc = "Focus persistent popup" } )

  -- Optional: Add a keymap to return focus to the previous window
  vim.keymap.set( 'n', '<leader>bp', function()
    -- Only act if we're in the popup window
    if popup.winid == vim.api.nvim_get_current_win() then
      vim.cmd( 'wincmd p' ) -- Go to previous window
    end
  end, { desc = "Return focus from popup" } )

  -- Keep popup visible when losing focus
  popup:on( event.BufLeave, function()
    vim.schedule( function()
      if not popup._.mounted then
        popup:mount()
      end
    end )
  end )

  -- Optional: Make the popup modifiable when focused
  popup:on( event.BufEnter, function()
    if popup.bufnr == vim.api.nvim_get_current_buf() then
      vim.bo[ popup.bufnr ].modifiable = true
    end
  end )

  popup:on( event.BufLeave, function()
    if popup.bufnr == vim.api.nvim.get_current_buf() then
      vim.bo[ popup.bufnr ].modifiable = false
    end
  end )
end
