local M = {}

local pickers = require( "telescope.pickers" )
local finders = require( "telescope.finders" )
local make_entry = require( "telescope.make_entry" )
local conf = require( "telescope.config" ).values

function M.live_multigrep( search_term )
  local opts = {}
  opts.cwd = opts.cwd or vim.fn.getcwd()

  local finder = finders.new_async_job {
    command_generator = function( prompt )
      if not prompt or prompt == "" then return end

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
              -- Subsequent rg commands filter stdin, using --no-filename to avoid adding stdin prefix
              -- Use -F for literal matching to avoid regex interpretation
              local part = "rg -F -e " .. vim.fn.shellescape( tokens[ 1 ] ) .. " --no-filename --no-line-number"
              table.insert( cmd_parts, part )
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
    end,
    entry_maker = make_entry.gen_from_vimgrep( opts ),
    cwd = opts.cwd
  }

  local picker_opts = {
    debounce = 100,
    prompt_title = "Live Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer( opts ),
    sorter = require( "telescope.sorters" ).empty()
  }

  if search_term then
    picker_opts.default_text = search_term
  end

  pickers.new( opts, picker_opts ):find()
end

return M
