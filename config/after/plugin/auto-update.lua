local config = prequirev( "obszczymucha.user-config" )
if not config then return end

local auto_update = prequirev( "obszczymucha.auto-update" )
if not auto_update then return end

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

local function update()
  local last_update_timestamp = config.get_last_update_timestamp()
  local now = os.time()

  if auto_update.should_update( last_update_timestamp, now ) then
    update_mason()
    update_lazy()
    config.set_last_update_timestamp( now )
  end
end

vim.api.nvim_create_autocmd( "User", {
  pattern = "VeryLazy",
  callback = update,
} )
