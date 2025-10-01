return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require( "lualine" )

    ---@diagnostic disable-next-line: different-requires
    local is_blank = require( "obszczymucha.common" ).is_blank

    local diagnostics = {
      "diagnostics",

      -- Table of diagnostic sources, available sources are:
      --   "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic", "coc", "ale", "vim_lsp".
      -- or a function that returns a table as such:
      --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
      sources = { "nvim_workspace_diagnostic" },

      -- Displays diagnostics for the defined severity types
      sections = { "error", "warn", "info", "hint" },

      diagnostics_color = {
        -- Same values as the general color option can be used here.
        error = "DiagnosticError", -- Changes diagnostics' error color.
        warn  = "DiagnosticWarn",  -- Changes diagnostics' warn color.
        info  = "DiagnosticInfo",  -- Changes diagnostics' info color.
        hint  = "DiagnosticHint",  -- Changes diagnostics' hint color.
      },
      symbols = { error = "E", warn = "W", info = "I", hint = "H" },
      colored = true,           -- Displays diagnostics status in color if set to true.
      update_in_insert = false, -- Update diagnostics in insert mode.
      always_visible = false,   -- Show diagnostics even if there are none.
    }

    ---@diagnostic disable: unused-local
    local config = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "|", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {},
        lualine_b = { "branch", "diff", diagnostics },
        lualine_c = {},
        --lualine_x = { "filetype", "encoding", { "fileformat", icons_enabled = false } },
        lualine_x = {},
        lualine_y = { },
        lualine_z = { { "location", padding = { left = 1, right = 1 } } }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
      },
      winbar = {},
      tabline = {},
      inactive_winbar = {},
      extensions = {}
    }

    local function ins_left_a( component )
      table.insert( config.sections.lualine_a, component )
    end

    local function ins_left_c( component )
      table.insert( config.sections.lualine_c, component )
    end

    local function add_x( component )
      table.insert( config.sections.lualine_x, component )
    end
    local function add_y( component )
      table.insert( config.sections.lualine_y, component )
    end

    -- local function scala_diagnostics()
    --   if vim.bo.filetype == "scala" then
    --     local status = vim.g[ "metals_status" ]
    --     return not is_blank( status ) and status .. " |" or ""
    --   else
    --     return ""
    --   end
    -- end

    local function mode_color()
      local mode = require( 'lualine.utils.mode' ).get_mode()
      local hl = vim.api.nvim_get_hl( 0, { name = 'lualine_a_' .. mode } )
      if hl.bg then return { fg = string.format( '#%06x', hl.bg ) } end

      return nil
    end

    local filetype_separator = {
      function()
        if vim.bo.ft and vim.bo.ft ~= "" then
          return " | "
        else
          return ""
        end
      end,
      color = mode_color,
      padding = { left = 0, right = 0 }
    }

    local no_padding = { left = 0, right = 0 }

    ins_left_a {
      "mode",
      fmt = function( str )
        return str:sub( 1, 1 )
      end
    }
    ins_left_c "filename"

    -- add_y { scala_diagnostics }
    add_x { "filetype", padding = no_padding }
    add_y( filetype_separator )
    add_y { "encoding", padding = { left = 0, right = 1 } }
    add_y { function() return "[" end, padding = no_padding }
    add_y { "fileformat", icons_enabled = false, padding = no_padding }
    add_y { function() return "]" end, padding = { left = 0, right = 0 } }
    add_y { "progress", padding = { left = 1, right = 0 } }
    add_y { require( "recorder" ).displaySlots }

    table.insert( config.sections.lualine_z, { require( "recorder" ).recordingStatus } )

    lualine.setup( config )
  end
}
