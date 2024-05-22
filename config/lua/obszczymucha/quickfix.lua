local M = {}

local function remove_lines( start_line, end_line )
  local qf_list = vim.fn.getqflist()

  if #qf_list == 0 or start_line > end_line then
    return
  end

  for i = end_line, start_line, -1 do
    table.remove( qf_list, i )
  end

  vim.fn.setqflist( qf_list, "r" )

  if #qf_list > 0 then
    local safe_index = math.min( start_line, #qf_list )
    vim.cmd( tostring( safe_index ) .. "cfirst" )
    vim.cmd( "copen" )
  else
    vim.cmd( "cclose" )
  end
end

function M.remove_current_line()
  local line_no = vim.fn.line( "." )
  remove_lines( line_no, line_no )
end

function M.remove_selection()
  local start_line = vim.fn.line( "'<" )
  local end_line = vim.fn.line( "'>" )
  remove_lines( start_line, end_line )
end

return M
