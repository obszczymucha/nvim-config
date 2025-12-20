local config = prequirev( "obszczymucha.user-config" )
if not config then return end

local mason_utils = prequirev( "obszczymucha.mason-utils" )
if not mason_utils then return end

local common = prequirev( "obszczymucha.common" )
if not common then return end

local async = prequirev( "plenary.async" )
if not async then return end

local M = {}

local map = common.map

local checks = {
  maven_updated = false,
  lazy_updated = false
}

local function c( text, highlight )
  return string.format( "[%s]{%s}", text, highlight or "purple" )
end

local lazy_colored = c( "Lazy" )
local mason_colored = c( "Mason" )

local function pkg_colored( pkg )
  return c( pkg, "Added" )
end

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
      vim.notify( string.format( "%s updated successfully.", mason_colored ) )
    else
      vim.notify( string.format( "%s is up-to-date.", mason_colored ) )
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

        vim.notify( string.format( "Updating %s from version %s to %s...", pkg_colored( wrapped_package.name ),
          current_version,
          latest_version ) )

        package_bundle.updated_count = package_bundle.updated_count + 1
        package_bundle.updates_needed = true

        mason_utils.install_package( wrapped_package.name, latest_version, function()
          package_bundle.updated_count = package_bundle.updated_count + 1
          package_bundle.wrapped_packages[ wrapped_package.name ].needs_update = false
          vim.notify( string.format( "%s updated successfully.", pkg_colored( wrapped_package.name ) ) )

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
      vim.notify( string.format( "%s is up-to-date.", lazy_colored ) )
      vim.api.nvim_del_autocmd( autocmd_id )
      after_update()
    end
  } )

  lazy.sync( { show = false, wait = false } )
end

function M.update( opts )
  local last_update_timestamp = config.get_last_update_timestamp()
  local now = os.time()
  local force = opts and opts.force == true or false

  if force or M.should_update( last_update_timestamp, now ) then
    local registry = prequirev( "mason-registry" )
    local lazy = prequirev( "lazy" )
    if not registry and not lazy then return end

    vim.notify( string.format( "Updating %s...",
      registry and lazy and string.format( "%s and %s", lazy_colored, mason_colored ) or registry and mason_colored or
      lazy_colored ) )

    update_mason( registry )
    update_lazy( lazy )
  end
end

function M.should_update( last_update_timestamp, current_time )
  local current_date_table = os.date( "*t", current_time )
  local current_hour = current_date_table.hour
  local last_update_date_table = last_update_timestamp and os.date( "*t", last_update_timestamp )
  local last_update_hour = last_update_date_table and last_update_date_table.hour

  local morning_update_hour = 7
  local evening_update_hour = 18

  local needs_morning_update = current_hour >= morning_update_hour and (
    not last_update_hour or
    last_update_date_table.day ~= current_date_table.day or
    last_update_hour < morning_update_hour
  )

  local needs_evening_update = current_hour >= evening_update_hour and (
    not last_update_hour or
    last_update_date_table.day ~= current_date_table.day or
    (last_update_hour < evening_update_hour and (current_hour > last_update_hour or last_update_date_table.day ~= current_date_table.day))
  )

  return needs_morning_update or needs_evening_update
end

return M
