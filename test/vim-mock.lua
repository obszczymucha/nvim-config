local M = {}

function M.setup()
  local vim = _G.vim or {}
  _G.vim = vim
  vim.fn = vim.fn or {}

  vim.fn.shellescape = vim.fn.shellescape or function( path )
    if not path or path == "" then return "''" end
    return "'" .. path:gsub( "'", "'\"'\"'" ) .. "'"
  end

  vim.fn.isdirectory = vim.fn.isdirectory or function( path )
    -- Mock .git directories for test fixtures
    if path:match( "/git%-repo/%.git$" ) or path:match( "/git%-worktree/%.git$" ) then
      return 1
    end

    local file = io.popen( "test -d " .. path .. " && echo 1 || echo 0" )
    if not file then return 0 end
    local result = file:read( "*a" ):gsub( "%s+", "" )
    file:close()
    return tonumber( result ) or 0
  end

  vim.fn.filereadable = vim.fn.filereadable or function( path )
    local file = io.popen( "test -f " .. path .. " && echo 1 || echo 0" )
    if not file then return 0 end
    local result = file:read( "*a" ):gsub( "%s+", "" )
    file:close()
    return tonumber( result ) or 0
  end

  vim.fn.finddir = vim.fn.finddir or function( pattern, path )
    if not pattern or not path then return "" end
    local cmd = "find " ..
        vim.fn.shellescape( path ) .. " -name " .. vim.fn.shellescape( pattern ) .. " -type d 2>/dev/null | head -1"
    local file = io.popen( cmd )
    if not file then return "" end
    local result = file:read( "*a" ):gsub( "%s+", "" )
    file:close()
    return result or ""
  end

  vim.fn.fnamemodify = vim.fn.fnamemodify or function( path, modifier )
    if modifier == ":h" then
      return path:match( "(.*/)" ) and path:match( "(.*)/" ) or "."
    end
    return path
  end

  vim.fn.systemlist = vim.fn.systemlist or function( cmd )
    -- Mock git commands for fixtures
    if cmd:match( "git ls%-files$" ) then
      local cwd = cmd:match( "cd '([^']+)'" )
      if cwd and cwd:match( "/git%-repo$" ) then
        return { "src/main.rs", "docs/README.md", "Cargo.toml", ".gitignore" }
      elseif cwd and cwd:match( "/git%-worktree$" ) then
        return { "client/main.rs", "server/main.rs", "proto/service.proto", "Cargo.toml" }
      end
      return {}
    elseif cmd:match( "git ls%-files %-%-others %-%-directory %-%-exclude%-standard" ) then
      local cwd = cmd:match( "cd '([^']+)'" )
      if cwd and cwd:match( "/git%-repo$" ) then
        return { "target/" }
      elseif cwd and cwd:match( "/git%-worktree$" ) then
        return {}
      end
      return {}
    elseif cmd:match( "find %-L" ) then
      -- Mock find command for regular directories
      if cmd:match( "fixtures/regular%-dir" ) then
        return {
          "../../fixtures/regular-dir",
          "../../fixtures/regular-dir/documents",
          "../../fixtures/regular-dir/downloads",
          "../../fixtures/regular-dir/projects",
          "../../fixtures/regular-dir/projects/project1",
          "../../fixtures/regular-dir/projects/project2"
        }
      end
      return {}
    else
      -- Regular systemlist behavior
      local result = {}
      local file = io.popen( cmd )
      if file then
        for line in file:lines() do
          table.insert( result, line )
        end
        file:close()
      end
      return result
    end
  end

  vim.fn.getcwd = vim.fn.getcwd or function()
    local file = io.popen( "pwd" )
    if not file then return "." end
    local result = file:read( "*a" ):gsub( "%s+", "" )
    file:close()
    return result or "."
  end

  vim.startswith = vim.startswith or function( str, prefix )
    return string.sub( str, 1, string.len( prefix ) ) == prefix
  end

  vim.split = vim.split or function( s, sep, opts )
    local plain = opts and opts.plain or false
    local trimempty = opts and opts.trimempty or false
    local t = {}
    local pattern = plain and sep or "[^" .. sep .. "]+"

    if plain then
      local pos = 1
      while true do
        local first, last = s:find( sep, pos, true )
        if not first then
          table.insert( t, s:sub( pos ) )
          break
        end
        table.insert( t, s:sub( pos, first - 1 ) )
        pos = last + 1
      end
    else
      for substr in s:gmatch( pattern ) do
        table.insert( t, substr )
      end
    end

    if trimempty then
      local filtered = {}
      for _, v in ipairs( t ) do
        if v ~= "" then
          table.insert( filtered, v )
        end
      end
      return filtered
    end

    return t
  end

  vim.trim = vim.trim or function( s )
    return s:match( "^%s*(.-)%s*$" )
  end

  vim.list_extend = vim.list_extend or function( dst, src, start, finish )
    start = start or 1
    finish = finish or #src
    for i = start, finish do
      table.insert( dst, src[ i ] )
    end
    return dst
  end

  -- Mock prequirev and prequire (protected require with verbose)
  ---@diagnostic disable-next-line: lowercase-global
  _G.prequire = _G.prequire or function( name, ... )
    -- Provide stubs for common dependencies
    if name == "obszczymucha.user-config" then
      return { get_last_update_timestamp = function() return nil end }
    elseif name == "obszczymucha.mason-utils" then
      return {}
    elseif name == "plenary.async" then
      return {}
    end

    local success, result = pcall( require, name, ... )
    if success then return result else return nil end
  end

  ---@diagnostic disable-next-line: lowercase-global
  _G.prequirev = _G.prequirev or function( name, ... )
    local result = _G.prequire( name, ... )
    if not result then
      print( string.format( "Warning: '%s' could not be found.", name ) )
    end
    return result
  end
end

return M
