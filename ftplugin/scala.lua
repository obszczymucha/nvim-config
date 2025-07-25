local dap = prequirev( "dap" )

local function is_dap_attached()
  if not dap then return false end
  local session = dap.session()

  return session and session.initialized and true or false
end

vim.api.nvim_create_user_command( "DapAttachRemote", function( data )
  if not dap then
    vim.notify( "DAP is not configured.", vim.log.levels.WARN )
    return
  end

  if is_dap_attached() then
    vim.notify( "DAP is already attached.", vim.log.levels.WARN )
    return
  end

  local port = data and data.args and tonumber( data.args ) or 5005

  dap.listeners.after.event_initialized[ "java" ] = function()
    vim.notify( string.format( "DAP attached on port %s.", port ), vim.log.levels.INFO )
    dap.listeners.after.event_initialized[ "java" ] = nil
  end

  dap.run( {
    type = "scala",
    request = "attach",
    name = "Remote Java Debugging",
    hostName = "127.0.0.1",
    port = port
  } )
end, { nargs = "?" } )
