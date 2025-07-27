vim.opt_local.commentstring = "// %s"

local function has_clang_format()
  local handle = io.popen( "command -v clang-format" )

  if handle then
    local result = handle:read( "*a" )
    handle:close()
    return result and result:len() > 0
  end

  return false
end

if has_clang_format() then
  vim.keymap.set( "n", "<leader>F", ":%!clang-format<CR>", { desc = "Format", silent = true } )
else
  vim.defer_fn( function()
    vim.notify( "clang-format is not installed, formatting unavailable", vim.log.levels.WARN )
  end, 1500 )
end
