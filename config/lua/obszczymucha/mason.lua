local registry = prequire( "mason-registry" )
if not registry then return end

-- Some Mason packages are not defined in nvim-lspconfig.
-- We'll install them here.
local packages = {
  "npm-groovy-lint",
  "java-test",
  "java-debug-adapter"
}

local function are_packages_available( p )
  for _, package_name in ipairs( p ) do
    local success, pkg = pcall( function() return registry.get_package( package_name ) end )

    if not success or not pkg then
      return false
    end
  end

  return true
end

local function install_packages()
  for _, package_name in ipairs( packages ) do
    if registry.is_installed( package_name ) == false then
      registry.get_package( package_name ):install()
    end
  end
end

if are_packages_available( packages ) == true then
  install_packages()
else
  registry.update( install_packages )
end
