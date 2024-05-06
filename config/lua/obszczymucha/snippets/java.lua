local ls = prequire( "luasnip" )
if not ls then return end

local s = ls.s
local i = ls.i
local t = ls.t
local events = require( "luasnip.util.events" )

local function insert_import( import_name )
  local lines = vim.api.nvim_buf_get_lines( 0, 0, -1, false )
  local last_import_index = nil
  local package_index = nil

  for index, line in ipairs( lines ) do
    if line:match( "^import%s" ) then
      last_import_index = index
    elseif line:match( "^package%s" ) then
      package_index = index
    end
    if line == import_name then
      return
    end
  end

  local line_number = 0
  local result = {}

  if last_import_index then
    line_number = last_import_index
    table.insert( result, "" )
  elseif package_index then
    line_number = package_index
    table.insert( result, "" )
  end

  table.insert( result, import_name )
  vim.api.nvim_buf_set_lines( 0, line_number, line_number, false, result )
end

local function insert_test_import()
  insert_import( "import org.junit.jupiter.api.Test;" )
end

local function insert_parametrized_test_import()
  insert_import( "import org.junit.jupiter.params.ParameterizedTest;" )
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
    t( { "", "\t" } ), i( 0, "", { node_callbacks = { [ events.enter ] = insert_parametrized_test_import } } ),
    t( { "", "", "\t// When" } ),
    t( { "", "", "\t// Then" } ),
    t( { "", "}" } )
  } ),
  s( "gwt", {
    t( { "// Given", "" } ),
    i( 0 ),
    t( { "", "", "// When" } ),
    t( { "", "", "// Then" } )
  } )
} )
