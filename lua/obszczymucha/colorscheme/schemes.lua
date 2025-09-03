local M = {}

local utils = require( "obszczymucha.utils" )

local function adjust( color )
  return utils.saturation( utils.brightness( color, 1.25 ), 1.5 )
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

  [ "ocean (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0a0e14" ),
        sumiInk1 = adjust( "#0c1117" ),
        sumiInk2 = adjust( "#0e131a" ),
        sumiInk3 = adjust( "#10151d" ),
        sumiInk4 = adjust( "#141b26" ),
        sumiInk5 = adjust( "#1a2332" ),
        sumiInk6 = adjust( "#2a3f5e" ),

        waveBlue1 = adjust( "#1e3a5f" ),
        waveBlue2 = adjust( "#2d4f67" ),

        winterGreen = adjust( "#1a3340" ),
        winterYellow = adjust( "#1f3a4d" ),
        winterRed = adjust( "#1a2838" ),
        winterBlue = adjust( "#252535" ),
        autumnGreen = adjust( "#4a7a8c" ),
        autumnRed = adjust( "#3a6b8c" ),
        autumnYellow = adjust( "#5c8aa8" ),

        samuraiRed = adjust( "#2980b9" ),
        roninYellow = adjust( "#3498db" ),
        waveAqua1 = adjust( "#5dade2" ),
        dragonBlue = adjust( "#658594" ),

        oldWhite = adjust( "#a8d0e6" ),
        fujiWhite = adjust( "#b8dbed" ),
        fujiGray = adjust( "#4a6b7c" ),

        oniViolet = adjust( "#5b8dbf" ),
        oniViolet2 = adjust( "#7ba7d0" ),
        crystalBlue = adjust( "#7e9cd8" ),
        springViolet1 = adjust( "#6a8caa" ),
        springViolet2 = adjust( "#7cabca" ),
        springBlue = adjust( "#7fb4ca" ),
        lightBlue = adjust( "#a3d4d5" ),
        waveAqua2 = adjust( "#7aa8af" ),

        springGreen = adjust( "#c8d8f0" ),
        boatYellow1 = adjust( "#4a7080" ),
        boatYellow2 = adjust( "#5a8090" ),
        carpYellow = adjust( "#6a90a0" ),

        sakuraPink = adjust( "#6a8fb5" ),
        waveRed = adjust( "#4a7fa8" ),
        peachRed = adjust( "#3a6f98" ),
        surimiOrange = adjust( "#5a8fb8" ),
        katanaGray = adjust( "#517c8c" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1a4a6a" ) },
        Normal = { bg = adjust( "#111418" ) },
        TelescopeNormal = { bg = adjust( "#0f1214" ) },
        TelescopeBorder = { bg = adjust( "#0f1214" ), fg = adjust( "#3a5f7a" ) },
        TelescopePromptNormal = { bg = adjust( "#0f1214" ) },
      }
    },
    custom = {
      accent = adjust( "#4a9fb8" ),
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
      cursor_line = adjust( "#5dade2" ),
      line_number = adjust( "#3a5f7a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a8d0e6" ),
    }
  },

  [ "arctic (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0e1218" ),
        sumiInk1 = adjust( "#111520" ),
        sumiInk2 = adjust( "#141825" ),
        sumiInk3 = adjust( "#171b2a" ),
        sumiInk4 = adjust( "#1c2235" ),
        sumiInk5 = adjust( "#232a3f" ),
        sumiInk6 = adjust( "#3a4a6a" ),

        waveBlue1 = adjust( "#2a4a6f" ),
        waveBlue2 = adjust( "#3a5a7f" ),

        winterGreen = adjust( "#2a4350" ),
        winterYellow = adjust( "#2f4a5d" ),
        winterRed = adjust( "#2a3848" ),
        winterBlue = adjust( "#353545" ),
        autumnGreen = adjust( "#5a8a9c" ),
        autumnRed = adjust( "#4a7b9c" ),
        autumnYellow = adjust( "#6c9ab8" ),

        samuraiRed = adjust( "#6aadd9" ),
        roninYellow = adjust( "#7abfeb" ),
        waveAqua1 = adjust( "#8dcff2" ),
        dragonBlue = adjust( "#7595a4" ),

        oldWhite = adjust( "#c8e0f6" ),
        fujiWhite = adjust( "#d8ebfd" ),
        fujiGray = adjust( "#6a8b9c" ),

        oniViolet = adjust( "#8badcf" ),
        oniViolet2 = adjust( "#9bb7e0" ),
        crystalBlue = adjust( "#9ebce8" ),
        springViolet1 = adjust( "#8aacca" ),
        springViolet2 = adjust( "#9cbbda" ),
        springBlue = adjust( "#9fc4da" ),
        lightBlue = adjust( "#c3e4e5" ),
        waveAqua2 = adjust( "#9ac8cf" ),

        springGreen = adjust( "#d8e8ff" ),
        boatYellow1 = adjust( "#6a8090" ),
        boatYellow2 = adjust( "#7a90a0" ),
        carpYellow = adjust( "#8aa0b0" ),

        sakuraPink = adjust( "#8aafc5" ),
        waveRed = adjust( "#6a9fb8" ),
        peachRed = adjust( "#5a8fa8" ),
        surimiOrange = adjust( "#7aafC8" ),
        katanaGray = adjust( "#719cac" ),
      },
      overrides = {
        Visual = { bg = adjust( "#2a5a7a" ) },
        Normal = { bg = adjust( "#15161a" ) },
        TelescopeNormal = { bg = adjust( "#111316" ) },
        TelescopeBorder = { bg = adjust( "#111316" ), fg = adjust( "#4a6f8a" ) },
        TelescopePromptNormal = { bg = adjust( "#111316" ) },
      }
    },
    custom = {
      accent = adjust( "#7abfdb" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#8dcff2" ),
      cursor_line = adjust( "#8dcff2" ),
      line_number = adjust( "#4a6f8a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#c8e0f6" ),
    }
  },

  [ "midnight (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#050810" ),
        sumiInk1 = adjust( "#070a14" ),
        sumiInk2 = adjust( "#090c18" ),
        sumiInk3 = adjust( "#0b0e1c" ),
        sumiInk4 = "#0f1424", -- line number background
        sumiInk5 = "#151a2c", -- current line background
        sumiInk6 = adjust( "#253048" ),

        waveBlue1 = adjust( "#1a2844" ),
        waveBlue2 = adjust( "#243254" ),

        winterGreen = adjust( "#101820" ),
        winterYellow = adjust( "#141c2a" ),
        winterRed = adjust( "#0f1420" ),
        winterBlue = adjust( "#1a1a2a" ),
        autumnGreen = adjust( "#3a5a6c" ),
        autumnRed = adjust( "#2a4b6c" ),
        autumnYellow = adjust( "#4c6a88" ),

        samuraiRed = adjust( "#1960a9" ),
        roninYellow = adjust( "#2478cb" ),
        waveAqua1 = adjust( "#4d8dc2" ),
        dragonBlue = adjust( "#556584" ),

        oldWhite = adjust( "#98b0c6" ),
        fujiWhite = adjust( "#a8bbd6" ),
        fujiGray = adjust( "#3a4b5c" ),

        oniViolet = adjust( "#4b6daf" ),
        oniViolet2 = adjust( "#6b87c0" ),
        crystalBlue = adjust( "#6e8cc8" ),
        springViolet1 = adjust( "#5a7caa" ),
        springViolet2 = adjust( "#6c8bba" ),
        springBlue = adjust( "#6f94ba" ),
        lightBlue = adjust( "#93b4c5" ),
        waveAqua2 = adjust( "#6a989f" ),

        springGreen = adjust( "#b8c8e0" ),
        boatYellow1 = adjust( "#3a5070" ),
        boatYellow2 = adjust( "#4a6080" ),
        carpYellow = adjust( "#5a7090" ),

        sakuraPink = adjust( "#5a7fa5" ),
        waveRed = adjust( "#3a6f98" ),
        peachRed = adjust( "#2a5f88" ),
        surimiOrange = adjust( "#4a7fa8" ),
        katanaGray = adjust( "#415c7c" ),
      },
      overrides = {
        Visual = { bg = "#1a3a5a" },
        Normal = { bg = "#0e1012" },
        TelescopeNormal = { bg = "#141416" },
        TelescopeBorder = { bg = "#141416", fg = "#4c4a69" },
        TelescopePromptNormal = { bg = "#141416" },
      }
    },
    custom = {
      accent = adjust( "#2478cb" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#4d8dc2" ),
      cursor_line = "#4d8dc2",
      line_number = adjust( "#2a4f6a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#98b0c6" ),
    }
  },

  [ "deep_sea (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#061016" ),
        sumiInk1 = adjust( "#08141a" ),
        sumiInk2 = adjust( "#0a171e" ),
        sumiInk3 = adjust( "#0c1a22" ),
        sumiInk4 = adjust( "#101e28" ),
        sumiInk5 = adjust( "#162630" ),
        sumiInk6 = adjust( "#263644" ),

        waveBlue1 = adjust( "#1e3e4e" ),
        waveBlue2 = adjust( "#2a4a5a" ),

        winterGreen = adjust( "#122230" ),
        winterYellow = adjust( "#162a38" ),
        winterRed = adjust( "#122028" ),
        winterBlue = adjust( "#1c2838" ),
        autumnGreen = adjust( "#3c6678" ),
        autumnRed = adjust( "#2c5678" ),
        autumnYellow = adjust( "#4e7690" ),

        samuraiRed = adjust( "#1e6ca6" ),
        roninYellow = adjust( "#2e88c8" ),
        waveAqua1 = adjust( "#4e9ad8" ),
        dragonBlue = adjust( "#5e7088" ),

        oldWhite = adjust( "#9abcd8" ),
        fujiWhite = adjust( "#aacce8" ),
        fujiGray = adjust( "#3c5668" ),

        oniViolet = adjust( "#4e78b8" ),
        oniViolet2 = adjust( "#6e92c8" ),
        crystalBlue = adjust( "#7098d0" ),
        springViolet1 = adjust( "#5c88a8" ),
        springViolet2 = adjust( "#6e98b8" ),
        springBlue = adjust( "#72a0c8" ),
        lightBlue = adjust( "#96c0d8" ),
        waveAqua2 = adjust( "#6ca4a8" ),

        springGreen = adjust( "#c0d0e8" ),
        boatYellow1 = adjust( "#3c5c78" ),
        boatYellow2 = adjust( "#4c6c88" ),
        carpYellow = adjust( "#5c7c98" ),

        sakuraPink = adjust( "#5c8ab8" ),
        waveRed = adjust( "#3c7aa8" ),
        peachRed = adjust( "#2c6a98" ),
        surimiOrange = adjust( "#4c8ab8" ),
        katanaGray = adjust( "#446888" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1e4666" ) },
        Normal = { bg = adjust( "#111416" ) },
        TelescopeNormal = { bg = adjust( "#0e1114" ) },
        TelescopeBorder = { bg = adjust( "#0e1114" ), fg = adjust( "#2c5a76" ) },
        TelescopePromptNormal = { bg = adjust( "#0e1114" ) },
      }
    },
    custom = {
      accent = adjust( "#2e88c8" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#4e9ad8" ),
      cursor_line = adjust( "#4e9ad8" ),
      line_number = adjust( "#2c5a76" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#9abcd8" ),
    }
  },

  [ "cyan_dream (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0a1418" ),
        sumiInk1 = adjust( "#0c181c" ),
        sumiInk2 = adjust( "#0e1c20" ),
        sumiInk3 = adjust( "#102024" ),
        sumiInk4 = adjust( "#14262c" ),
        sumiInk5 = adjust( "#1a2e36" ),
        sumiInk6 = adjust( "#2a4650" ),

        waveBlue1 = adjust( "#1e4652" ),
        waveBlue2 = adjust( "#2a5666" ),

        winterGreen = adjust( "#1a3638" ),
        winterYellow = adjust( "#1f3e42" ),
        winterRed = adjust( "#1a3034" ),
        winterBlue = adjust( "#253840" ),
        autumnGreen = adjust( "#4a8a8c" ),
        autumnRed = adjust( "#3a7a8c" ),
        autumnYellow = adjust( "#5c9aa8" ),

        samuraiRed = adjust( "#29a0a9" ),
        roninYellow = adjust( "#34b8bb" ),
        waveAqua1 = adjust( "#5dcec2" ),
        dragonBlue = adjust( "#659494" ),

        oldWhite = adjust( "#a8e0d6" ),
        fujiWhite = adjust( "#b8ede6" ),
        fujiGray = adjust( "#4a7c7c" ),

        oniViolet = adjust( "#5b9dbf" ),
        oniViolet2 = adjust( "#7bb7d0" ),
        crystalBlue = adjust( "#7ebcd8" ),
        springViolet1 = adjust( "#6a9caa" ),
        springViolet2 = adjust( "#7cbbca" ),
        springBlue = adjust( "#7fc4ca" ),
        lightBlue = adjust( "#a3e4d5" ),
        waveAqua2 = adjust( "#7ab8af" ),

        springGreen = adjust( "#c8d8f0" ),
        boatYellow1 = adjust( "#4a8080" ),
        boatYellow2 = adjust( "#5a9090" ),
        carpYellow = adjust( "#6aa0a0" ),

        sakuraPink = adjust( "#6a9fb5" ),
        waveRed = adjust( "#4a8fa8" ),
        peachRed = adjust( "#3a7f98" ),
        surimiOrange = adjust( "#5a9fb8" ),
        katanaGray = adjust( "#518c8c" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1a5a5a" ) },
        Normal = { bg = adjust( "#121516" ) },
        TelescopeNormal = { bg = adjust( "#0f1314" ) },
        TelescopeBorder = { bg = adjust( "#0f1314" ), fg = adjust( "#3a6f6a" ) },
        TelescopePromptNormal = { bg = adjust( "#0f1314" ) },
      }
    },
    custom = {
      accent = adjust( "#34b8bb" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#5dcec2" ),
      cursor_line = adjust( "#5dcec2" ),
      line_number = adjust( "#3a6f6a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a8e0d6" ),
    }
  },

  [ "sky (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0f1824" ),
        sumiInk1 = adjust( "#121c2a" ),
        sumiInk2 = adjust( "#15202f" ),
        sumiInk3 = adjust( "#182434" ),
        sumiInk4 = adjust( "#1c2a3c" ),
        sumiInk5 = adjust( "#223248" ),
        sumiInk6 = adjust( "#324a68" ),

        waveBlue1 = adjust( "#2a4a68" ),
        waveBlue2 = adjust( "#365a78" ),

        winterGreen = adjust( "#223a48" ),
        winterYellow = adjust( "#28425a" ),
        winterRed = adjust( "#223448" ),
        winterBlue = adjust( "#2e3c50" ),
        autumnGreen = adjust( "#528aac" ),
        autumnRed = adjust( "#427abc" ),
        autumnYellow = adjust( "#649ac8" ),

        samuraiRed = adjust( "#3990d9" ),
        roninYellow = adjust( "#44a8eb" ),
        waveAqua1 = adjust( "#6dbef2" ),
        dragonBlue = adjust( "#6d95b4" ),

        oldWhite = adjust( "#b0d0f6" ),
        fujiWhite = adjust( "#c0ddfd" ),
        fujiGray = adjust( "#527bac" ),

        oniViolet = adjust( "#639dcf" ),
        oniViolet2 = adjust( "#83b7e0" ),
        crystalBlue = adjust( "#86bce8" ),
        springViolet1 = adjust( "#729cca" ),
        springViolet2 = adjust( "#84bbda" ),
        springBlue = adjust( "#87c4da" ),
        lightBlue = adjust( "#abd4e5" ),
        waveAqua2 = adjust( "#82b8cf" ),

        springGreen = adjust( "#d0e0ff" ),
        boatYellow1 = adjust( "#528090" ),
        boatYellow2 = adjust( "#6290a0" ),
        carpYellow = adjust( "#72a0b0" ),

        sakuraPink = adjust( "#729fc5" ),
        waveRed = adjust( "#528fb8" ),
        peachRed = adjust( "#427fa8" ),
        surimiOrange = adjust( "#629fc8" ),
        katanaGray = adjust( "#598cac" ),
      },
      overrides = {
        Visual = { bg = adjust( "#225a8a" ) },
        Normal = { bg = adjust( "#16181c" ) },
        TelescopeNormal = { bg = adjust( "#12141a" ) },
        TelescopeBorder = { bg = adjust( "#12141a" ), fg = adjust( "#426f9a" ) },
        TelescopePromptNormal = { bg = adjust( "#12141a" ) },
      }
    },
    custom = {
      accent = adjust( "#44a8eb" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#6dbef2" ),
      cursor_line = adjust( "#6dbef2" ),
      line_number = adjust( "#426f9a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#b0d0f6" ),
    }
  },

  [ "sky2 (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0f1824" ),
        sumiInk1 = adjust( "#121c2a" ),
        sumiInk2 = adjust( "#15202f" ),
        sumiInk3 = adjust( "#182434" ),
        sumiInk4 = adjust( "#1c2a3c" ),
        sumiInk5 = adjust( "#223248" ),
        sumiInk6 = adjust( "#324a68" ),

        waveBlue1 = adjust( "#3a5f90" ),
        waveBlue2 = adjust( "#4a6fa0" ),

        winterGreen = adjust( "#2a4a70" ),
        winterYellow = adjust( "#325070" ),
        winterRed = adjust( "#2a4570" ),
        winterBlue = adjust( "#364d70" ),
        autumnGreen = adjust( "#62b0f0" ),
        autumnRed = adjust( "#529ef0" ),
        autumnYellow = adjust( "#84c8ff" ),

        samuraiRed = adjust( "#59c6ff" ),
        roninYellow = adjust( "#64ddff" ),
        waveAqua1 = adjust( "#8de8ff" ),
        dragonBlue = adjust( "#8db9e0" ),

        oldWhite = adjust( "#d0efff" ),
        fujiWhite = adjust( "#e0f8ff" ),
        fujiGray = adjust( "#729ed8" ),

        oniViolet = adjust( "#83d0ff" ),
        oniViolet2 = adjust( "#a3daff" ),
        crystalBlue = adjust( "#a6dfff" ),
        springViolet1 = adjust( "#92cfff" ),
        springViolet2 = adjust( "#a4deff" ),
        springBlue = adjust( "#a7e7ff" ),
        lightBlue = adjust( "#cbe7ff" ),
        waveAqua2 = adjust( "#a2dbff" ),

        springGreen = adjust( "#7eb9ff" ),
        boatYellow1 = adjust( "#72a5d0" ),
        boatYellow2 = adjust( "#82b5e0" ),
        carpYellow = adjust( "#92c5f0" ),

        sakuraPink = adjust( "#92d2ff" ),
        waveRed = adjust( "#72c2e8" ),
        peachRed = adjust( "#62b2d8" ),
        surimiOrange = adjust( "#82d2ff" ),
        katanaGray = adjust( "#79afec" ),
      },
      overrides = {
        Visual = { bg = adjust( "#3a7dc0" ) },
        Normal = { bg = adjust( "#16181c" ) },
        TelescopeNormal = { bg = adjust( "#12141a" ) },
        TelescopeBorder = { bg = adjust( "#12141a" ), fg = adjust( "#62a2e0" ) },
        TelescopePromptNormal = { bg = adjust( "#12141a" ) },
      }
    },
    custom = {
      accent = adjust( "#64ddff" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.7 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.95 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.5 )
      end,
      light_blue = adjust( "#8de8ff" ),
      cursor_line = adjust( "#8de8ff" ),
      line_number = adjust( "#62a2e0" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.95 )
      end,
      notify_info_body = adjust( "#d0efff" ),
    }
  },

  [ "steel (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0c0e14" ),
        sumiInk1 = adjust( "#0e111a" ),
        sumiInk2 = adjust( "#10141e" ),
        sumiInk3 = adjust( "#121722" ),
        sumiInk4 = adjust( "#161b28" ),
        sumiInk5 = adjust( "#1c2232" ),
        sumiInk6 = adjust( "#2c3a4e" ),

        waveBlue1 = adjust( "#243244" ),
        waveBlue2 = adjust( "#304254" ),

        winterGreen = adjust( "#1c2a34" ),
        winterYellow = adjust( "#22323e" ),
        winterRed = adjust( "#1c2630" ),
        winterBlue = adjust( "#282c3a" ),
        autumnGreen = adjust( "#4c6a7c" ),
        autumnRed = adjust( "#3c5a7c" ),
        autumnYellow = adjust( "#5e7a98" ),

        samuraiRed = adjust( "#2970a9" ),
        roninYellow = adjust( "#3488cb" ),
        waveAqua1 = adjust( "#5d9ec2" ),
        dragonBlue = adjust( "#657584" ),

        oldWhite = adjust( "#a8c0d6" ),
        fujiWhite = adjust( "#b8cde6" ),
        fujiGray = adjust( "#4a5b6c" ),

        oniViolet = adjust( "#5b7daf" ),
        oniViolet2 = adjust( "#7b97c0" ),
        crystalBlue = adjust( "#7e9cc8" ),
        springViolet1 = adjust( "#6a8caa" ),
        springViolet2 = adjust( "#7c9bba" ),
        springBlue = adjust( "#7fa4ba" ),
        lightBlue = adjust( "#a3c4d5" ),
        waveAqua2 = adjust( "#7aa89f" ),

        springGreen = adjust( "#c8d8e0" ),
        boatYellow1 = adjust( "#4a6070" ),
        boatYellow2 = adjust( "#5a7080" ),
        carpYellow = adjust( "#6a8090" ),

        sakuraPink = adjust( "#6a8fa5" ),
        waveRed = adjust( "#4a7f98" ),
        peachRed = adjust( "#3a6f88" ),
        surimiOrange = adjust( "#5a8fa8" ),
        katanaGray = adjust( "#516c7c" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1e3a4a" ) },
        Normal = { bg = adjust( "#111416" ) },
        TelescopeNormal = { bg = adjust( "#0f1114" ) },
        TelescopeBorder = { bg = adjust( "#0f1114" ), fg = adjust( "#3a4f5a" ) },
        TelescopePromptNormal = { bg = adjust( "#0f1114" ) },
      }
    },
    custom = {
      accent = adjust( "#3488cb" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#5d9ec2" ),
      cursor_line = adjust( "#5d9ec2" ),
      line_number = adjust( "#3a4f5a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a8c0d6" ),
    }
  },

  [ "cobalt (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0a0c18" ),
        sumiInk1 = adjust( "#0c0e1c" ),
        sumiInk2 = adjust( "#0e1020" ),
        sumiInk3 = adjust( "#101224" ),
        sumiInk4 = adjust( "#14162c" ),
        sumiInk5 = adjust( "#1a1c36" ),
        sumiInk6 = adjust( "#2a2c50" ),

        waveBlue1 = adjust( "#1e2652" ),
        waveBlue2 = adjust( "#2a3666" ),

        winterGreen = adjust( "#1a2238" ),
        winterYellow = adjust( "#1f2a42" ),
        winterRed = adjust( "#1a2034" ),
        winterBlue = adjust( "#252840" ),
        autumnGreen = adjust( "#4a5a8c" ),
        autumnRed = adjust( "#3a4a8c" ),
        autumnYellow = adjust( "#5c6aa8" ),

        samuraiRed = adjust( "#2950b9" ),
        roninYellow = adjust( "#3468db" ),
        waveAqua1 = adjust( "#5d7ee2" ),
        dragonBlue = adjust( "#655594" ),

        oldWhite = adjust( "#a8b0e6" ),
        fujiWhite = adjust( "#b8bded" ),
        fujiGray = adjust( "#4a4b7c" ),

        oniViolet = adjust( "#5b5dbf" ),
        oniViolet2 = adjust( "#7b77d0" ),
        crystalBlue = adjust( "#7e7cd8" ),
        springViolet1 = adjust( "#6a6caa" ),
        springViolet2 = adjust( "#7c7bca" ),
        springBlue = adjust( "#7f84ca" ),
        lightBlue = adjust( "#a3a4d5" ),
        waveAqua2 = adjust( "#7a88af" ),

        springGreen = adjust( "#6c88bb" ),
        boatYellow1 = adjust( "#4a4080" ),
        boatYellow2 = adjust( "#5a5090" ),
        carpYellow = adjust( "#6a60a0" ),

        sakuraPink = adjust( "#6a6fb5" ),
        waveRed = adjust( "#4a5fa8" ),
        peachRed = adjust( "#3a4f98" ),
        surimiOrange = adjust( "#5a6fb8" ),
        katanaGray = adjust( "#514c8c" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1e2a6a" ) },
        Normal = { bg = adjust( "#101214" ) },
        TelescopeNormal = { bg = adjust( "#0e1012" ) },
        TelescopeBorder = { bg = adjust( "#0e1012" ), fg = adjust( "#3a3f7a" ) },
        TelescopePromptNormal = { bg = adjust( "#0e1012" ) },
      }
    },
    custom = {
      accent = adjust( "#3468db" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#5d7ee2" ),
      cursor_line = adjust( "#5d7ee2" ),
      line_number = adjust( "#3a3f7a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a8b0e6" ),
    }
  },

  [ "cobalt2 (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0a0c18" ),
        sumiInk1 = adjust( "#0c0e1c" ),
        sumiInk2 = adjust( "#0e1020" ),
        sumiInk3 = adjust( "#101224" ),
        sumiInk4 = adjust( "#14162c" ),
        sumiInk5 = adjust( "#1a1c36" ),
        sumiInk6 = adjust( "#2a2c50" ),

        waveBlue1 = adjust( "#2e3662" ),
        waveBlue2 = adjust( "#3a4676" ),

        winterGreen = adjust( "#2a2248" ),
        winterYellow = adjust( "#2f3052" ),
        winterRed = adjust( "#2a2044" ),
        winterBlue = adjust( "#353850" ),
        autumnGreen = adjust( "#6a7aac" ),
        autumnRed = adjust( "#5a6aac" ),
        autumnYellow = adjust( "#7c8ac8" ),

        samuraiRed = adjust( "#4970d9" ),
        roninYellow = adjust( "#5488fb" ),
        waveAqua1 = adjust( "#7d9eff" ),
        dragonBlue = adjust( "#8575b4" ),

        oldWhite = adjust( "#c8d0ff" ),
        fujiWhite = adjust( "#d8e0ff" ),
        fujiGray = adjust( "#6a6b9c" ),

        oniViolet = adjust( "#7b7ddf" ),
        oniViolet2 = adjust( "#9b97f0" ),
        crystalBlue = adjust( "#9e9cf8" ),
        springViolet1 = adjust( "#8a8cca" ),
        springViolet2 = adjust( "#9c9bea" ),
        springBlue = adjust( "#9f84ea" ),
        lightBlue = adjust( "#c3c4f5" ),
        waveAqua2 = adjust( "#9aa8cf" ),

        springGreen = adjust( "#c8d0ff" ),
        boatYellow1 = adjust( "#6a60a0" ),
        boatYellow2 = adjust( "#7a70b0" ),
        carpYellow = adjust( "#8a80c0" ),

        sakuraPink = adjust( "#8a8fd5" ),
        waveRed = adjust( "#6a7fc8" ),
        peachRed = adjust( "#5a6fb8" ),
        surimiOrange = adjust( "#7a8fd8" ),
        katanaGray = adjust( "#716cac" ),
      },
      overrides = {
        Visual = { bg = adjust( "#3e4a8a" ) },
        Normal = { bg = adjust( "#101214" ) },
        TelescopeNormal = { bg = adjust( "#0e1012" ) },
        TelescopeBorder = { bg = adjust( "#0e1012" ), fg = adjust( "#5a5f9a" ) },
        TelescopePromptNormal = { bg = adjust( "#0e1012" ) },
      }
    },
    custom = {
      accent = adjust( "#5488fb" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.7 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.95 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.5 )
      end,
      light_blue = adjust( "#7d9eff" ),
      cursor_line = adjust( "#7d9eff" ),
      line_number = adjust( "#5a5f9a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.95 )
      end,
      notify_info_body = adjust( "#c8d0ff" ),
    }
  },

  [ "frost (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#101620" ),
        sumiInk1 = adjust( "#131a26" ),
        sumiInk2 = adjust( "#161e2c" ),
        sumiInk3 = adjust( "#192232" ),
        sumiInk4 = adjust( "#1d283a" ),
        sumiInk5 = adjust( "#233046" ),
        sumiInk6 = adjust( "#334860" ),

        waveBlue1 = adjust( "#2b4862" ),
        waveBlue2 = adjust( "#375872" ),

        winterGreen = adjust( "#233846" ),
        winterYellow = adjust( "#294052" ),
        winterRed = adjust( "#233442" ),
        winterBlue = adjust( "#2f3c4c" ),
        autumnGreen = adjust( "#5388a8" ),
        autumnRed = adjust( "#4378b8" ),
        autumnYellow = adjust( "#6598c4" ),

        samuraiRed = adjust( "#3a8ed4" ),
        roninYellow = adjust( "#45a6e6" ),
        waveAqua1 = adjust( "#6ebcee" ),
        dragonBlue = adjust( "#6e93b0" ),

        oldWhite = adjust( "#b1cef2" ),
        fujiWhite = adjust( "#c1dbf9" ),
        fujiGray = adjust( "#5379a8" ),

        oniViolet = adjust( "#649bcb" ),
        oniViolet2 = adjust( "#84b5dc" ),
        crystalBlue = adjust( "#87bae4" ),
        springViolet1 = adjust( "#739ac6" ),
        springViolet2 = adjust( "#85b9d6" ),
        springBlue = adjust( "#88c2d6" ),
        lightBlue = adjust( "#acd2e1" ),
        waveAqua2 = adjust( "#83b6cb" ),

        springGreen = adjust( "#d0e8ff" ),
        boatYellow1 = adjust( "#537e8c" ),
        boatYellow2 = adjust( "#638e9c" ),
        carpYellow = adjust( "#739eac" ),

        sakuraPink = adjust( "#739dc1" ),
        waveRed = adjust( "#538db4" ),
        peachRed = adjust( "#437da4" ),
        surimiOrange = adjust( "#639dc4" ),
        katanaGray = adjust( "#5a8aa8" ),
      },
      overrides = {
        Visual = { bg = adjust( "#235886" ) },
        Normal = { bg = adjust( "#15171c" ) },
        TelescopeNormal = { bg = adjust( "#121418" ) },
        TelescopeBorder = { bg = adjust( "#121418" ), fg = adjust( "#436d96" ) },
        TelescopePromptNormal = { bg = adjust( "#121418" ) },
      }
    },
    custom = {
      accent = adjust( "#45a6e6" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#6ebcee" ),
      cursor_line = adjust( "#6ebcee" ),
      line_number = adjust( "#436d96" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#b1cef2" ),
    }
  },

  [ "teal_night (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#081214" ),
        sumiInk1 = adjust( "#0a1618" ),
        sumiInk2 = adjust( "#0c1a1c" ),
        sumiInk3 = adjust( "#0e1e20" ),
        sumiInk4 = adjust( "#122426" ),
        sumiInk5 = adjust( "#182c30" ),
        sumiInk6 = adjust( "#284446" ),

        waveBlue1 = adjust( "#204450" ),
        waveBlue2 = adjust( "#2c5460" ),

        winterGreen = adjust( "#143436" ),
        winterYellow = adjust( "#1a3c40" ),
        winterRed = adjust( "#14302e" ),
        winterBlue = adjust( "#203842" ),
        autumnGreen = adjust( "#408480" ),
        autumnRed = adjust( "#307490" ),
        autumnYellow = adjust( "#5294a0" ),

        samuraiRed = adjust( "#258aa0" ),
        roninYellow = adjust( "#30a2b2" ),
        waveAqua1 = adjust( "#59b8c8" ),
        dragonBlue = adjust( "#5b8e90" ),

        oldWhite = adjust( "#a4cace" ),
        fujiWhite = adjust( "#b4d7de" ),
        fujiGray = adjust( "#467674" ),

        oniViolet = adjust( "#5797b4" ),
        oniViolet2 = adjust( "#77b1c4" ),
        crystalBlue = adjust( "#7ab6ce" ),
        springViolet1 = adjust( "#6696a4" ),
        springViolet2 = adjust( "#78b5c4" ),
        springBlue = adjust( "#7bbec4" ),
        lightBlue = adjust( "#9fcecc" ),
        waveAqua2 = adjust( "#76b2ac" ),

        springGreen = adjust( "#c8e0e0" ),
        boatYellow1 = adjust( "#467a7c" ),
        boatYellow2 = adjust( "#568a8c" ),
        carpYellow = adjust( "#669a9c" ),

        sakuraPink = adjust( "#6699ac" ),
        waveRed = adjust( "#468994" ),
        peachRed = adjust( "#367984" ),
        surimiOrange = adjust( "#5699a4" ),
        katanaGray = adjust( "#4d8684" ),
      },
      overrides = {
        Visual = { bg = adjust( "#185456" ) },
        Normal = { bg = adjust( "#111516" ) },
        TelescopeNormal = { bg = adjust( "#0e1214" ) },
        TelescopeBorder = { bg = adjust( "#0e1214" ), fg = adjust( "#366966" ) },
        TelescopePromptNormal = { bg = adjust( "#0e1214" ) },
      }
    },
    custom = {
      accent = adjust( "#30a2b2" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#59b8c8" ),
      cursor_line = adjust( "#59b8c8" ),
      line_number = adjust( "#366966" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a4cace" ),
    }
  },

  [ "blueish (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0a0e14" ),
        sumiInk1 = adjust( "#0c1117" ),
        sumiInk2 = adjust( "#0e131a" ),
        sumiInk3 = adjust( "#10151d" ),
        sumiInk4 = adjust( "#141b26" ),
        sumiInk5 = adjust( "#1a2332" ),
        sumiInk6 = adjust( "#2a3f5e" ),

        waveBlue1 = adjust( "#1e3a5f" ),
        waveBlue2 = adjust( "#2d4f67" ),

        winterGreen = adjust( "#1a3340" ),
        winterYellow = adjust( "#1f3a4d" ),
        winterRed = adjust( "#1a2838" ),
        winterBlue = adjust( "#252535" ),
        autumnGreen = adjust( "#4a7a8c" ),
        autumnRed = adjust( "#3a6b8c" ),
        autumnYellow = adjust( "#5c8aa8" ),

        samuraiRed = adjust( "#2980b9" ),
        roninYellow = adjust( "#3498db" ),
        waveAqua1 = adjust( "#5dade2" ),
        dragonBlue = adjust( "#658594" ),

        oldWhite = adjust( "#a8d0e6" ),
        fujiWhite = adjust( "#b8dbed" ),
        fujiGray = adjust( "#4a6b7c" ),

        oniViolet = adjust( "#5b8dbf" ),
        oniViolet2 = adjust( "#7ba7d0" ),
        crystalBlue = adjust( "#7e9cd8" ),
        springViolet1 = adjust( "#6a8caa" ),
        springViolet2 = adjust( "#7cabca" ),
        springBlue = adjust( "#7fb4ca" ),
        lightBlue = adjust( "#a3d4d5" ),
        waveAqua2 = adjust( "#7aa8af" ),

        springGreen = adjust( "#bac9df" ),
        boatYellow1 = adjust( "#4a7080" ),
        boatYellow2 = adjust( "#5a8090" ),
        carpYellow = adjust( "#6a90a0" ),

        sakuraPink = adjust( "#6a8fb5" ),
        waveRed = adjust( "#4a7fa8" ),
        peachRed = adjust( "#3a6f98" ),
        surimiOrange = adjust( "#5a8fb8" ),
        katanaGray = adjust( "#517c8c" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1a4a6a" ) },
        Normal = { bg = adjust( "#111418" ) },
        TelescopeNormal = { bg = adjust( "#0f1214" ) },
        TelescopeBorder = { bg = adjust( "#0f1214" ), fg = adjust( "#3a5f7a" ) },
        TelescopePromptNormal = { bg = adjust( "#0f1214" ) },
      }
    },
    custom = {
      accent = adjust( "#4a9fb8" ),
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
      cursor_line = adjust( "#5dade2" ),
      line_number = adjust( "#3a5f7a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a8d0e6" ),
    }
  },

  [ "forest (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0a140e" ),
        sumiInk1 = adjust( "#0c180f" ),
        sumiInk2 = adjust( "#0e1c11" ),
        sumiInk3 = adjust( "#102013" ),
        sumiInk4 = adjust( "#142617" ),
        sumiInk5 = adjust( "#1a321d" ),
        sumiInk6 = adjust( "#2a4e2f" ),

        waveBlue1 = adjust( "#1e4a35" ),
        waveBlue2 = adjust( "#2d5e47" ),

        winterGreen = adjust( "#1a3628" ),
        winterYellow = adjust( "#1f3a2d" ),
        winterRed = adjust( "#1a2e24" ),
        winterBlue = adjust( "#253530" ),
        autumnGreen = adjust( "#4a8052" ),
        autumnRed = adjust( "#3a7042" ),
        autumnYellow = adjust( "#5c9060" ),

        samuraiRed = adjust( "#29a045" ),
        roninYellow = adjust( "#34b857" ),
        waveAqua1 = adjust( "#5dce6f" ),
        dragonBlue = adjust( "#659462" ),

        oldWhite = adjust( "#a8e0b2" ),
        fujiWhite = adjust( "#b8edc2" ),
        fujiGray = adjust( "#4a7c56" ),

        oniViolet = adjust( "#5b9d6a" ),
        oniViolet2 = adjust( "#7bb780" ),
        crystalBlue = adjust( "#7ebc8a" ),
        springViolet1 = adjust( "#6a9c76" ),
        springViolet2 = adjust( "#7cbb8c" ),
        springBlue = adjust( "#7fc495" ),
        lightBlue = adjust( "#a3e4af" ),
        waveAqua2 = adjust( "#7ab896" ),

        springGreen = adjust( "#d0f0c0" ),
        boatYellow1 = adjust( "#4a8055" ),
        boatYellow2 = adjust( "#5a9065" ),
        carpYellow = adjust( "#6aa075" ),

        sakuraPink = adjust( "#6a9f7a" ),
        waveRed = adjust( "#4a8f6a" ),
        peachRed = adjust( "#3a7f5a" ),
        surimiOrange = adjust( "#5a9f7a" ),
        katanaGray = adjust( "#518c67" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1a4a35" ) },
        Normal = { bg = adjust( "#111514" ) },
        TelescopeNormal = { bg = adjust( "#0e1212" ) },
        TelescopeBorder = { bg = adjust( "#0e1212" ), fg = adjust( "#3a5f45" ) },
        TelescopePromptNormal = { bg = adjust( "#0e1212" ) },
      }
    },
    custom = {
      accent = adjust( "#34b857" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#5dce6f" ),
      cursor_line = adjust( "#5dce6f" ),
      line_number = adjust( "#3a5f45" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a8e0b2" ),
    }
  },

  [ "emerald (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#08141a" ),
        sumiInk1 = adjust( "#0a181d" ),
        sumiInk2 = adjust( "#0c1c20" ),
        sumiInk3 = adjust( "#0e2023" ),
        sumiInk4 = adjust( "#122629" ),
        sumiInk5 = adjust( "#182e33" ),
        sumiInk6 = adjust( "#284649" ),

        waveBlue1 = adjust( "#1e464f" ),
        waveBlue2 = adjust( "#2a5663" ),

        winterGreen = adjust( "#1a3a3f" ),
        winterYellow = adjust( "#1f4045" ),
        winterRed = adjust( "#1a3237" ),
        winterBlue = adjust( "#253842" ),
        autumnGreen = adjust( "#4a847f" ),
        autumnRed = adjust( "#3a746f" ),
        autumnYellow = adjust( "#5c949f" ),

        samuraiRed = adjust( "#2997a5" ),
        roninYellow = adjust( "#34afbd" ),
        waveAqua1 = adjust( "#5dc5d3" ),
        dragonBlue = adjust( "#65949a" ),

        oldWhite = adjust( "#a8dde3" ),
        fujiWhite = adjust( "#96bfc5" ),
        fujiGray = adjust( "#4a7a7f" ),

        oniViolet = adjust( "#5b9ba6" ),
        oniViolet2 = adjust( "#7bb5c0" ),
        crystalBlue = adjust( "#7ebaca" ),
        springViolet1 = adjust( "#6a9aa5" ),
        springViolet2 = adjust( "#7cb9c4" ),
        springBlue = adjust( "#7fc2c7" ),
        lightBlue = adjust( "#a3e2e7" ),
        waveAqua2 = adjust( "#7ab6bb" ),

        springGreen = adjust( "#80bc98" ),
        boatYellow1 = adjust( "#4a7e83" ),
        boatYellow2 = adjust( "#5a8e93" ),
        carpYellow = adjust( "#6a9ea3" ),

        sakuraPink = adjust( "#6a9db8" ),
        waveRed = adjust( "#4a8da2" ),
        peachRed = adjust( "#3a7d92" ),
        surimiOrange = adjust( "#5a9db8" ),
        katanaGray = adjust( "#518a9f" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1a4a55" ) },
        Normal = { bg = adjust( "#111516" ) },
        TelescopeNormal = { bg = adjust( "#0d1214" ) },
        TelescopeBorder = { bg = adjust( "#0d1214" ), fg = adjust( "#3a5f6a" ) },
        TelescopePromptNormal = { bg = adjust( "#0d1214" ) },
      }
    },
    custom = {
      accent = adjust( "#34afbd" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#5dc5d3" ),
      cursor_line = adjust( "#5dc5d3" ),
      line_number = adjust( "#3a5f6a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a8dde3" ),
    }
  },

  [ "jade (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#061418" ),
        sumiInk1 = adjust( "#08181c" ),
        sumiInk2 = adjust( "#0a1c20" ),
        sumiInk3 = adjust( "#0c2024" ),
        sumiInk4 = adjust( "#102628" ),
        sumiInk5 = adjust( "#162c30" ),
        sumiInk6 = adjust( "#26444c" ),

        waveBlue1 = adjust( "#1c444c" ),
        waveBlue2 = adjust( "#285460" ),

        winterGreen = adjust( "#18363e" ),
        winterYellow = adjust( "#1d3e46" ),
        winterRed = adjust( "#182e36" ),
        winterBlue = adjust( "#233640" ),
        autumnGreen = adjust( "#48827a" ),
        autumnRed = adjust( "#38726a" ),
        autumnYellow = adjust( "#5a929a" ),

        samuraiRed = adjust( "#27959d" ),
        roninYellow = adjust( "#32adb5" ),
        waveAqua1 = adjust( "#5bc3cb" ),
        dragonBlue = adjust( "#639298" ),

        oldWhite = adjust( "#a6dbe1" ),
        fujiWhite = adjust( "#b6e8ee" ),
        fujiGray = adjust( "#48787e" ),

        oniViolet = adjust( "#5999a4" ),
        oniViolet2 = adjust( "#79b3be" ),
        crystalBlue = adjust( "#7cb8c8" ),
        springViolet1 = adjust( "#6898a3" ),
        springViolet2 = adjust( "#7ab7c2" ),
        springBlue = adjust( "#7dc0c5" ),
        lightBlue = adjust( "#a1e0e5" ),
        waveAqua2 = adjust( "#78b4b9" ),

        springGreen = adjust( "#c8f0e0" ),
        boatYellow1 = adjust( "#487c81" ),
        boatYellow2 = adjust( "#588c91" ),
        carpYellow = adjust( "#689ca1" ),

        sakuraPink = adjust( "#689bb6" ),
        waveRed = adjust( "#488ba0" ),
        peachRed = adjust( "#387b90" ),
        surimiOrange = adjust( "#589bb6" ),
        katanaGray = adjust( "#4f889d" ),
      },
      overrides = {
        Visual = { bg = adjust( "#184853" ) },
        Normal = { bg = adjust( "#101516" ) },
        TelescopeNormal = { bg = adjust( "#0c1214" ) },
        TelescopeBorder = { bg = adjust( "#0c1214" ), fg = adjust( "#385d68" ) },
        TelescopePromptNormal = { bg = adjust( "#0c1214" ) },
      }
    },
    custom = {
      accent = adjust( "#32adb5" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#5bc3cb" ),
      cursor_line = adjust( "#5bc3cb" ),
      line_number = adjust( "#385d68" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a6dbe1" ),
    }
  },

  [ "mint (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0e1814" ),
        sumiInk1 = adjust( "#111c17" ),
        sumiInk2 = adjust( "#14201a" ),
        sumiInk3 = adjust( "#17241d" ),
        sumiInk4 = adjust( "#1b2a23" ),
        sumiInk5 = adjust( "#213229" ),
        sumiInk6 = adjust( "#314a3f" ),

        waveBlue1 = adjust( "#294a40" ),
        waveBlue2 = adjust( "#355a50" ),

        winterGreen = adjust( "#213a32" ),
        winterYellow = adjust( "#264237" ),
        winterRed = adjust( "#21342e" ),
        winterBlue = adjust( "#2c3c38" ),
        autumnGreen = adjust( "#518a7c" ),
        autumnRed = adjust( "#417a6c" ),
        autumnYellow = adjust( "#639a8c" ),

        samuraiRed = adjust( "#38a090" ),
        roninYellow = adjust( "#43b8a8" ),
        waveAqua1 = adjust( "#6cced3" ),
        dragonBlue = adjust( "#6c95a0" ),

        oldWhite = adjust( "#afe0dc" ),
        fujiWhite = adjust( "#bfede9" ),
        fujiGray = adjust( "#518076" ),

        oniViolet = adjust( "#629daa" ),
        oniViolet2 = adjust( "#82b7c4" ),
        crystalBlue = adjust( "#85bcd0" ),
        springViolet1 = adjust( "#719ca9" ),
        springViolet2 = adjust( "#83bbc8" ),
        springBlue = adjust( "#86c4cb" ),
        lightBlue = adjust( "#aae4e1" ),
        waveAqua2 = adjust( "#81b8bd" ),

        springGreen = adjust( "#d8f0e8" ),
        boatYellow1 = adjust( "#51808d" ),
        boatYellow2 = adjust( "#61909d" ),
        carpYellow = adjust( "#71a0ad" ),

        sakuraPink = adjust( "#719fc2" ),
        waveRed = adjust( "#5195aa" ),
        peachRed = adjust( "#4185a0" ),
        surimiOrange = adjust( "#619fc2" ),
        katanaGray = adjust( "#588ca1" ),
      },
      overrides = {
        Visual = { bg = adjust( "#215a50" ) },
        Normal = { bg = adjust( "#141716" ) },
        TelescopeNormal = { bg = adjust( "#111414" ) },
        TelescopeBorder = { bg = adjust( "#111414" ), fg = adjust( "#416166" ) },
        TelescopePromptNormal = { bg = adjust( "#111414" ) },
      }
    },
    custom = {
      accent = adjust( "#43b8a8" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#6cced3" ),
      cursor_line = adjust( "#6cced3" ),
      line_number = adjust( "#416166" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#afe0dc" ),
    }
  },

  [ "sage (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#101810" ),
        sumiInk1 = adjust( "#131c13" ),
        sumiInk2 = adjust( "#162016" ),
        sumiInk3 = adjust( "#192419" ),
        sumiInk4 = adjust( "#1d2a1f" ),
        sumiInk5 = adjust( "#233225" ),
        sumiInk6 = adjust( "#334a3b" ),

        waveBlue1 = adjust( "#2b4a3d" ),
        waveBlue2 = adjust( "#375a4d" ),

        winterGreen = adjust( "#233a30" ),
        winterYellow = adjust( "#284235" ),
        winterRed = adjust( "#23342c" ),
        winterBlue = adjust( "#2e3c34" ),
        autumnGreen = adjust( "#538a78" ),
        autumnRed = adjust( "#437a68" ),
        autumnYellow = adjust( "#659a88" ),

        samuraiRed = adjust( "#3aa08c" ),
        roninYellow = adjust( "#45b89e" ),
        waveAqua1 = adjust( "#6eced1" ),
        dragonBlue = adjust( "#6e959e" ),

        oldWhite = adjust( "#b1e0da" ),
        fujiWhite = adjust( "#c1ede7" ),
        fujiGray = adjust( "#537e74" ),

        oniViolet = adjust( "#649da8" ),
        oniViolet2 = adjust( "#84b7c2" ),
        crystalBlue = adjust( "#87bcce" ),
        springViolet1 = adjust( "#739ca7" ),
        springViolet2 = adjust( "#85bbc6" ),
        springBlue = adjust( "#88c4c9" ),
        lightBlue = adjust( "#ace4df" ),
        waveAqua2 = adjust( "#83b8bb" ),

        springGreen = adjust( "#d8f8e0" ),
        boatYellow1 = adjust( "#53808b" ),
        boatYellow2 = adjust( "#63909b" ),
        carpYellow = adjust( "#73a0ab" ),

        sakuraPink = adjust( "#739fc0" ),
        waveRed = adjust( "#5395a8" ),
        peachRed = adjust( "#43859e" ),
        surimiOrange = adjust( "#639fc0" ),
        katanaGray = adjust( "#5a8c9f" ),
      },
      overrides = {
        Visual = { bg = adjust( "#235a4d" ) },
        Normal = { bg = adjust( "#161716" ) },
        TelescopeNormal = { bg = adjust( "#121412" ) },
        TelescopeBorder = { bg = adjust( "#121412" ), fg = adjust( "#436164" ) },
        TelescopePromptNormal = { bg = adjust( "#121412" ) },
      }
    },
    custom = {
      accent = adjust( "#45b89e" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#6eced1" ),
      cursor_line = adjust( "#6eced1" ),
      line_number = adjust( "#436164" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#b1e0da" ),
    }
  },

  [ "sea_foam (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0c1614" ),
        sumiInk1 = adjust( "#0f1a17" ),
        sumiInk2 = adjust( "#121e1a" ),
        sumiInk3 = adjust( "#15221d" ),
        sumiInk4 = adjust( "#192823" ),
        sumiInk5 = adjust( "#1f3029" ),
        sumiInk6 = adjust( "#2f483f" ),

        waveBlue1 = adjust( "#27483b" ),
        waveBlue2 = adjust( "#33584b" ),

        winterGreen = adjust( "#1f382e" ),
        winterYellow = adjust( "#244033" ),
        winterRed = adjust( "#1f322a" ),
        winterBlue = adjust( "#2a3a32" ),
        autumnGreen = adjust( "#4f8a76" ),
        autumnRed = adjust( "#3f7a66" ),
        autumnYellow = adjust( "#619a86" ),

        samuraiRed = adjust( "#36a08a" ),
        roninYellow = adjust( "#41b89c" ),
        waveAqua1 = adjust( "#6acecf" ),
        dragonBlue = adjust( "#6a959c" ),

        oldWhite = adjust( "#ade0d8" ),
        fujiWhite = adjust( "#bdede5" ),
        fujiGray = adjust( "#4f7e72" ),

        oniViolet = adjust( "#609da6" ),
        oniViolet2 = adjust( "#80b7c0" ),
        crystalBlue = adjust( "#83bccc" ),
        springViolet1 = adjust( "#6f9ca5" ),
        springViolet2 = adjust( "#81bbc4" ),
        springBlue = adjust( "#84c4c7" ),
        lightBlue = adjust( "#a8e4dd" ),
        waveAqua2 = adjust( "#7fb8b9" ),

        springGreen = adjust( "#d0f0e0" ),
        boatYellow1 = adjust( "#4f8089" ),
        boatYellow2 = adjust( "#5f9099" ),
        carpYellow = adjust( "#6fa0a9" ),

        sakuraPink = adjust( "#6f9fbe" ),
        waveRed = adjust( "#4f95a6" ),
        peachRed = adjust( "#3f859c" ),
        surimiOrange = adjust( "#5f9fbe" ),
        katanaGray = adjust( "#568c9d" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1f584b" ) },
        Normal = { bg = adjust( "#131616" ) },
        TelescopeNormal = { bg = adjust( "#0f1314" ) },
        TelescopeBorder = { bg = adjust( "#0f1314" ), fg = adjust( "#3f6162" ) },
        TelescopePromptNormal = { bg = adjust( "#0f1314" ) },
      }
    },
    custom = {
      accent = adjust( "#41b89c" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#6acecf" ),
      cursor_line = adjust( "#6acecf" ),
      line_number = adjust( "#3f6162" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#ade0d8" ),
    }
  },

  [ "turquoise (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0a1416" ),
        sumiInk1 = adjust( "#0d1819" ),
        sumiInk2 = adjust( "#101c1c" ),
        sumiInk3 = adjust( "#13201f" ),
        sumiInk4 = adjust( "#172625" ),
        sumiInk5 = adjust( "#1d2e2b" ),
        sumiInk6 = adjust( "#2d4641" ),

        waveBlue1 = adjust( "#254639" ),
        waveBlue2 = adjust( "#315649" ),

        winterGreen = adjust( "#1d362c" ),
        winterYellow = adjust( "#223e31" ),
        winterRed = adjust( "#1d3028" ),
        winterBlue = adjust( "#283830" ),
        autumnGreen = adjust( "#4d8874" ),
        autumnRed = adjust( "#3d7864" ),
        autumnYellow = adjust( "#5f9884" ),

        samuraiRed = adjust( "#349e88" ),
        roninYellow = adjust( "#3fb69a" ),
        waveAqua1 = adjust( "#68cccd" ),
        dragonBlue = adjust( "#68939a" ),

        oldWhite = adjust( "#abddd6" ),
        fujiWhite = adjust( "#bbeae3" ),
        fujiGray = adjust( "#4d7c70" ),

        oniViolet = adjust( "#5e9ba4" ),
        oniViolet2 = adjust( "#7eb5be" ),
        crystalBlue = adjust( "#81baca" ),
        springViolet1 = adjust( "#6d9aa3" ),
        springViolet2 = adjust( "#7fb9c2" ),
        springBlue = adjust( "#82c2c5" ),
        lightBlue = adjust( "#a6e2db" ),
        waveAqua2 = adjust( "#7db6b7" ),

        springGreen = adjust( "#d0f8e8" ),
        boatYellow1 = adjust( "#4d7e87" ),
        boatYellow2 = adjust( "#5d8e97" ),
        carpYellow = adjust( "#6d9ea7" ),

        sakuraPink = adjust( "#6d9dbc" ),
        waveRed = adjust( "#4d93a4" ),
        peachRed = adjust( "#3d839a" ),
        surimiOrange = adjust( "#5d9dbc" ),
        katanaGray = adjust( "#548a9b" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1d5649" ) },
        Normal = { bg = adjust( "#121616" ) },
        TelescopeNormal = { bg = adjust( "#0e1314" ) },
        TelescopeBorder = { bg = adjust( "#0e1314" ), fg = adjust( "#3d5f60" ) },
        TelescopePromptNormal = { bg = adjust( "#0e1314" ) },
      }
    },
    custom = {
      accent = adjust( "#3fb69a" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#68cccd" ),
      cursor_line = adjust( "#68cccd" ),
      line_number = adjust( "#3d5f60" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#abddd6" ),
    }
  },

  [ "aqua (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#061214" ),
        sumiInk1 = adjust( "#091617" ),
        sumiInk2 = adjust( "#0c1a1a" ),
        sumiInk3 = adjust( "#0f1e1d" ),
        sumiInk4 = adjust( "#132423" ),
        sumiInk5 = adjust( "#192c29" ),
        sumiInk6 = adjust( "#29443f" ),

        waveBlue1 = adjust( "#234437" ),
        waveBlue2 = adjust( "#2f5447" ),

        winterGreen = adjust( "#1b342a" ),
        winterYellow = adjust( "#203c2f" ),
        winterRed = adjust( "#1b2e26" ),
        winterBlue = adjust( "#26362e" ),
        autumnGreen = adjust( "#4b8672" ),
        autumnRed = adjust( "#3b7662" ),
        autumnYellow = adjust( "#5d9682" ),

        samuraiRed = adjust( "#329c86" ),
        roninYellow = adjust( "#3db498" ),
        waveAqua1 = adjust( "#66cacb" ),
        dragonBlue = adjust( "#669198" ),

        oldWhite = adjust( "#a9dbd4" ),
        fujiWhite = adjust( "#b9e8e1" ),
        fujiGray = adjust( "#4b7a6e" ),

        oniViolet = adjust( "#5c99a2" ),
        oniViolet2 = adjust( "#7cb3bc" ),
        crystalBlue = adjust( "#7fb8c8" ),
        springViolet1 = adjust( "#6b98a1" ),
        springViolet2 = adjust( "#7db7c0" ),
        springBlue = adjust( "#80c0c3" ),
        lightBlue = adjust( "#a4e0d9" ),
        waveAqua2 = adjust( "#7bb4b5" ),

        springGreen = adjust( "#c8f0e0" ),
        boatYellow1 = adjust( "#4b7c85" ),
        boatYellow2 = adjust( "#5b8c95" ),
        carpYellow = adjust( "#6b9ca5" ),

        sakuraPink = adjust( "#6b9bba" ),
        waveRed = adjust( "#4b91a2" ),
        peachRed = adjust( "#3b8198" ),
        surimiOrange = adjust( "#5b9bba" ),
        katanaGray = adjust( "#528899" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1b5447" ) },
        Normal = { bg = adjust( "#111516" ) },
        TelescopeNormal = { bg = adjust( "#0c1212" ) },
        TelescopeBorder = { bg = adjust( "#0c1212" ), fg = adjust( "#3b5d5e" ) },
        TelescopePromptNormal = { bg = adjust( "#0c1212" ) },
      }
    },
    custom = {
      accent = adjust( "#3db498" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#66cacb" ),
      cursor_line = adjust( "#66cacb" ),
      line_number = adjust( "#3b5d5e" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#a9dbd4" ),
    }
  },

  [ "pine (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#081812" ),
        sumiInk1 = adjust( "#0b1c15" ),
        sumiInk2 = adjust( "#0e2018" ),
        sumiInk3 = adjust( "#11241b" ),
        sumiInk4 = adjust( "#152a21" ),
        sumiInk5 = adjust( "#1b3227" ),
        sumiInk6 = adjust( "#2b4a3d" ),

        waveBlue1 = adjust( "#274a39" ),
        waveBlue2 = adjust( "#335a49" ),

        winterGreen = adjust( "#1f3a2e" ),
        winterYellow = adjust( "#244233" ),
        winterRed = adjust( "#1f342a" ),
        winterBlue = adjust( "#2a3c32" ),
        autumnGreen = adjust( "#4f8a7a" ),
        autumnRed = adjust( "#3f7a6a" ),
        autumnYellow = adjust( "#619a8a" ),

        samuraiRed = adjust( "#36a08e" ),
        roninYellow = adjust( "#41b8a0" ),
        waveAqua1 = adjust( "#6acedd" ),
        dragonBlue = adjust( "#6a95a0" ),

        oldWhite = adjust( "#ade0dc" ),
        fujiWhite = adjust( "#bdeee9" ),
        fujiGray = adjust( "#4f8076" ),

        oniViolet = adjust( "#609daa" ),
        oniViolet2 = adjust( "#80b7c4" ),
        crystalBlue = adjust( "#83bcd0" ),
        springViolet1 = adjust( "#6f9ca9" ),
        springViolet2 = adjust( "#81bbc8" ),
        springBlue = adjust( "#84c4cb" ),
        lightBlue = adjust( "#a8e4e1" ),
        waveAqua2 = adjust( "#7fb8bd" ),

        springGreen = adjust( "#d8f8e8" ),
        boatYellow1 = adjust( "#4f808d" ),
        boatYellow2 = adjust( "#5f909d" ),
        carpYellow = adjust( "#6fa0ad" ),

        sakuraPink = adjust( "#6f9fc2" ),
        waveRed = adjust( "#4f95aa" ),
        peachRed = adjust( "#3f85a0" ),
        surimiOrange = adjust( "#5f9fc2" ),
        katanaGray = adjust( "#568ca1" ),
      },
      overrides = {
        Visual = { bg = adjust( "#1f5a49" ) },
        Normal = { bg = adjust( "#111615" ) },
        TelescopeNormal = { bg = adjust( "#0d1312" ) },
        TelescopeBorder = { bg = adjust( "#0d1312" ), fg = adjust( "#3f6166" ) },
        TelescopePromptNormal = { bg = adjust( "#0d1312" ) },
      }
    },
    custom = {
      accent = adjust( "#41b8a0" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#6acedd" ),
      cursor_line = adjust( "#6acedd" ),
      line_number = adjust( "#3f6166" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#ade0dc" ),
    }
  },

  [ "viridian (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#0a1610" ),
        sumiInk1 = adjust( "#0d1a13" ),
        sumiInk2 = adjust( "#101e16" ),
        sumiInk3 = adjust( "#132219" ),
        sumiInk4 = adjust( "#17281f" ),
        sumiInk5 = adjust( "#1d3025" ),
        sumiInk6 = adjust( "#2d483b" ),

        waveBlue1 = adjust( "#29483b" ),
        waveBlue2 = adjust( "#35584b" ),

        winterGreen = adjust( "#21382e" ),
        winterYellow = adjust( "#264033" ),
        winterRed = adjust( "#21322a" ),
        winterBlue = adjust( "#2c3a32" ),
        autumnGreen = adjust( "#518a78" ),
        autumnRed = adjust( "#417a68" ),
        autumnYellow = adjust( "#639a88" ),

        samuraiRed = adjust( "#38a08c" ),
        roninYellow = adjust( "#43b89e" ),
        waveAqua1 = adjust( "#6ccedb" ),
        dragonBlue = adjust( "#6c959e" ),

        oldWhite = adjust( "#afe0da" ),
        fujiWhite = adjust( "#bfede7" ),
        fujiGray = adjust( "#517e74" ),

        oniViolet = adjust( "#629da8" ),
        oniViolet2 = adjust( "#82b7c2" ),
        crystalBlue = adjust( "#85bcce" ),
        springViolet1 = adjust( "#719ca7" ),
        springViolet2 = adjust( "#83bbc6" ),
        springBlue = adjust( "#86c4c9" ),
        lightBlue = adjust( "#aae4df" ),
        waveAqua2 = adjust( "#81b8bb" ),

        springGreen = adjust( "#d8f0e0" ),
        boatYellow1 = adjust( "#51808b" ),
        boatYellow2 = adjust( "#61909b" ),
        carpYellow = adjust( "#71a0ab" ),

        sakuraPink = adjust( "#719fc0" ),
        waveRed = adjust( "#5195a8" ),
        peachRed = adjust( "#41859e" ),
        surimiOrange = adjust( "#619fc0" ),
        katanaGray = adjust( "#588c9f" ),
      },
      overrides = {
        Visual = { bg = adjust( "#21584b" ) },
        Normal = { bg = adjust( "#121614" ) },
        TelescopeNormal = { bg = adjust( "#0e1310" ) },
        TelescopeBorder = { bg = adjust( "#0e1310" ), fg = adjust( "#416164" ) },
        TelescopePromptNormal = { bg = adjust( "#0e1310" ) },
      }
    },
    custom = {
      accent = adjust( "#43b89e" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#6ccedb" ),
      cursor_line = adjust( "#6ccedb" ),
      line_number = adjust( "#416164" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#afe0da" ),
    }
  },

  [ "sunset (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#140a06" ),
        sumiInk1 = adjust( "#180c08" ),
        sumiInk2 = adjust( "#1c0e0a" ),
        sumiInk3 = adjust( "#20100c" ),
        sumiInk4 = adjust( "#261410" ),
        sumiInk5 = adjust( "#321a16" ),
        sumiInk6 = adjust( "#4e2a20" ),

        waveBlue1 = adjust( "#4a1e14" ),
        waveBlue2 = adjust( "#5e2d1a" ),

        winterGreen = adjust( "#361a10" ),
        winterYellow = adjust( "#3a1f14" ),
        winterRed = adjust( "#2e1a10" ),
        winterBlue = adjust( "#352520" ),
        autumnGreen = adjust( "#804a30" ),
        autumnRed = adjust( "#703a20" ),
        autumnYellow = adjust( "#905c40" ),

        samuraiRed = adjust( "#a02920" ),
        roninYellow = adjust( "#b83430" ),
        waveAqua1 = adjust( "#ce5d40" ),
        dragonBlue = adjust( "#946558" ),

        oldWhite = adjust( "#e0a890" ),
        fujiWhite = adjust( "#edb8a0" ),
        fujiGray = adjust( "#7c4a30" ),

        oniViolet = adjust( "#9d5b40" ),
        oniViolet2 = adjust( "#b77b60" ),
        crystalBlue = adjust( "#bc7e70" ),
        springViolet1 = adjust( "#9c6a50" ),
        springViolet2 = adjust( "#bb7c60" ),
        springBlue = adjust( "#c47f70" ),
        lightBlue = adjust( "#e4a390" ),
        waveAqua2 = adjust( "#b87a60" ),

        springGreen = adjust( "#f0d8c0" ),
        boatYellow1 = adjust( "#804a30" ),
        boatYellow2 = adjust( "#905a40" ),
        carpYellow = adjust( "#a06a50" ),

        sakuraPink = adjust( "#9f6a50" ),
        waveRed = adjust( "#8f4a30" ),
        peachRed = adjust( "#7f3a20" ),
        surimiOrange = adjust( "#9f5a40" ),
        katanaGray = adjust( "#8c5140" ),
      },
      overrides = {
        Visual = { bg = adjust( "#4a1a10" ) },
        Normal = { bg = adjust( "#161210" ) },
        TelescopeNormal = { bg = adjust( "#120f0c" ) },
        TelescopeBorder = { bg = adjust( "#120f0c" ), fg = adjust( "#5f3a20" ) },
        TelescopePromptNormal = { bg = adjust( "#120f0c" ) },
      }
    },
    custom = {
      accent = adjust( "#b83430" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#ce5d40" ),
      cursor_line = adjust( "#ce5d40" ),
      line_number = adjust( "#5f3a20" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#e0a890" ),
    }
  },

  [ "amber (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#140e0a" ),
        sumiInk1 = adjust( "#181110" ),
        sumiInk2 = adjust( "#1c1414" ),
        sumiInk3 = adjust( "#201718" ),
        sumiInk4 = adjust( "#261d20" ),
        sumiInk5 = adjust( "#322328" ),
        sumiInk6 = adjust( "#4e3a40" ),

        waveBlue1 = adjust( "#4a2e30" ),
        waveBlue2 = adjust( "#5e3e40" ),

        winterGreen = adjust( "#362a28" ),
        winterYellow = adjust( "#3a2f2c" ),
        winterRed = adjust( "#2e2420" ),
        winterBlue = adjust( "#35302c" ),
        autumnGreen = adjust( "#805a54" ),
        autumnRed = adjust( "#704a44" ),
        autumnYellow = adjust( "#906a64" ),

        samuraiRed = adjust( "#a03920" ),
        roninYellow = adjust( "#b84a30" ),
        waveAqua1 = adjust( "#ce6d50" ),
        dragonBlue = adjust( "#947568" ),

        oldWhite = adjust( "#e0b8a0" ),
        fujiWhite = adjust( "#edc8b0" ),
        fujiGray = adjust( "#7c5a44" ),

        oniViolet = adjust( "#9d6b50" ),
        oniViolet2 = adjust( "#b78b70" ),
        crystalBlue = adjust( "#bc8e80" ),
        springViolet1 = adjust( "#9c7a60" ),
        springViolet2 = adjust( "#bb8c70" ),
        springBlue = adjust( "#c48f80" ),
        lightBlue = adjust( "#e4b3a0" ),
        waveAqua2 = adjust( "#b88a70" ),

        springGreen = adjust( "#f8e0c8" ),
        boatYellow1 = adjust( "#805a40" ),
        boatYellow2 = adjust( "#906a50" ),
        carpYellow = adjust( "#a07a60" ),

        sakuraPink = adjust( "#9f7a60" ),
        waveRed = adjust( "#8f5a40" ),
        peachRed = adjust( "#7f4a30" ),
        surimiOrange = adjust( "#9f6a50" ),
        katanaGray = adjust( "#8c6150" ),
      },
      overrides = {
        Visual = { bg = adjust( "#4a2a20" ) },
        Normal = { bg = adjust( "#16140e" ) },
        TelescopeNormal = { bg = adjust( "#12110d" ) },
        TelescopeBorder = { bg = adjust( "#12110d" ), fg = adjust( "#5f4a30" ) },
        TelescopePromptNormal = { bg = adjust( "#12110d" ) },
      }
    },
    custom = {
      accent = adjust( "#b84a30" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#ce6d50" ),
      cursor_line = adjust( "#ce6d50" ),
      line_number = adjust( "#5f4a30" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#e0b8a0" ),
    }
  },

  [ "copper (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#12100a" ),
        sumiInk1 = adjust( "#16140e" ),
        sumiInk2 = adjust( "#1a1812" ),
        sumiInk3 = adjust( "#1e1c16" ),
        sumiInk4 = adjust( "#24221c" ),
        sumiInk5 = adjust( "#302e24" ),
        sumiInk6 = adjust( "#4c4a3a" ),

        waveBlue1 = adjust( "#484638" ),
        waveBlue2 = adjust( "#585648" ),

        winterGreen = adjust( "#343028" ),
        winterYellow = adjust( "#38342c" ),
        winterRed = adjust( "#2c2820" ),
        winterBlue = adjust( "#333028" ),
        autumnGreen = adjust( "#7e7050" ),
        autumnRed = adjust( "#6e6040" ),
        autumnYellow = adjust( "#8e8060" ),

        samuraiRed = adjust( "#9e6020" ),
        roninYellow = adjust( "#b67030" ),
        waveAqua1 = adjust( "#cc8d50" ),
        dragonBlue = adjust( "#928560" ),

        oldWhite = adjust( "#deb890" ),
        fujiWhite = adjust( "#ebc8a0" ),
        fujiGray = adjust( "#7a6044" ),

        oniViolet = adjust( "#9b7150" ),
        oniViolet2 = adjust( "#b59170" ),
        crystalBlue = adjust( "#ba9480" ),
        springViolet1 = adjust( "#9a8060" ),
        springViolet2 = adjust( "#b99270" ),
        springBlue = adjust( "#c29580" ),
        lightBlue = adjust( "#e2b390" ),
        waveAqua2 = adjust( "#b69070" ),

        springGreen = adjust( "#f0d8c8" ),
        boatYellow1 = adjust( "#7e6040" ),
        boatYellow2 = adjust( "#8e7050" ),
        carpYellow = adjust( "#9e8060" ),

        sakuraPink = adjust( "#9d8060" ),
        waveRed = adjust( "#8d6040" ),
        peachRed = adjust( "#7d5030" ),
        surimiOrange = adjust( "#9d7050" ),
        katanaGray = adjust( "#8a6750" ),
      },
      overrides = {
        Visual = { bg = adjust( "#48302a" ) },
        Normal = { bg = adjust( "#15140f" ) },
        TelescopeNormal = { bg = adjust( "#11110d" ) },
        TelescopeBorder = { bg = adjust( "#11110d" ), fg = adjust( "#5d5030" ) },
        TelescopePromptNormal = { bg = adjust( "#11110d" ) },
      }
    },
    custom = {
      accent = adjust( "#b67030" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#cc8d50" ),
      cursor_line = adjust( "#cc8d50" ),
      line_number = adjust( "#5d5030" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#deb890" ),
    }
  },

  [ "rust (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#140c08" ),
        sumiInk1 = adjust( "#18100c" ),
        sumiInk2 = adjust( "#1c1410" ),
        sumiInk3 = adjust( "#201814" ),
        sumiInk4 = adjust( "#261e1a" ),
        sumiInk5 = adjust( "#322622" ),
        sumiInk6 = adjust( "#4e3e38" ),

        waveBlue1 = adjust( "#4a3632" ),
        waveBlue2 = adjust( "#5e4642" ),

        winterGreen = adjust( "#362a24" ),
        winterYellow = adjust( "#3a2e28" ),
        winterRed = adjust( "#2e2218" ),
        winterBlue = adjust( "#352a24" ),
        autumnGreen = adjust( "#805448" ),
        autumnRed = adjust( "#704438" ),
        autumnYellow = adjust( "#906458" ),

        samuraiRed = adjust( "#a03018" ),
        roninYellow = adjust( "#b84028" ),
        waveAqua1 = adjust( "#ce6548" ),
        dragonBlue = adjust( "#946e58" ),

        oldWhite = adjust( "#e0ac88" ),
        fujiWhite = adjust( "#edbca8" ),
        fujiGray = adjust( "#7c5838" ),

        oniViolet = adjust( "#9d6548" ),
        oniViolet2 = adjust( "#b78568" ),
        crystalBlue = adjust( "#bc8878" ),
        springViolet1 = adjust( "#9c7458" ),
        springViolet2 = adjust( "#bb8668" ),
        springBlue = adjust( "#c48978" ),
        lightBlue = adjust( "#e4ad88" ),
        waveAqua2 = adjust( "#b88468" ),

        springGreen = adjust( "#f0e0c0" ),
        boatYellow1 = adjust( "#805438" ),
        boatYellow2 = adjust( "#906448" ),
        carpYellow = adjust( "#a07458" ),

        sakuraPink = adjust( "#9f7458" ),
        waveRed = adjust( "#8f5438" ),
        peachRed = adjust( "#7f4428" ),
        surimiOrange = adjust( "#9f6448" ),
        katanaGray = adjust( "#8c5b48" ),
      },
      overrides = {
        Visual = { bg = adjust( "#4a2418" ) },
        Normal = { bg = adjust( "#16130f" ) },
        TelescopeNormal = { bg = adjust( "#12100c" ) },
        TelescopeBorder = { bg = adjust( "#12100c" ), fg = adjust( "#5f4428" ) },
        TelescopePromptNormal = { bg = adjust( "#12100c" ) },
      }
    },
    custom = {
      accent = adjust( "#b84028" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#ce6548" ),
      cursor_line = adjust( "#ce6548" ),
      line_number = adjust( "#5f4428" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#e0ac88" ),
    }
  },

  [ "bronze (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#10120a" ),
        sumiInk1 = adjust( "#14160e" ),
        sumiInk2 = adjust( "#181a12" ),
        sumiInk3 = adjust( "#1c1e16" ),
        sumiInk4 = adjust( "#22241c" ),
        sumiInk5 = adjust( "#2e3024" ),
        sumiInk6 = adjust( "#4a4c3a" ),

        waveBlue1 = adjust( "#464838" ),
        waveBlue2 = adjust( "#565848" ),

        winterGreen = adjust( "#303228" ),
        winterYellow = adjust( "#34362c" ),
        winterRed = adjust( "#282a20" ),
        winterBlue = adjust( "#2f3128" ),
        autumnGreen = adjust( "#7c7e50" ),
        autumnRed = adjust( "#6c6e40" ),
        autumnYellow = adjust( "#8c8e60" ),

        samuraiRed = adjust( "#9c6220" ),
        roninYellow = adjust( "#b47230" ),
        waveAqua1 = adjust( "#ca8f50" ),
        dragonBlue = adjust( "#909260" ),

        oldWhite = adjust( "#dcba90" ),
        fujiWhite = adjust( "#e9caa0" ),
        fujiGray = adjust( "#786244" ),

        oniViolet = adjust( "#997350" ),
        oniViolet2 = adjust( "#b39370" ),
        crystalBlue = adjust( "#b89680" ),
        springViolet1 = adjust( "#988260" ),
        springViolet2 = adjust( "#b79470" ),
        springBlue = adjust( "#c09780" ),
        lightBlue = adjust( "#e0b590" ),
        waveAqua2 = adjust( "#b49270" ),

        springGreen = adjust( "#e8d8c0" ),
        boatYellow1 = adjust( "#7c6240" ),
        boatYellow2 = adjust( "#8c7250" ),
        carpYellow = adjust( "#9c8260" ),

        sakuraPink = adjust( "#9b8260" ),
        waveRed = adjust( "#8b6240" ),
        peachRed = adjust( "#7b5230" ),
        surimiOrange = adjust( "#9b7250" ),
        katanaGray = adjust( "#886950" ),
      },
      overrides = {
        Visual = { bg = adjust( "#463228" ) },
        Normal = { bg = adjust( "#15150e" ) },
        TelescopeNormal = { bg = adjust( "#11120c" ) },
        TelescopeBorder = { bg = adjust( "#11120c" ), fg = adjust( "#5b5230" ) },
        TelescopePromptNormal = { bg = adjust( "#11120c" ) },
      }
    },
    custom = {
      accent = adjust( "#b47230" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#ca8f50" ),
      cursor_line = adjust( "#ca8f50" ),
      line_number = adjust( "#5b5230" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#dcba90" ),
    }
  },

  [ "peach (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#140a0e" ),
        sumiInk1 = adjust( "#180c12" ),
        sumiInk2 = adjust( "#1c0e16" ),
        sumiInk3 = adjust( "#20101a" ),
        sumiInk4 = adjust( "#261420" ),
        sumiInk5 = adjust( "#321a28" ),
        sumiInk6 = adjust( "#4e2a3e" ),

        waveBlue1 = adjust( "#4a1e32" ),
        waveBlue2 = adjust( "#5e2d42" ),

        winterGreen = adjust( "#361a28" ),
        winterYellow = adjust( "#3a1f2c" ),
        winterRed = adjust( "#2e1a20" ),
        winterBlue = adjust( "#35252a" ),
        autumnGreen = adjust( "#804a5c" ),
        autumnRed = adjust( "#703a4c" ),
        autumnYellow = adjust( "#905c6c" ),

        samuraiRed = adjust( "#a02938" ),
        roninYellow = adjust( "#b83448" ),
        waveAqua1 = adjust( "#ce5d68" ),
        dragonBlue = adjust( "#946568" ),

        oldWhite = adjust( "#e0a8b8" ),
        fujiWhite = adjust( "#edb8c8" ),
        fujiGray = adjust( "#7c4a58" ),

        oniViolet = adjust( "#9d5b68" ),
        oniViolet2 = adjust( "#b77b88" ),
        crystalBlue = adjust( "#bc7e98" ),
        springViolet1 = adjust( "#9c6a78" ),
        springViolet2 = adjust( "#bb7c88" ),
        springBlue = adjust( "#c47f98" ),
        lightBlue = adjust( "#e4a3b8" ),
        waveAqua2 = adjust( "#b87a88" ),

        springGreen = adjust( "#f0d8e0" ),
        boatYellow1 = adjust( "#804a58" ),
        boatYellow2 = adjust( "#905a68" ),
        carpYellow = adjust( "#a06a78" ),

        sakuraPink = adjust( "#9f6a78" ),
        waveRed = adjust( "#8f4a58" ),
        peachRed = adjust( "#7f3a48" ),
        surimiOrange = adjust( "#9f5a68" ),
        katanaGray = adjust( "#8c5168" ),
      },
      overrides = {
        Visual = { bg = adjust( "#4a1a28" ) },
        Normal = { bg = adjust( "#161212" ) },
        TelescopeNormal = { bg = adjust( "#120f11" ) },
        TelescopeBorder = { bg = adjust( "#120f11" ), fg = adjust( "#5f3a48" ) },
        TelescopePromptNormal = { bg = adjust( "#120f11" ) },
      }
    },
    custom = {
      accent = adjust( "#b83448" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#ce5d68" ),
      cursor_line = adjust( "#ce5d68" ),
      line_number = adjust( "#5f3a48" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#e0a8b8" ),
    }
  },

  [ "sienna (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#120a08" ),
        sumiInk1 = adjust( "#160c0a" ),
        sumiInk2 = adjust( "#1a0e0c" ),
        sumiInk3 = adjust( "#1e100e" ),
        sumiInk4 = adjust( "#241414" ),
        sumiInk5 = adjust( "#301a1a" ),
        sumiInk6 = adjust( "#4c2a2a" ),

        waveBlue1 = adjust( "#481e1e" ),
        waveBlue2 = adjust( "#582d2d" ),

        winterGreen = adjust( "#341a1a" ),
        winterYellow = adjust( "#381f1f" ),
        winterRed = adjust( "#2c1414" ),
        winterBlue = adjust( "#332020" ),
        autumnGreen = adjust( "#7e4a4a" ),
        autumnRed = adjust( "#6e3a3a" ),
        autumnYellow = adjust( "#8e5a5a" ),

        samuraiRed = adjust( "#9e2929" ),
        roninYellow = adjust( "#b63434" ),
        waveAqua1 = adjust( "#cc5d5d" ),
        dragonBlue = adjust( "#926565" ),

        oldWhite = adjust( "#dea8a8" ),
        fujiWhite = adjust( "#ebb8b8" ),
        fujiGray = adjust( "#7a4a4a" ),

        oniViolet = adjust( "#9b5b5b" ),
        oniViolet2 = adjust( "#b57b7b" ),
        crystalBlue = adjust( "#ba7e7e" ),
        springViolet1 = adjust( "#9a6a6a" ),
        springViolet2 = adjust( "#b97c7c" ),
        springBlue = adjust( "#c27f7f" ),
        lightBlue = adjust( "#e2a3a3" ),
        waveAqua2 = adjust( "#b67a7a" ),

        springGreen = adjust( "#f0d0d0" ),
        boatYellow1 = adjust( "#7e4a4a" ),
        boatYellow2 = adjust( "#8e5a5a" ),
        carpYellow = adjust( "#9e6a6a" ),

        sakuraPink = adjust( "#9d6a6a" ),
        waveRed = adjust( "#8d4a4a" ),
        peachRed = adjust( "#7d3a3a" ),
        surimiOrange = adjust( "#9d5a5a" ),
        katanaGray = adjust( "#8a5151" ),
      },
      overrides = {
        Visual = { bg = adjust( "#481a1a" ) },
        Normal = { bg = adjust( "#14120e" ) },
        TelescopeNormal = { bg = adjust( "#110f0c" ) },
        TelescopeBorder = { bg = adjust( "#110f0c" ), fg = adjust( "#5d3a3a" ) },
        TelescopePromptNormal = { bg = adjust( "#110f0c" ) },
      }
    },
    custom = {
      accent = adjust( "#b63434" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#cc5d5d" ),
      cursor_line = adjust( "#cc5d5d" ),
      line_number = adjust( "#5d3a3a" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#dea8a8" ),
    }
  },

  [ "caramel (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#100e0a" ),
        sumiInk1 = adjust( "#14120e" ),
        sumiInk2 = adjust( "#181612" ),
        sumiInk3 = adjust( "#1c1a16" ),
        sumiInk4 = adjust( "#22201c" ),
        sumiInk5 = adjust( "#2e2c24" ),
        sumiInk6 = adjust( "#4a483a" ),

        waveBlue1 = adjust( "#464438" ),
        waveBlue2 = adjust( "#565448" ),

        winterGreen = adjust( "#302e28" ),
        winterYellow = adjust( "#34322c" ),
        winterRed = adjust( "#282620" ),
        winterBlue = adjust( "#2f2d28" ),
        autumnGreen = adjust( "#7c7a50" ),
        autumnRed = adjust( "#6c6a40" ),
        autumnYellow = adjust( "#8c8a60" ),

        samuraiRed = adjust( "#9c5e20" ),
        roninYellow = adjust( "#b46e30" ),
        waveAqua1 = adjust( "#ca8b50" ),
        dragonBlue = adjust( "#908e60" ),

        oldWhite = adjust( "#dcb690" ),
        fujiWhite = adjust( "#e9c6a0" ),
        fujiGray = adjust( "#785e44" ),

        oniViolet = adjust( "#996f50" ),
        oniViolet2 = adjust( "#b38f70" ),
        crystalBlue = adjust( "#b89280" ),
        springViolet1 = adjust( "#987e60" ),
        springViolet2 = adjust( "#b79070" ),
        springBlue = adjust( "#c09380" ),
        lightBlue = adjust( "#e0b190" ),
        waveAqua2 = adjust( "#b48e70" ),

        springGreen = adjust( "#e8d0c0" ),
        boatYellow1 = adjust( "#7c5e40" ),
        boatYellow2 = adjust( "#8c6e50" ),
        carpYellow = adjust( "#9c7e60" ),

        sakuraPink = adjust( "#9b7e60" ),
        waveRed = adjust( "#8b5e40" ),
        peachRed = adjust( "#7b4e30" ),
        surimiOrange = adjust( "#9b6e50" ),
        katanaGray = adjust( "#886550" ),
      },
      overrides = {
        Visual = { bg = adjust( "#462e28" ) },
        Normal = { bg = adjust( "#14130e" ) },
        TelescopeNormal = { bg = adjust( "#10100c" ) },
        TelescopeBorder = { bg = adjust( "#10100c" ), fg = adjust( "#5b4e30" ) },
        TelescopePromptNormal = { bg = adjust( "#10100c" ) },
      }
    },
    custom = {
      accent = adjust( "#b46e30" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#ca8b50" ),
      cursor_line = adjust( "#ca8b50" ),
      line_number = adjust( "#5b4e30" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#dcb690" ),
    }
  },

  [ "coral (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#140a0c" ),
        sumiInk1 = adjust( "#180c10" ),
        sumiInk2 = adjust( "#1c0e14" ),
        sumiInk3 = adjust( "#201018" ),
        sumiInk4 = adjust( "#26141e" ),
        sumiInk5 = adjust( "#321a26" ),
        sumiInk6 = adjust( "#4e2a3c" ),

        waveBlue1 = adjust( "#4a1e30" ),
        waveBlue2 = adjust( "#5e2d40" ),

        winterGreen = adjust( "#361a26" ),
        winterYellow = adjust( "#3a1f2a" ),
        winterRed = adjust( "#2e1a1e" ),
        winterBlue = adjust( "#352528" ),
        autumnGreen = adjust( "#804a5a" ),
        autumnRed = adjust( "#703a4a" ),
        autumnYellow = adjust( "#905c6a" ),

        samuraiRed = adjust( "#a02936" ),
        roninYellow = adjust( "#b83446" ),
        waveAqua1 = adjust( "#ce5d66" ),
        dragonBlue = adjust( "#946566" ),

        oldWhite = adjust( "#e0a8b6" ),
        fujiWhite = adjust( "#edb8c6" ),
        fujiGray = adjust( "#7c4a56" ),

        oniViolet = adjust( "#9d5b66" ),
        oniViolet2 = adjust( "#b77b86" ),
        crystalBlue = adjust( "#bc7e96" ),
        springViolet1 = adjust( "#9c6a76" ),
        springViolet2 = adjust( "#bb7c86" ),
        springBlue = adjust( "#c47f96" ),
        lightBlue = adjust( "#e4a3b6" ),
        waveAqua2 = adjust( "#b87a86" ),

        springGreen = adjust( "#f0d8e0" ),
        boatYellow1 = adjust( "#804a56" ),
        boatYellow2 = adjust( "#905a66" ),
        carpYellow = adjust( "#a06a76" ),

        sakuraPink = adjust( "#9f6a76" ),
        waveRed = adjust( "#8f4a56" ),
        peachRed = adjust( "#7f3a46" ),
        surimiOrange = adjust( "#9f5a66" ),
        katanaGray = adjust( "#8c5166" ),
      },
      overrides = {
        Visual = { bg = adjust( "#4a1a26" ) },
        Normal = { bg = adjust( "#161111" ) },
        TelescopeNormal = { bg = adjust( "#120e0f" ) },
        TelescopeBorder = { bg = adjust( "#120e0f" ), fg = adjust( "#5f3a46" ) },
        TelescopePromptNormal = { bg = adjust( "#120e0f" ) },
      }
    },
    custom = {
      accent = adjust( "#b83446" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#ce5d66" ),
      cursor_line = adjust( "#ce5d66" ),
      line_number = adjust( "#5f3a46" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#e0a8b6" ),
    }
  },

  [ "papaya (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = adjust( "#140c0a" ),
        sumiInk1 = adjust( "#18100e" ),
        sumiInk2 = adjust( "#1c1412" ),
        sumiInk3 = adjust( "#201816" ),
        sumiInk4 = adjust( "#261e1c" ),
        sumiInk5 = adjust( "#322624" ),
        sumiInk6 = adjust( "#4e3e3a" ),

        waveBlue1 = adjust( "#4a3634" ),
        waveBlue2 = adjust( "#5e4644" ),

        winterGreen = adjust( "#362a26" ),
        winterYellow = adjust( "#3a2e2a" ),
        winterRed = adjust( "#2e221e" ),
        winterBlue = adjust( "#352a26" ),
        autumnGreen = adjust( "#80544c" ),
        autumnRed = adjust( "#70443c" ),
        autumnYellow = adjust( "#90645c" ),

        samuraiRed = adjust( "#a0301c" ),
        roninYellow = adjust( "#b8402c" ),
        waveAqua1 = adjust( "#ce654c" ),
        dragonBlue = adjust( "#946e5c" ),

        oldWhite = adjust( "#e0ac8c" ),
        fujiWhite = adjust( "#edbcac" ),
        fujiGray = adjust( "#7c583c" ),

        oniViolet = adjust( "#9d654c" ),
        oniViolet2 = adjust( "#b7856c" ),
        crystalBlue = adjust( "#bc887c" ),
        springViolet1 = adjust( "#9c745c" ),
        springViolet2 = adjust( "#bb866c" ),
        springBlue = adjust( "#c4897c" ),
        lightBlue = adjust( "#e4ad8c" ),
        waveAqua2 = adjust( "#b8846c" ),

        springGreen = adjust( "#f0e0c8" ),
        boatYellow1 = adjust( "#80543c" ),
        boatYellow2 = adjust( "#90644c" ),
        carpYellow = adjust( "#a0745c" ),

        sakuraPink = adjust( "#9f745c" ),
        waveRed = adjust( "#8f543c" ),
        peachRed = adjust( "#7f442c" ),
        surimiOrange = adjust( "#9f644c" ),
        katanaGray = adjust( "#8c5b4c" ),
      },
      overrides = {
        Visual = { bg = adjust( "#4a241c" ) },
        Normal = { bg = adjust( "#161210" ) },
        TelescopeNormal = { bg = adjust( "#12100d" ) },
        TelescopeBorder = { bg = adjust( "#12100d" ), fg = adjust( "#5f442c" ) },
        TelescopePromptNormal = { bg = adjust( "#12100d" ) },
      }
    },
    custom = {
      accent = adjust( "#b8402c" ),
      light_accent = function( accent )
        return utils.saturation( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      dark_accent = function( accent )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = adjust( "#ce654c" ),
      cursor_line = adjust( "#ce654c" ),
      line_number = adjust( "#5f442c" ),
      notify_info_border = function( accent )
        return utils.saturation( accent, 0.9 )
      end,
      notify_info_body = adjust( "#e0ac8c" ),
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
