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
      -- build = "npm install -g mcp-hub@latest",
      build = 'bundled_build.lua',
      config = function()
        require( "mcphub" ).setup( {
          use_bundled_binary = true
        } )
      end
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
          dir_to_save = vim.fn.stdpath( "data" ) .. "/codecompanion-history"
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
      display = {
        action_palette = {
          provider = "telescope",
          opts = {
            show_default_actions = false,
            show_default_prompt_library = false
          }
        },
      },
      adapters = {
        genai_studio = function()
          return require( "codecompanion.adapters" ).extend( "openai_compatible", {
            env = {
              url = "https://api.studio.genai.cba",
              api_key = os.getenv( "GENAI_API_KEY" )
            },
            schema = {
              model = {
                default = "bedrock-claude-3-7-sonnet"
              }
            }
          } )
        end
      },
      strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "claude-3.7-sonnet"
          }
          --adapter = "genai_studio"
        },
        inline = {
          adapter = {
            name = "copilot",
            model = "claude-3.7-sonnet"
          }
          -- adapter = "genai_studio"
        }
      },
      prompt_library = require( "obszczymucha.codecompanion.prompt-library" )
    } )
  end,
  init = function()
    vim.cmd( [[cab cc CodeCompanion]] )
    local map = vim.keymap.set
    map( "n", "<leader>gw", "<cmd>CodeCompanionActions<CR>" )
  end,
  lazy = false
}
