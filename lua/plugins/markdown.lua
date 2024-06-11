return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn[ "mkdp#util#install" ]() end,
  config = function()
    if is_wsl then
      vim.cmd [[
        function! OpenMarkdownPreview(url)
        execute "silent !brave --app=" . a:url
        endfunction
      ]]
    else
      vim.cmd [[
        function! OpenMarkdownPreview(url)
        execute "silent !chromium --app=" . a:url
        endfunction
      ]]
    end

    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
  end
}
