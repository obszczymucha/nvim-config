local M = {}

local utils = require( "obszczymucha.utils" )
local saturation, brightness, hue = utils.saturation, utils.brightness, utils.hue

-- Cache for computed colors
local color_cache = {}

local function adjust( color )
  -- Check cache first
  if color_cache[ color ] then
    return color_cache[ color ]
  end

  -- Compute and cache the result
  local result = saturation( brightness( hue( color, 0 ), 1.0 ), 0.9 )
  color_cache[ color ] = result
  return result
end

-- Translate descriptive keys to kanagawa palette names
local function translate_to_kanagawa( palette )
  return {
    -- Background colors (darkest to lightest)
    sumiInk0 = palette.float_background or palette.statusline_background,
    sumiInk1 = palette.default_background,
    sumiInk2 = palette.fold_background or palette.colorcolumn_background,
    sumiInk3 = palette.cursorline_background,
    sumiInk4 = palette.line_number_background or palette.border_color,
    sumiInk5 = palette.lighter_background,
    sumiInk6 = palette.nontext_color or palette.whitespace_color,

    -- UI colors
    waveBlue1 = palette.visual_background,
    waveBlue2 = palette.search_background or palette.pmenu_selection_background,

    -- Semantic colors for diff/diagnostics
    winterGreen = palette.diff_add or palette.diagnostic_ok,
    winterYellow = palette.diff_change or palette.diagnostic_warning,
    winterRed = palette.diff_delete or palette.diagnostic_error,
    winterBlue = palette.diff_text or palette.diagnostic_info,

    -- Git colors
    autumnGreen = palette.git_add,
    autumnRed = palette.git_delete,
    autumnYellow = palette.git_change,

    -- Special highlights
    samuraiRed = palette.special_keyword,
    roninYellow = palette.special_builtin,
    waveAqua1 = palette.special_exception,
    dragonBlue = palette.special_include,

    -- Text colors
    oldWhite = palette.dimmed_foreground,
    fujiWhite = palette.default_foreground,
    fujiGray = palette.comment,

    -- Syntax colors
    oniViolet = palette.method,
    oniViolet2 = palette.parameter,
    crystalBlue = palette.function_call,
    springViolet1 = palette.statement,
    springViolet2 = palette.keyword,
    springBlue = palette.type,
    lightBlue = palette.special,
    waveAqua2 = palette.regex,

    springGreen = palette.string,
    boatYellow1 = palette.character,
    boatYellow2 = palette.boolean,
    carpYellow = palette.identifier,

    sakuraPink = palette.number,
    waveRed = palette.operator,
    peachRed = palette.punctuation,
    surimiOrange = palette.constant,
    katanaGray = palette.preproc,
  }
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
      palette = translate_to_kanagawa( {
        -- Background colors
        statusline_background = adjust( "#000608" ),
        default_background = adjust( "#000c10" ),
        colorcolumn_background = adjust( "#001118" ),
        cursorline_background = adjust( "#001721" ),
        line_number_background = "#001118",
        lighter_background = "#002331",
        nontext_color = adjust( "#002939" ),

        -- UI colors
        visual_background = adjust( "#002e41" ),
        search_background = adjust( "#003449" ),

        -- Diff/Diagnostic colors
        diff_add = adjust( "#003a52" ),
        diff_change = adjust( "#00405a" ),
        diff_delete = adjust( "#004562" ),
        diff_text = adjust( "#004b6a" ),

        -- Git colors
        git_add = adjust( "#005172" ),
        git_delete = adjust( "#00577a" ),
        git_change = adjust( "#005d83" ),

        -- Special highlights
        special_keyword = adjust( "#00628b" ),
        special_builtin = adjust( "#006893" ),
        special_exception = adjust( "#006e9b" ),
        special_include = adjust( "#0074a3" ),

        -- Text colors
        dimmed_foreground = adjust( "#a1e4ff" ),
        default_foreground = adjust( "#8fdfff" ),
        comment = adjust( "#006a94" ),

        -- Syntax colors
        method = adjust( "#007baf" ), -- local
        parameter = adjust( "#0085bc" ), -- argument
        function_call = adjust( "#0096d3" ), -- function call
        statement = adjust( "#0091cc" ),
        keyword = adjust( "#009bd9" ), -- parenteses, dots
        type = adjust( "#009cdc" ), -- require
        special = adjust( "#00a2e4" ),
        regex = adjust( "#00a8ed" ),

        string = adjust( "#7fdaff" ),
        character = adjust( "#00aef5" ),
        boolean = adjust( "#0093cf" ), -- equal sign
        identifier = adjust( "#58cfff" ), -- field
        -- #58cfff

        number = adjust( "#0eb9ff" ),
        operator = adjust( "#16bbff" ),
        punctuation = adjust( "#1fbeff" ),
        constant = adjust( "#27c0ff" ),
        preproc = adjust( "#2fc3ff" ),
      } ),
      overrides = {
        Visual = { bg = adjust( "#004c6b" ) },
        Normal = { bg = brightness( "#20253a", 0.5 ) },
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
      notify_info_border = function()
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
