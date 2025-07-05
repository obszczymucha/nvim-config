local M = {}

function M.organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name( 0 ) },
    title = ""
  }

  vim.lsp.buf_request( 0, "workspace/executeCommand", params )
end

return M
