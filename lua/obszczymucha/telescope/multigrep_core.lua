-- Core multigrep command generation logic (decoupled from Telescope)
local M = {}

-- Decoupled command generation logic
function M.generate_multigrep_command( prompt )
  if not prompt or prompt == "" then
    -- Show all non-empty lines when prompt is empty
    return { "rg", ".", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
      "--smart-case" }
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
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column-number"
      } )

      return args
    end
  else
    local args = { "rg", "-F" } -- Add -F for literal matching
    local tokens = vim.split( prompt, "  " )

    if tokens[ 1 ] then
      table.insert( args, "-e" )
      table.insert( args, tokens[ 1 ] )
    end

    for i = 2, #tokens do
      if tokens[ i ] then
        table.insert( args, "-g" )
        table.insert( args, tokens[ i ] )
      end
    end

    vim.list_extend( args, {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    } )

    return args
  end
end

return M

