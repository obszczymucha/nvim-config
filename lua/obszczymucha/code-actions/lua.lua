local null_ls = prequirev( "null-ls" )
if not null_ls then return end

local function is_table_constructor( node, _ )
  if not node or node:type() ~= "table_constructor" then return false end
  return true
end

null_ls.register( {
  name = "my-source",
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "lua" },
  generator = {
    fn = function( params )
      local result = {}

      local node = vim.treesitter.get_node()

      if is_table_constructor( node, params ) then
        table.insert( result, {
          title = "Princess Kenny",
          action = function()
            vim.notify( "shinde ita" )
          end
        } )
      end

      return result
    end
  }
} )
