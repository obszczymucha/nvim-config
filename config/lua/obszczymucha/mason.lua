local registry = prequire( "mason-registry" )
if not registry then return end

-- Some Mason packages are not defined in nvim-lspconfig.
-- We'll install them here.
local packages = {
  "npm-groovy-lint"
}

for _, package_name in pairs( packages ) do
  if not registry:is_installed( package_name ) then
    registry.get_package( package_name ):install()
  end
end
