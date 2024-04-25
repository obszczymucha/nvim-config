local registry = prequire( "mason-registry" )
if not registry then return end

-- Some Mason packages are not defined in nvim-lspconfig.
-- We'll install them here.
local packages = {
  "npm-groovy-lint",
  "java-test",
  "java-debug-adapter"
}

for _, package_name in ipairs( packages ) do
  if registry.is_installed( package_name ) == false then
    registry.get_package( package_name ):install()
  end
end
