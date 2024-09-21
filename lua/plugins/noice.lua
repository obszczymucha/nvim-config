return {
  "folke/noice.nvim",
  version = "v4.4.7",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify"
  },
  config = function()
    require( "noice" ).setup( {
      lsp = {
        progress = {
          enabled = false,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          ---@diagnostic disable-next-line: undefined-doc-name
          --- @type NoiceFormat|string
          format = "lsp_progress",
          ---@diagnostic disable-next-line: undefined-doc-name
          --- @type NoiceFormat|string
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
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

    ---@diagnostic disable-next-line: different-requires
    require( "telescope" ).load_extension( "noice" )
  end
}
