local ls = prequire( "luasnip" )
if not ls then return end

local s = ls.s
local i = ls.i
local t = ls.t
local events = require( "luasnip.util.events" )

local function insert_import( package_name, class_name, modifier )
  local bufnr = 0
  local parser = vim.treesitter.get_parser( bufnr, "java" )
  local tree = parser:parse()[ 1 ]
  local root = tree:root()

  local mod = modifier and string.format( "%s ", modifier ) or ""
  local import_name = string.format( "import %s%s.%s;", mod, package_name, class_name )
  local all_import_name = string.format( "import %s%s.*;", mod, package_name )

  local query = vim.treesitter.query.parse( "java", [[
    (package_declaration) @package
    (import_declaration) @import
  ]] )

  local last_import_line_number = nil
  local package_line_number = nil

  for _, node in query:iter_captures( root, bufnr, 0, -1 ) do
    local line = vim.treesitter.get_node_text( node, bufnr )
    local start_row_index = node:range()
    local line_number = start_row_index + 1

    if line:match( "^import%s" ) then
      last_import_line_number = line_number
    elseif line:match( "^package%s" ) then
      package_line_number = line_number
    end
    if line == import_name or line == all_import_name then
      return
    end
  end

  local line_number = 0
  local result = {}

  if last_import_line_number then
    line_number = last_import_line_number
    table.insert( result, "" )
  elseif package_line_number then
    line_number = package_line_number
    table.insert( result, "" )
  end

  table.insert( result, import_name )

  vim.api.nvim_buf_set_lines( 0, line_number, line_number, false, result )
end

local function insert_test_import()
  insert_import( "org.junit.jupiter.api", "Test" )
end

local function insert_parametrized_test_import()
  insert_import( "org.junit.jupiter.params", "ParameterizedTest" )
end

local function hook( f )
  return {
    node_callbacks = { [ events.enter ] = f }
  }
end

local function insert_assertj_assertthat_import()
  insert_import( "org.assertj.core.api.Assertions", "assertThat", "static" )
end

ls.add_snippets( "java", {
  s( "test", {
    t( "@Test" ),
    t( { "", "public void should" } ), i( 1 ), t( "() {" ),
    t( { "", "\t// Given" } ),
    t( { "", "\t" } ), i( 0, "", { node_callbacks = { [ events.enter ] = insert_test_import } } ),
    t( { "", "", "\t// When" } ),
    t( { "", "", "\t// Then" } ),
    t( { "", "}" } )
  } ),
  s( "ptest", {
    t( "@ParameterizedTest" ),
    t( { "", "public void should" } ), i( 1 ), t( "() {" ),
    t( { "", "\t// Given" } ),
    t( { "", "\t" } ), i( 0, "", hook( insert_parametrized_test_import ) ),
    t( { "", "", "\t// When" } ),
    t( { "", "", "\t// Then" } ),
    t( { "", "}" } )
  } ),
  s( "gwt", {
    t( { "// Given", "" } ),
    i( 0 ),
    t( { "", "", "// When" } ),
    t( { "", "", "// Then" } )
  } ),
  s( "athat", {
    t( "assertThat(" ), i( 1 ), t( ")" ), i( 0, "", hook( insert_assertj_assertthat_import ) )
  } )
} )
