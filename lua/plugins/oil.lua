local last_dir

return {
  "stevearc/oil.nvim",
  config = function()
    local oil = require( "oil" )

    local function split_below()
      vim.o.splitbelow = true
      oil.select( { horizontal = true } )
    end

    local opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      columns = { "icon" },
      keymaps = {
        [ "<M-h>" ] = split_below,
        [ "<M-l>" ] = "actions.select_vsplit",
        [ "<Esc>" ] = "actions.close",
        [ "<C-q>" ] = "actions.send_to_qflist",
        [ "<A-.>" ] = function()
          local strip = require( "obszczymucha.utils" ).front_strip
          vim.notify( strip( oil.get_current_dir(), vim.o.columns - 10 ) )
        end
      },
      view_options = {
        show_hidden = true,
        natural_sort = true,
      },
      float = {
        padding = 2,
        max_width = 60,
        max_height = 24,
        preview_split = "above"
      }
    }

    if is_macos then
      opts.keymaps[ "<Left>" ] = split_below
      opts.keymaps[ "<Right>" ] = "actions.select_vsplit"
    end

    oil.setup( opts )

    vim.api.nvim_create_autocmd( "VimEnter", {
      callback = function( data )
        if vim.fn.isdirectory( data.file ) == 1 then
          vim.schedule( function()
            vim.cmd( "bdelete" )
            oil.open_float( data.file )
          end )
        end
      end
    } )

    vim.api.nvim_create_autocmd( "User", {
      pattern = "OilEnter",
      callback = function()
        last_dir = oil.get_current_dir()
      end
    } )
  end,
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "Open current directory (float)" },
    { "+", "<cmd>Oil<CR>",         desc = "Open current directory" },
    {
      "=",
      function()
        if vim.bo.filetype == "oil" then
          vim.cmd( "close" )
        else
          vim.o.splitright = false
          vim.cmd( "vs" )
          vim.cmd( "vertical resize 40" )
          require( "oil" ).open()
        end
      end,
      desc = "Open current directory (vertical split left)"
    },
    {
      "_",
      function()
        if last_dir then
          vim.cmd( "Oil --float " .. vim.fn.fnameescape( last_dir ) )
        else
          vim.cmd( "Oil --float" )
        end
      end,
      desc = "Open last directory (float)"
    }
  },
  lazy = false
}
