return {
  {
    name = "Copy current file path",
    action = function()
      vim.fn.setreg( "+", vim.fn.expand( "%:p" ) )
      vim.notify( "Current file path copied" )
    end
  },
  {
    name = "Copy current file relative path",
    action = function()
      vim.fn.setreg( "+", vim.fn.expand( "%:." ) )
      vim.notify( "Current file path copied" )
    end
  },
  {
    name = "Yank current file path",
    action = function()
      vim.fn.setreg( '"', vim.fn.expand( "%:p" ) )
      vim.notify( "Current file path yanked" )
    end
  },
  {
    name = "Yank current file relative path",
    action = function()
      vim.fn.setreg( '"', vim.fn.expand( "%:." ) )
      vim.notify( "Current file path yanked" )
    end
  }
}
