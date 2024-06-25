return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify"
  },
  config = function()
    require( "noice" ).setup( {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          [ "vim.lsp.util.convert_input_to_markdown_lines" ] = true,
          [ "vim.lsp.util.stylize_markdown" ] = true,
          [ "cmp.entry.get_documentation" ] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        --command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      cmdline = {
        format = {
          cmdline = {
            title = "",
            icon = ">"
          },
          search_down = {
            icon = "/"
          },
          search_up = {
            icon = "?"
          }
        }
      },
      views = {
        cmdline_popup = {
          position = {
            row = "90%",
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = "75%",
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
    } )

    require( "telescope" ).load_extension( "noice" )
  end
}
