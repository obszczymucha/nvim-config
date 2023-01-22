local q = require( "vim.treesitter.query" )
local debug = require( "obszczymucha.debug" ).debug
local clear = require( "obszczymucha.debug" ).clear

local M = {}

local test_bufnr = 11

local function dump( value )
  return vim.inspect( value )
end

function M.run_tests()

  vim.api.nvim_buf_set_lines( output_bufnr, 0, -1, false, {
    "Hello",
    "world"
  } )


  local language_tree = vim.treesitter.get_parser( test_bufnr, "lua" )
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[ 1 ]:root()
  local query = vim.treesitter.parse_query( "lua", [[
    (function_declaration
      name: [
        (method_index_expression
          table: (identifier) @table
          method: (identifier) @method
        )
        (dot_index_expression
          table: (identifier) @table2
          field: (identifier) @field
        )
      ] @ss (#offset! @ss)
    )
  ]] )

  for _, match, metadata in query:iter_matches( root, test_bufnr, root:start(), root:end_() ) do
    local class_name = q.get_node_text( match[ 1 ] or match[ 3 ], test_bufnr )
    local test_name = q.get_node_text( match[ 2 ] or match[ 4 ], test_bufnr )
    local line = tonumber( string.format( "Line: %s", metadata[ 5 ].range[ 1 ] + 1 ) )
    tests[ string.format( "%s.%s", class_name, test_name ) ] = line
  end
end

local function dump2( o )
  local entries = 0

  if type( o ) == 'table' then
    local s = '{'
    for k, v in pairs( o ) do
      if (entries == 0) then s = s .. " " end
      if type( k ) ~= 'number' then k = '"' .. k .. '"' end
      if (entries > 0) then s = s .. ", " end
      s = s .. '[' .. k .. '] = ' .. dump2( v )
      entries = entries + 1
    end

    if (entries > 0) then s = s .. " " end
    return s .. '}'
  else
    return tostring( o )
  end
end

function M.run()
  local test_results = {}
  local index = 0
  local file_name

  local function collect_results( _, data )
    if not data then return end

    for _, line in ipairs( data ) do
      for filename in string.gmatch( line, "Testing (.+)..." ) do
        file_name = filename
      end

      for not_ok, class_name, test_name in string.gmatch( line, "(.*)ok%s+%d+%s+(.+)%.(.+)" ) do
        table.insert( test_results, { file_name = file_name, ok = not_ok == "", class_name = class_name, test_name = test_name } )
        index = index + 1
      end

      for line_number, expected in string.gmatch( line, ".+:(%d+): expected: \"(.+)\"" ) do
        test_results[ index ].error_line_number = line_number
        test_results[ index ].expected = expected
      end

      for actual in string.gmatch( line, ".+actual: \"(.+)\"" ) do
        test_results[ index ].actual = actual
      end
    end
  end

  local function print_tests()
    for _, result in ipairs( test_results ) do
      debug( dump2( result ) )
    end
  end

  clear()
  local command = { "./test.sh", "-T", "Spec", "-m", "should", "-v", "-o", "tap" }

  vim.fn.jobstart( command, {
    stdout_buffered = true,
    on_stdout = collect_results,
    on_stderr = collect_results,
    on_exit = print_tests
  } )
end

function M.setup()
  --vim.api.nvim_create_user_command( "LuaTest", function( opts )
  --vim.api.nvim_create_augroup( "AutoLuaTest", { clear = true } )
  --vim.api.nvim_create_autocmd( "BufWritePost", {
  --group = "AutoLuaTest",
  --pattern = { "*.lua" },
  --callback = function() R( "obszczymucha.lua-test" ).run( tonumber( opts.args ) ) end
  --} )
  --end, { nargs = 1 } )
end

M.setup()

return M
