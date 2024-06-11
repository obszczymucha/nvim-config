local M = {}

-- Example name: "rust-analyzer"
-- Example version: "2024-05-20"
function M.install_package( name, version, success_callback )
  local registry = prequirev( "mason-registry" )
  if not registry then return end
  local handle = registry.get_package( name ):install( { version = version } )

  handle:on( "state:change", function( new_state, old_state )
    if new_state == "CLOSED" and old_state == "ACTIVE" then
      success_callback( name )
    end
  end )
end

return M
