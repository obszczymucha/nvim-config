local M = {}

local AND_SEPARATOR = " | "
local GLOB_SEPARATOR = "  "

local TRAILING_SEPARATORS = {}

for i = #AND_SEPARATOR, 1, -1 do
  table.insert( TRAILING_SEPARATORS, AND_SEPARATOR:sub( 1, i ) )
end

local BASE_FLAGS = {
  "-r",
  "-i",
  "--ignore-files",
  "--ignore-binary",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column-number"
}

local MULTI_SEARCH_FLAGS = {
  "--mmap",
  "--jobs=1"
}

local function clean_prompt( prompt )
  for _, sep in ipairs( TRAILING_SEPARATORS ) do
    if prompt:sub( - #sep ) == sep then
      return prompt:sub( 1, -(#sep + 1) )
    end
  end

  return prompt
end

local function parse_term( term )
  local tokens = vim.split( vim.trim( term ), GLOB_SEPARATOR )
  local search_text = tokens[ 1 ]
  local globs = {}

  for i = 2, #tokens do
    if tokens[ i ] then
      table.insert( globs, tokens[ i ] )
    end
  end

  return search_text, globs
end

local function quote_literal( text )
  local escaped = text:gsub( '"', '\\"' )
  return '"' .. escaped .. '"'
end

local function build_multi_search( terms )
  local all_globs = {}
  local search_terms = {}

  for _, term in ipairs( terms ) do
    local search_text, globs = parse_term( term )

    if search_text then
      table.insert( search_terms, quote_literal( search_text ) )
      vim.list_extend( all_globs, globs )
    end
  end

  if #search_terms == 0 then
    return nil
  end

  local args = { "ugrep" }
  local pattern = table.concat( search_terms, " AND " )

  table.insert( args, "-e" )
  table.insert( args, pattern )
  table.insert( args, "--bool" )

  for _, glob in ipairs( all_globs ) do
    table.insert( args, "--include=" .. glob )
  end

  vim.list_extend( args, BASE_FLAGS )
  vim.list_extend( args, MULTI_SEARCH_FLAGS )
  return args
end

local function build_single_search( prompt )
  local args = { "ugrep" }
  local search_text, globs = parse_term( prompt )

  if search_text then
    table.insert( args, "-e" )
    table.insert( args, quote_literal( search_text ) )
    table.insert( args, "--bool" )
  end

  for _, glob in ipairs( globs ) do
    table.insert( args, "--include=" .. glob )
  end

  vim.list_extend( args, BASE_FLAGS )
  return args
end

function M.generate_multigrep_command( prompt )
  if not prompt or prompt == "" then
    local args = { "ugrep", "." }
    vim.list_extend( args, BASE_FLAGS )
    return args
  end

  local clean = clean_prompt( prompt )

  if clean:find( AND_SEPARATOR ) then
    local terms = vim.split( clean, AND_SEPARATOR )
    if #terms > 1 then
      local multi_args = build_multi_search( terms )
      if multi_args then
        return multi_args
      end
    end
  end

  return build_single_search( clean )
end

return M
