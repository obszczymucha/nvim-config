-- A copy-paste of telescope's async_job_finder.lua with a little fix to avoid
-- displaying the results when the prompt is empty.
local function custom_async_job_finder( opts )
  local async_job = require "telescope._"
  local LinesPipe = require( "telescope._" ).LinesPipe
  local make_entry = require "telescope.make_entry"

  local entry_maker = opts.entry_maker or make_entry.gen_from_string( opts )

  local fn_command = function( prompt )
    local command_list = opts.command_generator( prompt )
    if command_list == nil then
      return nil
    end

    local command = table.remove( command_list, 1 )

    local res = {
      command = command,
      args = command_list,
    }

    return res
  end

  local job

  local callable = function( _, prompt, process_result, process_complete )
    if job then
      job:close( true )
    end

    local job_opts = fn_command( prompt )
    if not job_opts then
      -- FIX: Call process_complete when no command to clear results
      process_complete()
      return
    end

    local stdout = LinesPipe()

    job = async_job.spawn {
      command = job_opts.command,
      args = job_opts.args,
      cwd = job_opts.cwd or opts.cwd,
      env = job_opts.env or opts.env,
      stdout = stdout,
    }

    local line_num = 0
    for line in stdout:iter( true ) do
      line_num = line_num + 1
      local entry = entry_maker( line )
      if entry then
        entry.index = line_num
      end
      if process_result( entry ) then
        return
      end
    end

    process_complete()
  end

  return setmetatable( {
    close = function()
      if job then
        job:close( true )
      end
    end,
  }, {
    __call = callable,
  } )
end

return custom_async_job_finder

