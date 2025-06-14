return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
    "ravitemer/codecompanion-history.nvim",
    {
      "ravitemer/mcphub.nvim",
      cmd = "MCPHub",
      build = "npm install -g mcp-hub@latest",
      config = true
    },
    {
      "Davidyz/VectorCode",
      version = "*",
      build = "pipx upgrade vectorcode",
      dependencies = { "nvim-lua/plenary.nvim" }
    }
  },
  opts = {
    extensions = {
      history = {
        enabled = true,
        opts = {
          keymap = "gh",
          auto_generate_title = true,
          continue_last_chat = false,
          delete_on_clearing_chat = false,
          picker = "snacks",
          enable_logging = false,
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history"
        }
      },
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true
        }
      },
      vectorcode = {
        opts = {
          add_tool = true
        }
      }
    }
  },
  config = function()
    require( "codecompanion" ).setup( {
      strategies = {
        chat = {
          adapter = "copilot"
        },
        inline = {
          adapter = "copilot"
        }
      }
    } )
  end,
  init = function()
    vim.cmd([[cab cc CodeCompanion]])
    local map = vim.keymap.set
    map( "n", "<leader>fw", "<cmd>CodeCompanionActions<CR>" )
  end,
  lazy = false
}
