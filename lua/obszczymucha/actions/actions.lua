local shader_utils = require( "obszczymucha.actions.utils.shader" )
local window_utils = require( "obszczymucha.actions.utils.window" )

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
      vim.fn.setreg( "+", vim.fn.expand( "%:." ) )
      vim.notify( "Current relative file path copied." )
    end,
    score = 0
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
      vim.fn.setreg( '"', vim.fn.expand( "%:." ) )
      vim.notify( "Current relative file path yanked." )
    end,
    score = 0
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
  }
}
