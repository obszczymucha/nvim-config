local cmp = require( "cmp" )

cmp.setup {
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function( args )
      vim.fn[ "vsnip#anonymous" ]( args.body ) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "vsnip" },
    { name = "buffer" }
  },
  mapping = cmp.mapping.preset.insert( {
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    [ "<CR>" ] = cmp.mapping.confirm( { select = true } )
  } )
}
