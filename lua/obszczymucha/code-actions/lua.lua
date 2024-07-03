local null_ls = prequirev( "null-ls" )
if not null_ls then return end

null_ls.register( {
  name = "my-source",
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "lua" },
  generator = {
    fn = function( params )
      local result = {}

      table.insert( result, {
        title = "Princess Kenny",
        action = function()
          vim.notify( "shinde ita" )
        end
      } )

      return result
    end
  }
} )
