-- Optimized multigrep command generation using ugrep
local M = {}

function M.generate_multigrep_command( prompt )
  if not prompt or prompt == "" then
    return { "ugrep", ".", "-r", "--ignore-files", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column-number" }
  end

  if prompt:find( "||" ) then
    local piped_terms = vim.split( prompt, "||" )
    local globs = {}
    local search_terms = {}

    for _, term in ipairs( piped_terms ) do
      local tokens = vim.split( vim.trim( term ), "  " )

      if tokens[ 1 ] then
        table.insert( search_terms, tokens[ 1 ] )
      end

      if #tokens > 1 then
        for i = 2, #tokens do
          if tokens[ i ] then
            table.insert( globs, tokens[ i ] )
          end
        end
      end
    end

    if #search_terms > 0 then
      local args = { "ugrep" }

      local pattern = table.concat( search_terms, " AND " )

      table.insert( args, "-e" )
      table.insert( args, pattern )
      table.insert( args, "--bool" )

      for _, glob in ipairs( globs ) do
        table.insert( args, "--include=" .. glob )
      end

      vim.list_extend( args, {
        "-r",
        "--mmap",
        "--jobs=1",
        "--ignore-files",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column-number"
      } )

      return args
    end
  else
    local args = { "ugrep", "-F" }
    local tokens = vim.split( prompt, "  " )

    if tokens[ 1 ] then
      table.insert( args, "-e" )
      table.insert( args, tokens[ 1 ] )
    end

    for i = 2, #tokens do
      if tokens[ i ] then
        table.insert( args, "--include=" .. tokens[ i ] )
      end
    end

    vim.list_extend( args, {
      "-r",
      "--ignore-files",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column-number"
    } )

    return args
  end
end

return M

