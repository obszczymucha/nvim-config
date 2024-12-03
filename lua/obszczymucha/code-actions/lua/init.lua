local null_ls = prequirev( "null-ls" )
if not null_ls then return end

local break_table = require( "obszczymucha.code-actions.lua.break-table" )
local break_function = require( "obszczymucha.code-actions.lua.break-function" )

local function is_node( node, node_name, parent )
  if not node or node:type() ~= node_name then return false end

  if parent then
    local p = node:parent()
    if not p or p:type() ~= parent then return end
  end

  return true
end

null_ls.register( {
  name = "my-source",
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "lua" },
  generator = {
    fn = function()
      local result = {}

      local node = vim.treesitter.get_node()

      if is_node( node, "table_constructor" ) then
        table.insert( result, {
          title = "Break table into multiple lines",
          action = function()
            break_table( node )
          end
        } )
      end

      return result
    end
  }
}
)
null_ls.register( {
  name = "my-source",
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "lua" },
  generator = {
    fn = function()
      local result = {}

      local node = vim.treesitter.get_node()

      if is_node( node, "arguments" ) then
        table.insert( result, {
          title = "Break function into multiple lines",
          action = function()
            break_function()
          end
        } )
      end

      return result
    end
  }
}
)
