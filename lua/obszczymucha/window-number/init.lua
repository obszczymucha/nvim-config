local M = {}

local state = require( "obszczymucha.state.window-number" )

vim.api.nvim_set_hl( 0, 'WindowNumberPopup', {
  fg = '#ffffff'
} )

vim.api.nvim_set_hl( 0, 'WindowNumberBorder', {
  fg = '#9370db'
} )

function M.show()
  local Popup = require( "nui.popup" )

  local windows = vim.api.nvim_list_wins()
  local active_popups = {}

  for _, win_id in ipairs( windows ) do
    if vim.api.nvim_win_is_valid( win_id ) then
      local win_config = vim.api.nvim_win_get_config( win_id )

      if win_config.relative == "" then
        local win_pos = vim.api.nvim_win_get_position( win_id )
        local win_num = vim.api.nvim_win_get_number( win_id )
        local content = " " .. win_num .. " "
        local popup_width = string.len( content )

        local popup = state.popup_cache[ win_id ]
        if not popup or not popup._.mounted then
          popup = Popup( {
            enter = false,
            focusable = false,
            relative = "editor",
            position = {
              row = win_pos[ 1 ],
              col = win_pos[ 2 ]
            },
            size = {
              width = popup_width,
              height = 1,
            },
            border = {
              style = "single",
            },
            buf_options = {
              modifiable = false,
              readonly = true,
            },
            win_options = {
              winhighlight = "Normal:WindowNumberPopup,FloatBorder:WindowNumberBorder",
            },
          } )
          state.popup_cache[ win_id ] = popup
        end

        popup:mount()

        vim.api.nvim_set_option_value( 'readonly', false, { buf = popup.bufnr } )
        vim.api.nvim_set_option_value( 'modifiable', true, { buf = popup.bufnr } )
        vim.api.nvim_buf_set_lines( popup.bufnr, 0, -1, false, { content } )
        vim.api.nvim_set_option_value( 'modifiable', false, { buf = popup.bufnr } )
        vim.api.nvim_set_option_value( 'readonly', true, { buf = popup.bufnr } )

        table.insert( active_popups, popup )
      end
    end
  end

  vim.defer_fn( function()
    for _, popup in ipairs( active_popups ) do
      if popup._.mounted then
        popup:unmount()
      end
    end
  end, 750 )
end

vim.keymap.set( "n", "<leader>w", "<cmd>lua R( 'obszczymucha.window-number' ).show()<CR>",
  { desc = "Show window numbers" } )

return M
