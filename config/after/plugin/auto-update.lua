local config = prequirev( "obszczymucha.user-config" )
if not config then return end

local auto_update = prequirev( "obszczymucha.auto-update" )
if not auto_update then return end

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
    config.set_last_update_timestamp( os.time() )
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

    for _, p in ipairs( installed_packages ) do
      result[ p.name ] = p
    end

    return result
  end


  local function wrap( installed_package )
    return {
      installed_package = installed_package,
      version_checked = false,
      needs_update = false
    }
  end

  registry.update( function()
    package_bundle.wrapped_packages = map( to_map( registry.get_installed_packages() ), wrap )

    for _, p in pairs( package_bundle.wrapped_packages ) do
      p.installed_package:check_new_version( function( success, details )
        p.version_checked = true
        p.needs_update = success == true or false

        if p.needs_update == false then
          announce_if_needed()
          return
        end

        vim.notify( string.format( "Updating %s from version %s to %s...", details.name, details.current_version,
          details.latest_version ) )
        package_bundle.updated_count = package_bundle.updated_count + 1
        package_bundle.updates_needed = true
        local handle = p.installed_package:install( { version = details.latest_version } )

        handle:on( "state:change", function( new_state, old_state )
          if new_state == "CLOSED" and old_state == "ACTIVE" then
            package_bundle.updated_count = package_bundle.updated_count + 1
            package_bundle.wrapped_packages[ details.name ].needs_update = false
            vim.notify( string.format( "%s updated successfully.", details.name ) )

            announce_if_needed()
          end
        end )
      end )
    end
  end )
end

local function update_lazy( lazy )
  if not lazy then return end

  local autocmd_id
  autocmd_id = vim.api.nvim_create_autocmd( "User", {
    pattern = "LazySync",
    callback = function()
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
