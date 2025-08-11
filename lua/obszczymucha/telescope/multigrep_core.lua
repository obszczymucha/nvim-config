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
    -- For || syntax, use pipes for AND behavior (all terms must match)
    local piped_terms = vim.split( prompt, "||" )
    local globs = {}

    -- Collect all globs from all terms
    for _, term in ipairs( piped_terms ) do
      local tokens = vim.split( vim.trim( term ), "  " )

      if #tokens > 1 then
        for i = 2, #tokens do
          if tokens[ i ] then
            table.insert( globs, tokens[ i ] )
          end
        end
      end
    end

    -- Build the piped command
    local cmd_parts = {}

    for i, term in ipairs( piped_terms ) do
      local tokens = vim.split( vim.trim( term ), "  " )

      if tokens[ 1 ] then
        if i == 1 then
          -- First command searches files
          local part = "rg -F -e " .. vim.fn.shellescape( tokens[ 1 ] )

          for _, glob in ipairs( globs ) do
            part = part .. " -g " .. vim.fn.shellescape( glob )
          end

          part = part .. " --color=never --no-heading --with-filename --line-number --column --smart-case"
          table.insert( cmd_parts, part )
        else
          -- Use awk to filter lines where the content part (after 3rd colon) contains the search term
          -- Format is: filename:line:column:content
          local awk_filter =
              "awk -F':' '{content=\"\"; for(i=4;i<=NF;i++) content = content $i (i<NF?\":\":\"\"); if(index(tolower(content), tolower(\"" ..
              tokens[ 1 ]:gsub( "'", "'\"'\"'" ) .. "\")) > 0) print $0}'"
          table.insert( cmd_parts, awk_filter )
        end
      end
    end

    if #cmd_parts > 0 then
      return { "sh", "-c", table.concat( cmd_parts, " | " ) }
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