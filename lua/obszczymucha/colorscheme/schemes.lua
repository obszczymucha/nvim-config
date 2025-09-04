local M = {}

local utils = require( "obszczymucha.utils" )

local function adjust( color )
  -- return color
  return utils.brightness( utils.hue( color, 5 ), 1.1 )
end

M.schemes = {
  default = {
    kanagawa = {
      palette = {},
      overrides = {
        Visual = { bg = adjust( "#3d3a7a" ) },
        Normal = { bg = adjust( "#1a1a1c" ) },
        TelescopeNormal = { bg = adjust( "#141416" ) },
        TelescopeBorder = { bg = adjust( "#141416" ), fg = adjust( "#4c4a69" ) },
        TelescopePromptNormal = { bg = adjust( "#141416" ) },
      }
    },
    custom = {
      accent = adjust( "#9f7fff" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#2db7ff" ),
      cursor_line = adjust( "#fabd2f" ),
      line_number = adjust( "#4b5271" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#b9c0eb" ),
    }
  },

  [ "blue" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#000608" ),
        sumiInk1 = adjust( "#000c10" ),
        sumiInk2 = adjust( "#001118" ),
        sumiInk3 = adjust( "#001721" ),
        sumiInk4 = "#001118",
        sumiInk5 = "#002331",
        sumiInk6 = adjust( "#002939" ),

        waveBlue1 = adjust( "#002e41" ),
        waveBlue2 = adjust( "#003449" ),

        winterGreen = adjust( "#003a52" ),
        winterYellow = adjust( "#00405a" ),
        winterRed = adjust( "#004562" ),
        winterBlue = adjust( "#004b6a" ),
        autumnGreen = adjust( "#005172" ),
        autumnRed = adjust( "#00577a" ),
        autumnYellow = adjust( "#005d83" ),

        samuraiRed = adjust( "#00628b" ),
        roninYellow = adjust( "#006893" ),
        waveAqua1 = adjust( "#006e9b" ),
        dragonBlue = adjust( "#0074a3" ),

        oldWhite = adjust( "#a1e4ff" ),
        fujiWhite = adjust( "#a9e6ff" ),
        fujiGray = adjust( "#005d83" ),

        oniViolet = adjust( "#007fb4" ),
        oniViolet2 = adjust( "#0085bc" ),
        crystalBlue = adjust( "#008bc4" ),
        springViolet1 = adjust( "#0091cc" ),
        springViolet2 = adjust( "#0097d4" ),
        springBlue = adjust( "#009cdc" ),
        lightBlue = adjust( "#00a2e4" ),
        waveAqua2 = adjust( "#00a8ed" ),

        springGreen = adjust( "#89ddff" ),
        boatYellow1 = adjust( "#00aef5" ),
        boatYellow2 = adjust( "#00b3fd" ),
        carpYellow = adjust( "#06b7ff" ),

        sakuraPink = adjust( "#0eb9ff" ),
        waveRed = adjust( "#16bbff" ),
        peachRed = adjust( "#1fbeff" ),
        surimiOrange = adjust( "#27c0ff" ),
        katanaGray = adjust( "#2fc3ff" ),
      },
      overrides = {
        Visual = { bg = adjust( "#0074a3" ) },
        Normal = { bg = "#101010" },
        TelescopeNormal = { bg = adjust( "#000c10" ) },
        TelescopeBorder = { bg = adjust( "#000c10" ), fg = adjust( "#0074a3" ) },
        TelescopePromptNormal = { bg = adjust( "#000c10" ) },
      }
    },
    custom = {
      accent = adjust( "#3fc7ff" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.75 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.98 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.55 )
      end,
      light_blue = adjust( "#47caff" ),
      cursor_line = adjust( "#50ccff" ),
      line_number = adjust( "#0074a3" ),
      notify_info_border = function( accent )
        return adjust( "#0074a3" )
      end,
      notify_info_body = adjust( "#60d1ff" ),
    }
  }
}

function M.get_scheme( name )
  name = name or "default"
  return M.schemes[ name ] or M.schemes.default
end

function M.get_custom_colors( name )
  local scheme = M.get_scheme( name )
  local colors = {}

  for key, value in pairs( scheme.custom ) do
    if type( value ) == "function" then
      if key:match( "accent" ) or key == "notify_info_border" then
        colors[ key ] = value( scheme.custom.accent )
      else
        colors[ key ] = value()
      end
    else
      colors[ key ] = value
    end
  end

  return colors
end

function M.apply_scheme( name )
  local scheme = M.get_scheme( name )


  return {
    palette = scheme.kanagawa.palette,
    overrides = scheme.kanagawa.overrides,
    custom = M.get_custom_colors( name )
  }
end

function M.get_scheme_list()
  local schemes_list = {}
  for name, _ in pairs( M.schemes ) do
    table.insert( schemes_list, name )
  end
  table.sort( schemes_list )
  return schemes_list
end

local augroup = vim.api.nvim_create_augroup( "ObszczymuchaColorschemeAutoReload", { clear = true } )

vim.api.nvim_create_autocmd( "BufWritePost", {
  group = augroup,
  pattern = "*/lua/obszczymucha/colorscheme/schemes.lua",
  callback = function()
    vim.schedule( function()
      require( "obszczymucha.colorscheme" ).reload()
    end )
  end
} )

return M
