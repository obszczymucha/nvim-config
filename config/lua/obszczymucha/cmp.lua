local cmp = prequire( "cmp" )
if not cmp then return end

cmp.setup {
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function( args )
      -- vim.fn[ "vsnip#anonymous" ]( args.body ) -- For `vsnip` users.
      require( 'luasnip' ).lsp_expand( args.body ) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  sources = cmp.config.sources( {
    { name = "copilot",                 group_index = 2 },
    { name = "nvim_lua",                group_index = 2 },
    { name = "nvim_lsp",                group_index = 2 },
    { name = "nvim_lsp_signature_help", group_index = 2 },
    { name = "luasnip",                 group_index = 2 },
    { name = "path",                    group_index = 2 },
  }, {
    { name = "buffer", group_index = 2 }
  } ),
  mapping = cmp.mapping.preset.insert( {
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    [ "<Tab>" ] = cmp.mapping.confirm( { select = true } ),
    [ "<CR>" ] = cmp.mapping.confirm( { select = false } ),
    [ "<S-Space" ] = cmp.mapping.complete()
  } )
}

cmp.setup.filetype( { "sql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "buffer" }
  }
} )

local luasnip = prequire( "luasnip" )
if not luasnip then return end

luasnip.config.set_config( {
  history = false,
  -- This is fucking awesome, this updates the snippets when the typing.
  updateevents = "TextChanged,TextChangedI"
} )

for _, ft_path in ipairs( vim.api.nvim_get_runtime_file( "lua/obszczymucha/snippets/*.lua", true ) ) do
  loadfile( ft_path )()
end

