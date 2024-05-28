local config = prequirev( "obszczymucha.user-config" )
if not config then return end

local function update_mason()
  local mason = prequirev( "mason-registry" )
  if not mason then return end

  vim.notify( "Updating Mason..." )
  mason.update( function()
    local registry = prequirev( "mason-registry" )
    if not registry then return end

    local packages = registry.get_installed_packages()

    for _, installed_package in ipairs( packages ) do
      installed_package:check_new_version( function( success, details )
        if not success or success == false then return end

        vim.notify( string.format( "Upgrading %s from version %s to %s...", details.name, details.current_version,
          details.latest_version ) )
        local handle = installed_package:install( { version = details.latest_version } )

        handle:on( "state:change", function( new_state, old_state )
          if new_state == "CLOSED" and old_state == "ACTIVE" then
            vim.notify( string.format( "%s upgraded successfully.", details.name ) )
          end
        end )
      end )
    end
  end )
end

local function update_lazy()
  local lazy = prequirev( "lazy" )
  if not lazy then return end

  vim.notify( "Updating Lazy..." )
  lazy.sync( { show = false } )
end

-- Update once after 7am and once after 6pm.
local function update()
  local last_update_timestamp = config.get_last_update_timestamp()
  local now = os.time()
  local current_hour = os.date( "*t", now ).hour
  local last_update_hour = last_update_timestamp and os.date( "*t", last_update_timestamp ).hour

  local morning_update_hour = 7
  local evening_update_hour = 18

  local needs_morning_update = current_hour >= morning_update_hour and
      (not last_update_hour or last_update_hour < morning_update_hour)
  local needs_evening_update = current_hour >= evening_update_hour and
      (not last_update_hour or last_update_hour < evening_update_hour)

  if needs_morning_update or needs_evening_update then
    update_mason()
    update_lazy()
    config.set_last_update_timestamp( now )
  end
end

vim.api.nvim_create_autocmd( "User", {
  pattern = "VeryLazy",
  callback = update,
} )
