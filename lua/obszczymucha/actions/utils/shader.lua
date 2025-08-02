local M = {}

local function get_mainimage_preceding_comment( bufnr )
  local filetype = "gdshader"

  local function_query = [[
    (function_declaration
      name: (ident) @function_name (#eq? @function_name "mainImage")) @function
  ]]

  local ts_query = vim.treesitter.query.parse( filetype, function_query )
  local parser = vim.treesitter.get_parser( bufnr, filetype )
  if not parser then return nil end

  local tree = parser:parse()[ 1 ]
  local root = tree:root()
  local function_node = nil

  for id, node in ts_query:iter_captures( root, bufnr, 0, -1 ) do
    local name = ts_query.captures[ id ]

    if name == "function" then
      function_node = node
      break
    end
  end

  if not function_node then
    return nil
  end

  local func_start_row = function_node:range()

  local comment_query = [[
    (comment) @comment
  ]]

  local comment_ts_query = vim.treesitter.query.parse( filetype, comment_query )

  local preceding_comment = nil
  local comment_row = -1

  for _, node in comment_ts_query:iter_captures( root, bufnr, 0, -1 ) do
    local start_row, _, end_row, _ = node:range()

    if end_row == func_start_row - 1 and start_row > comment_row then
      preceding_comment = node
      comment_row = start_row
    end
  end

  if preceding_comment then
    local start_row, start_col, end_row, end_col = preceding_comment:range()
    local comment_text = vim.api.nvim_buf_get_text( bufnr, start_row, start_col, end_row, end_col, {} )
    return table.concat( comment_text, "\n" )
  end

  return nil
end

local function parse( comment )
  if not comment then return nil end

  for scene_name, filter_name in comment:gmatch( "// Reload: (.-), (.*)" ) do
    return scene_name, filter_name
  end
end

M.is_reloadable = function( bufnr )
  local filetype = vim.api.nvim_get_option_value( "filetype", { buf = bufnr } )
  if filetype ~= "gdshader" then return false end

  local comment = get_mainimage_preceding_comment( bufnr )
  local scene_name, filter_name = parse( comment )

  return scene_name and filter_name
end

function M.reload_shader()
  local bufnr = vim.api.nvim_get_current_buf()
  local comment = get_mainimage_preceding_comment( bufnr )
  local scene_name, filter_name = parse( comment )

  if not scene_name or not filter_name then return end

  local command = "source .venv/bin/activate && python reload_shader.py"

  if scene_name and filter_name then
    command = command .. " '" .. scene_name .. "' '" .. filter_name .. "'"
  end

  local job_id = vim.fn.jobstart( command, {
    on_exit = function( _, exit_code )
      vim.schedule( function()
        if exit_code == 0 then
          vim.notify( "Shader reloaded.", vim.log.levels.INFO )
        else
          vim.notify( "Failed to reload shader (exit code: " .. exit_code .. ")", vim.log.levels.ERROR )
        end
      end )
    end
  } )

  if job_id <= 0 then
    vim.notify( "Failed to start shader reload job.", vim.log.levels.ERROR )
  end

  return job_id
end

return M

