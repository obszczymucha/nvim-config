local M = {}

local state = require( "obszczymucha.state.bash" )
state.hooked_buffers = state.hooked_buffers or {}

function M.is_hooked( bufname )
  for _, name in pairs( state.hooked_buffers ) do
    if name == bufname then return true end
  end

  return false
end

local function is_buffer_visible( bufnr )
  for _, win in ipairs( vim.api.nvim_list_wins() ) do
    if vim.api.nvim_win_get_buf( win ) == bufnr then return true end
  end

  return false
end

local function create_buffer( name )
  local bufnr = vim.api.nvim_create_buf( false, true )

  vim.api.nvim_buf_set_name( bufnr, name )
  vim.api.nvim_set_option_value( 'buftype', 'nofile', { buf = bufnr } )
  vim.api.nvim_set_option_value( 'swapfile', false, { buf = bufnr } )

  local current_win = vim.api.nvim_get_current_win()

  vim.cmd( "vsplit" )
  local new_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf( new_win, bufnr )
  vim.api.nvim_set_current_win( current_win )

  return bufnr
end

local function show_buffer( bufnr )
  local current_win = vim.api.nvim_get_current_win()

  vim.cmd( "vsplit" )
  local new_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf( new_win, bufnr )

  vim.api.nvim_set_current_win( current_win )
end

function M.hook_debug( bufname )
  if not state.debug_bufno or not vim.api.nvim_buf_is_valid( state.debug_bufno ) then
    state.debug_bufno = create_buffer( "bash-debug" )
  elseif not is_buffer_visible( state.debug_bufno ) then
    show_buffer( state.debug_bufno )
  end

  if M.is_hooked( bufname ) then return end

  state.hooked_buffers[ bufname ] = state.debug_bufno

  local augroup = vim.api.nvim_create_augroup( "bash-debug", { clear = true } )
  vim.api.nvim_create_autocmd( "BufWritePost", {
    group = augroup,
    pattern = bufname,
    callback = function()
      vim.schedule( function()
        vim.api.nvim_buf_set_lines( state.debug_bufno, 0, -1, false, {} )

        local job_id = vim.fn.jobstart( bufname, {
          on_exit = function( _, exit_code )
            if exit_code ~= 0 then vim.notify( "script error: " .. exit_code ) end
          end,
          stdout_buffered = true,
          stderr_buffered = true,
          on_stdout = function( _, data )
            if data then
              local lines = vim.tbl_filter( function( line ) return line ~= "" end, data )
              if #lines > 0 then
                vim.schedule( function()
                  local line_count = vim.api.nvim_buf_line_count( state.debug_bufno )
                  local first_line = vim.api.nvim_buf_get_lines( state.debug_bufno, 0, 1, false )[ 1 ]
                  if line_count == 1 and first_line == "" then
                    vim.api.nvim_buf_set_lines( state.debug_bufno, 0, -1, false, lines )
                  else
                    vim.api.nvim_buf_set_lines( state.debug_bufno, line_count, -1, false, lines )
                  end
                end )
              end
            end
          end,
          on_stderr = function( _, data )
            if data then
              local lines = vim.tbl_filter( function( line ) return line ~= "" end, data )
              if #lines > 0 then
                vim.schedule( function()
                  local line_count = vim.api.nvim_buf_line_count( state.debug_bufno )
                  local first_line = vim.api.nvim_buf_get_lines( state.debug_bufno, 0, 1, false )[ 1 ]
                  if line_count == 1 and first_line == "" then
                    vim.api.nvim_buf_set_lines( state.debug_bufno, 0, -1, false, lines )
                  else
                    vim.api.nvim_buf_set_lines( state.debug_bufno, line_count, -1, false, lines )
                  end
                end )
              end
            end
          end,
        } )

        if job_id <= 0 then
          vim.notify( "Failed to run the script.", vim.log.levels.WARN )
        end
      end )
    end
  } )
end

return M
