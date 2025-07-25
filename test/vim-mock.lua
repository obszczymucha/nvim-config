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
end

return M
