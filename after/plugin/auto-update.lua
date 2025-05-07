local config = prequirev( "obszczymucha.user-config" )
if not config then return end

local auto_update = prequirev( "obszczymucha.auto-update" )
if not auto_update then return end

local mason_utils = prequirev( "obszczymucha.mason-utils" )
if not mason_utils then return end

local common = prequirev( "obszczymucha.common" )
if not common then return end

local async = prequirev( "plenary.async" )
if not async then return end

local map = common.map

local checks = {
  maven_updated = false,
  lazy_updated = false
}

local function after_update()
  if checks.maven_updated and checks.lazy_updated then
    -- This needs to be scheduled, otherwise we're getting this error:
    -- E5560: Vimscript function must not be called in a lua loop callback
    vim.schedule( function() config.set_last_update_timestamp( os.time() ) end )
  end
end

local function update_mason( registry )
  if not registry then return end

  local package_bundle = {
    announced = false,
    updated_count = 0,
    wrapped_packages = nil
  }

  local function all_packages_checked()
    for _, wrapped_package in pairs( package_bundle.wrapped_packages ) do
      if wrapped_package.version_checked == false then return false end
    end

    return true
  end

  local function any_package_needs_update()
    for _, wrapped_package in pairs( package_bundle.wrapped_packages ) do
      if wrapped_package.needs_update == true then return true end
    end

    return false
  end

  local function announce_if_needed()
    if package_bundle.announced == true then return end

    if all_packages_checked() == false then return end
    if any_package_needs_update() == true then return end

    package_bundle.announced = true
    checks.maven_updated = true

    if package_bundle.updated_count > 0 then
      vim.notify( "Mason updated successfully." )
    else
      vim.notify( "Mason is up-to-date." )
    end

    after_update()
  end

  local function to_map( installed_packages )
    local result = {}

    for _, package_name in ipairs( installed_packages ) do
      result[ package_name ] = package_name
    end

    return result
  end


  local function wrap( package_name )
    return {
      name = package_name,
      version_checked = false,
      needs_update = false
    }
  end

  registry.update( function()
    package_bundle.wrapped_packages = map( to_map( registry.get_installed_package_names() ), wrap )

    for _, wrapped_package in pairs( package_bundle.wrapped_packages ) do
      local pkg = registry.get_package( wrapped_package.name )
      local current_version = pkg:get_installed_version()
      local latest_version = pkg:get_latest_version()

      if current_version ~= latest_version then
        wrapped_package.version_checked = true
        wrapped_package.needs_update = true

        vim.notify( string.format( "Updating %s from version %s to %s...", wrapped_package.name, current_version,
          latest_version ) )

        package_bundle.updated_count = package_bundle.updated_count + 1
        package_bundle.updates_needed = true

        mason_utils.install_package( wrapped_package.name, latest_version, function()
          package_bundle.updated_count = package_bundle.updated_count + 1
          package_bundle.wrapped_packages[ wrapped_package.name ].needs_update = false
          vim.notify( string.format( "%s updated successfully.", wrapped_package.name ) )

          announce_if_needed()
        end )
      else
        wrapped_package.version_checked = true
        wrapped_package.needs_update = false
      end
    end

    announce_if_needed()
  end )
end

local function update_lazy( lazy )
  if not lazy then return end

  local autocmd_id
  autocmd_id = vim.api.nvim_create_autocmd( "User", {
    pattern = "LazySync",
    callback = function()
      checks.lazy_updated = true
      vim.notify( "Lazy is up-to-date." )
      vim.api.nvim_del_autocmd( autocmd_id )
      after_update()
    end
  } )

  lazy.sync( { show = false, wait = false } )
end

local function update()
  local last_update_timestamp = config.get_last_update_timestamp()
  local now = os.time()

  if auto_update.should_update( last_update_timestamp, now ) then
    local registry = prequirev( "mason-registry" )
    local lazy = prequirev( "lazy" )
    if not registry and not lazy then return end

    vim.notify( string.format( "Updating %s...", registry and lazy and "Mason and Lazy" or registry and "Mason" or "Lazy" ) )

    update_mason( registry )
    update_lazy( lazy )
  end
end

vim.api.nvim_create_autocmd( "User", {
  pattern = "VeryLazy",
  callback = update,
} )
