local shader_utils = require( "obszczymucha.actions.utils.shader" )
local window_utils = require( "obszczymucha.actions.utils.window" )
local naming_conventions = require( "obszczymucha.actions.utils.naming-conventions" )
local file_utils = require( "obszczymucha.actions.utils.file" )
local config = require( "obszczymucha.user-config" )

return {
  {
    name = "Copy current file path",
    action = function()
      vim.fn.setreg( "+", vim.fn.expand( "%:p" ) )
      vim.notify( "Current file path copied." )
    end
  },
  {
    name = "Copy current file relative path",
    action = function()
      local rel_path = file_utils.get_relative_path()

      if rel_path then
        vim.fn.setreg( "+", rel_path )
        vim.notify( "Current relative file path copied." )
      else
        vim.notify( "File is not within current working directory.", vim.log.levels.WARN )
      end
    end,
    score = 100
  },
  {
    name = "Yank current file path",
    action = function()
      vim.fn.setreg( '"', vim.fn.expand( "%:p" ) )
      vim.notify( "Current file path yanked." )
    end
  },
  {
    name = "Yank current file relative path",
    action = function()
      local rel_path = file_utils.get_relative_path()

      if rel_path then
        vim.fn.setreg( '"', rel_path )
        vim.notify( "Current relative file path yanked." )
      else
        vim.notify( "File is not within current working directory.", vim.log.levels.WARN )
      end
    end,
    score = 100
  },
  {
    name = "Hook shader reload",
    action = function()
      local current_buffer = vim.api.nvim_get_current_buf()
      local augroup_name = "ShaderReloadHook" .. current_buffer

      vim.api.nvim_create_augroup( augroup_name, { clear = true } )
      vim.api.nvim_create_autocmd( "BufWritePost", {
        group = augroup_name,
        buffer = current_buffer,
        callback = function() shader_utils.reload_shader() end
      } )

      vim.notify( "Shader reload hooked.", vim.log.levels.INFO )
    end,
    filetypes = { "gdshader" },
    condition = function()
      return shader_utils.is_reloadable( vim.api.nvim_get_current_buf() )
    end
  },
  {
    name = "Reload shader",
    action = function() shader_utils.reload_shader() end,
    filetypes = { "gdshader" },
    condition = function()
      return shader_utils.is_reloadable( vim.api.nvim_get_current_buf() )
    end
  },
  {
    name = "Flip horizontally",
    action = function() vim.cmd( "wincmd J" ) end,
    condition = function() return window_utils.count_visible_windows() > 1 end
  },
  {
    name = "Flip vertically",
    action = function() vim.cmd( "wincmd L" ) end,
    condition = function() return window_utils.count_visible_windows() > 1 end
  },
  {
    name = "To snake case",
    action = function() naming_conventions.to_snake_case() end,
    condition = naming_conventions.is_camel_case,
    score = 10
  },
  {
    name = "To Pascal case",
    action = function() naming_conventions.to_pascal_case() end,
    condition = naming_conventions.is_snake_case,
    score = 10
  },
  {
    name = "Toggle auto-center",
    action = function() config.toggle_auto_center() end,
  },
  {
    name = "Toggle alpha nrformats",
    action = function() config.toggle_alpha_nrformats() end,
  },
  {
    name = "Browse highlight groups",
    action = function() require( "obszczymucha.telescope" ).highlights() end
  },
  {
    name = "Reset auto-update",
    action = function()
      config.set_last_update_timestamp()
      vim.notify("[Auto-update]{purple} reset.")
    end
  }
}
