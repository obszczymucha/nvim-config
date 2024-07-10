return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "L3MON4D3/LuaSnip",
        lazy = false,
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require( "luasnip.loaders.from_vscode" ).lazy_load()
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      {
        "zbirenbaum/copilot-cmp",
        lazy = false,
        config = function()
          require( "copilot_cmp" ).setup( {
            suggestion = { enabled = false },
            panel = { enabled = false },
          } )
        end
      }
    },
    config = function()
      local cmp = require( "cmp" )
      ---@diagnostic disable-next-line: redundant-parameter
      cmp.setup( {
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
          { name = "luasnip",  group_index = 2 },
          { name = "copilot",  group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          -- { name = "nvim_lsp_signature_help", group_index = 2 },
          { name = "nvim_lua", group_index = 2 },
          { name = "path",     group_index = 2 },
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
          -- <S-Space> workaround. Mapped by sending \u001b[1;5Q in Alacritty or ahk, which translates to <F26> in neovim.
          [ "<F26>" ] = cmp.mapping.complete()
        } )
      } )

      cmp.setup.filetype( { "sql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" }
        }
      } )

      local luasnip = prequirev( "luasnip" )
      if luasnip then
        luasnip.config.set_config( {
          history = false,
          -- This is fucking awesome, this updates the snippets when the typing.
          updateevents = "TextChanged,TextChangedI"
        } )

        for _, ft_path in ipairs( vim.api.nvim_get_runtime_file( "lua/obszczymucha/snippets/*.lua", true ) ) do
          loadfile( ft_path )()
        end
      end
    end
  }
}
