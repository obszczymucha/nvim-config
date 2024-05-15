local luasnip = prequire( "luasnip" )
if not luasnip then return end

luasnip.config.set_config( {
  history = false,
  -- This is fucking awesome, this updates the snippets when the typing.
  updateevents = "TextChanged,TextChangedI"
} )
