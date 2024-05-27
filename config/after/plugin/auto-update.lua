local UPDATE_INTERVAL_IN_SECONDS = 60 * 60 * 24

local config = prequirev( "obszczymucha.user-config" )
if not config then return end

local function update_mason()
  local mason = prequirev( "mason-registry" )
  if not mason then return end

  vim.notify( "Updating Mason..." )
  mason.update( function()
    local registry = prequirev( "mason-registry" )
    if not registry then return end

    -- TODO: figure out the API once there are some updates available.
    -- local packages = registry.get_installed_packages()

    -- for _, installed_package in ipairs( packages ) do
    -- installed_package:update() <- fuck you ChatGPT you stupid fuck
    -- end
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

  if not last_update_timestamp or now - last_update_timestamp > UPDATE_INTERVAL_IN_SECONDS then
    update_mason()
    update_lazy()
    config.set_last_update_timestamp()
  end
end

vim.api.nvim_create_autocmd( "User", {
  pattern = "VeryLazy",
  callback = update,
} )
