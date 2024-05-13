local ls = prequire( "luasnip" )
if not ls then return end

local s = ls.s
local i = ls.i
local t = ls.t
local f = ls.f
local events = require( "luasnip.util.events" )
local fmt = require( "luasnip.extras.fmt" ).fmt

local LANG = "java"

local decapitalize = function( args )
  return string.gsub( args[ 1 ][ 1 ], "^%u", function( c ) return string.lower( c ) end )
end

local function camelCaseToSentence( args )
  local input = args[ 1 ][ 1 ]
  if input == "" then return "" end

  local result = input:gsub( "(%l)(%u)", "%1 %2" )
  return result:sub( 1, 1 ):upper() .. result:sub( 2 ):lower() .. "."
end

local function get_captures( bufnr, lang, query_string )
  local parser = vim.treesitter.get_parser( bufnr, lang )
  local tree = parser:parse()[ 1 ]
  local root = tree:root()
  local query = vim.treesitter.query.parse( lang, query_string )

  return query:iter_captures( root, bufnr, 0, -1 )
end

local function get_package_details()
  local bufnr = 0

  for _, node in get_captures( bufnr, LANG, "(package_declaration (scoped_identifier) @package)" ) do
    local package_name = vim.treesitter.get_node_text( node, bufnr )
    local y = node:range()

    return package_name, y + 1
  end
end

local function get_class_details()
  local bufnr = 0

  for _, node in get_captures( bufnr, LANG, "(class_declaration name: (identifier) @class_name)" ) do
    local class_name = vim.treesitter.get_node_text( node, bufnr )
    local y = node:range()

    return class_name, y + 1
  end
end

local function find_current_imports()
  local bufnr = 0
  local captures = get_captures( bufnr, LANG, "(import_declaration) @import" )
  local result = {}

  for _, node in captures do
    local import_name = vim.treesitter.get_node_text( node, bufnr )
    local start_row_index = node:range()

    table.insert( result, {
      line_number = start_row_index + 1,
      import_name = import_name
    } )
  end

  return result
end

local function insert_imports( imports )
  if #imports == 0 then return end

  local current_imports = find_current_imports()
  local last_import_line_number = #current_imports > 0 and current_imports[ #current_imports ].line_number
  local result = {}
  local line_number = 0
  local nothing_to_insert = true

  if last_import_line_number then
    line_number = last_import_line_number
    table.insert( result, "" )
  else
    local package_name, lineno = get_package_details()

    if package_name and lineno then
      line_number = lineno
      table.insert( result, "" )
    end
  end

  for _, import in ipairs( imports ) do
    local package_name, class_name, modifier = unpack( import )
    local found = false
    local mod = import.modifier and string.format( "%s ", modifier ) or ""
    local import_name = string.format( "import %s%s.%s;", mod, package_name, class_name )
    local all_import_name = string.format( "import %s%s.*;", mod, package_name )

    for _, current_import in ipairs( current_imports ) do
      if current_import.import_name == import_name or current_import.import_name == all_import_name then
        found = true
        break
      end
    end

    if found == false then
      table.insert( result, import_name )
      nothing_to_insert = false
    end
  end

  if nothing_to_insert == true then return end
  vim.api.nvim_buf_set_lines( 0, line_number, line_number, false, result )
end

local function insert_test_import()
  insert_imports( { { "org.junit.jupiter.api", "Test" } } )
end

local function insert_parametrized_test_imports()
  insert_imports( {
    { "java.util.stream",                  "Stream" },
    { "org.junit.jupiter.api",             "DisplayName" },
    { "org.junit.jupiter.params",          "ParameterizedTest" },
    { "org.junit.jupiter.params.provider", "Arguments" },
    { "org.junit.jupiter.params.provider", "MethodSource" }
  } )
end

local function hook( callback )
  return {
    node_callbacks = { [ events.enter ] = callback }
  }
end

local function insert_assertj_assertthat_import()
  insert_imports( { { "org.assertj.core.api.Assertions", "assertThat", "static" } } )
end

local function get_package_name()
  local name = get_package_details()
  return name and string.format( "%s.", name )
end

ls.add_snippets( LANG, {
  s( "test", fmt( "@Test\nvoid should{test_name}() {{\n\t// Given\n\t{start}\n\n\t// When\n\n\t// Then\n}}", {
    start = i( 0, "", hook( insert_test_import ) ),
    test_name = i( 1 )
  } ) ),
  s( "ptest",
    fmt(
      "@ParameterizedTest\n@DisplayName(\"{display_name}\")\n@MethodSource(\"{package_name}{class_name}#{provider_name}Provider\")\nvoid should{test_name}() {{\n\t// Given\n\t{start}\n\n\t// When\n\n\t// Then\n}}\n\n@SuppressWarnings(\"unused\")\nprivate static Stream<Arguments> {provider_name}Provider() {{\n\treturn Stream.of();\n}}",
      {
        start = i( 0, "", hook( insert_parametrized_test_imports ) ),
        test_name = i( 1 ),
        display_name = f( camelCaseToSentence, { 1 } ),
        package_name = f( get_package_name ),
        provider_name = f( decapitalize, { 1 } ),
        class_name = f( get_class_details )
      } ) ),
  s( "gwt", fmt( "// Given\n\t{start}\n\n\t// When\n\n\t// Then", {
    start = i( 0 )
  } ) ),
  s( "athat", {
    t( "assertThat(" ), i( 1 ), t( ")" ), i( 0, "", hook( insert_assertj_assertthat_import ) )
  } )
} )
