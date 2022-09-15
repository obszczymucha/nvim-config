local api = vim.api

-- completion related settings
-- This is similiar to what I use
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
  },
  snippet = {
    expand = function(args)
      -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- I use tabs... some say you should stick to ins-completion but this is just here as an example
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
})

----------------------------------
-- LSP Setup ---------------------
----------------------------------
local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
local capabilities = vim.lsp.protocol.make_client_capabilities()
metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Debug settings if you're using nvim-dap
--local dap = require("dap")

--dap.configurations.scala = {
  --{
    --type = "scala",
    --request = "launch",
    --name = "RunOrTest",
    --metals = {
      --runType = "runOrTestFile",
      ----args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    --},
  --},
  --{
    --type = "scala",
    --request = "launch",
    --name = "Test Target",
    --metals = {
      --runType = "testTarget",
    --},
  --},
--}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

--map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
--map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
--map("n", "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
--map("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
--map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
--map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
--map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
--map("n", "<leader>ws", '<cmd>lua require"metals".hover_worksheet()<CR>')
--map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]]) -- all workspace diagnostics
--map("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]) -- all workspace errors
--map("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]) -- all workspace warnings
--map("n", "<leader>d", "<cmd>lua vim.diagnostic.setloclist()<CR>") -- buffer diagnostics only
