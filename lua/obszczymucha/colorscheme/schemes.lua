local M = {}

M.schemes = {
  default = {
    kanagawa = {
      palette = {},
      overrides = {
        Visual = { bg = "#3d3a7a" },
        Normal = { bg = "#1a1a1c" },
        TelescopeNormal = { bg = "#141416" },
        TelescopeBorder = { bg = "#141416", fg = "#4c4a69" },
        TelescopePromptNormal = { bg = "#141416" },
      }
    },
    custom = {
      accent = "#9f7fff",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#2db7ff",
      cursor_line = "#fabd2f",
      line_number = "#4b5271",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#b9c0eb",
    }
  },

  [ "ocean (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0a0e14",
        sumiInk1 = "#0c1117",
        sumiInk2 = "#0e131a",
        sumiInk3 = "#10151d",
        sumiInk4 = "#141b26",
        sumiInk5 = "#1a2332",
        sumiInk6 = "#2a3f5e",

        waveBlue1 = "#1e3a5f",
        waveBlue2 = "#2d4f67",

        winterGreen = "#1a3340",
        winterYellow = "#1f3a4d",
        winterRed = "#1a2838",
        winterBlue = "#252535",
        autumnGreen = "#4a7a8c",
        autumnRed = "#3a6b8c",
        autumnYellow = "#5c8aa8",

        samuraiRed = "#2980b9",
        roninYellow = "#3498db",
        waveAqua1 = "#5dade2",
        dragonBlue = "#658594",

        oldWhite = "#a8d0e6",
        fujiWhite = "#b8dbed",
        fujiGray = "#4a6b7c",

        oniViolet = "#5b8dbf",
        oniViolet2 = "#7ba7d0",
        crystalBlue = "#7e9cd8",
        springViolet1 = "#6a8caa",
        springViolet2 = "#7cabca",
        springBlue = "#7fb4ca",
        lightBlue = "#a3d4d5",
        waveAqua2 = "#7aa8af",

        springGreen = "#c8d8f0",
        boatYellow1 = "#4a7080",
        boatYellow2 = "#5a8090",
        carpYellow = "#6a90a0",

        sakuraPink = "#6a8fb5",
        waveRed = "#4a7fa8",
        peachRed = "#3a6f98",
        surimiOrange = "#5a8fb8",
        katanaGray = "#517c8c",
      },
      overrides = {
        Visual = { bg = "#1a4a6a" },
        Normal = { bg = "#111418" },
        TelescopeNormal = { bg = "#0f1214" },
        TelescopeBorder = { bg = "#0f1214", fg = "#3a5f7a" },
        TelescopePromptNormal = { bg = "#0f1214" },
      }
    },
    custom = {
      accent = "#4a9fb8",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#2db7ff",
      cursor_line = "#5dade2",
      line_number = "#3a5f7a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a8d0e6",
    }
  },

  [ "arctic (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0e1218",
        sumiInk1 = "#111520",
        sumiInk2 = "#141825",
        sumiInk3 = "#171b2a",
        sumiInk4 = "#1c2235",
        sumiInk5 = "#232a3f",
        sumiInk6 = "#3a4a6a",

        waveBlue1 = "#2a4a6f",
        waveBlue2 = "#3a5a7f",

        winterGreen = "#2a4350",
        winterYellow = "#2f4a5d",
        winterRed = "#2a3848",
        winterBlue = "#353545",
        autumnGreen = "#5a8a9c",
        autumnRed = "#4a7b9c",
        autumnYellow = "#6c9ab8",

        samuraiRed = "#6aadd9",
        roninYellow = "#7abfeb",
        waveAqua1 = "#8dcff2",
        dragonBlue = "#7595a4",

        oldWhite = "#c8e0f6",
        fujiWhite = "#d8ebfd",
        fujiGray = "#6a8b9c",

        oniViolet = "#8badcf",
        oniViolet2 = "#9bb7e0",
        crystalBlue = "#9ebce8",
        springViolet1 = "#8aacca",
        springViolet2 = "#9cbbda",
        springBlue = "#9fc4da",
        lightBlue = "#c3e4e5",
        waveAqua2 = "#9ac8cf",

        springGreen = "#d8e8ff",
        boatYellow1 = "#6a8090",
        boatYellow2 = "#7a90a0",
        carpYellow = "#8aa0b0",

        sakuraPink = "#8aafc5",
        waveRed = "#6a9fb8",
        peachRed = "#5a8fa8",
        surimiOrange = "#7aafC8",
        katanaGray = "#719cac",
      },
      overrides = {
        Visual = { bg = "#2a5a7a" },
        Normal = { bg = "#15161a" },
        TelescopeNormal = { bg = "#111316" },
        TelescopeBorder = { bg = "#111316", fg = "#4a6f8a" },
        TelescopePromptNormal = { bg = "#111316" },
      }
    },
    custom = {
      accent = "#7abfdb",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#8dcff2",
      cursor_line = "#8dcff2",
      line_number = "#4a6f8a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#c8e0f6",
    }
  },

  [ "midnight (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#050810",
        sumiInk1 = "#070a14",
        sumiInk2 = "#090c18",
        sumiInk3 = "#0b0e1c",
        sumiInk4 = "#0f1424",
        sumiInk5 = "#151a2c",
        sumiInk6 = "#253048",

        waveBlue1 = "#1a2844",
        waveBlue2 = "#243254",

        winterGreen = "#101820",
        winterYellow = "#141c2a",
        winterRed = "#0f1420",
        winterBlue = "#1a1a2a",
        autumnGreen = "#3a5a6c",
        autumnRed = "#2a4b6c",
        autumnYellow = "#4c6a88",

        samuraiRed = "#1960a9",
        roninYellow = "#2478cb",
        waveAqua1 = "#4d8dc2",
        dragonBlue = "#556584",

        oldWhite = "#98b0c6",
        fujiWhite = "#a8bbd6",
        fujiGray = "#3a4b5c",

        oniViolet = "#4b6daf",
        oniViolet2 = "#6b87c0",
        crystalBlue = "#6e8cc8",
        springViolet1 = "#5a7caa",
        springViolet2 = "#6c8bba",
        springBlue = "#6f94ba",
        lightBlue = "#93b4c5",
        waveAqua2 = "#6a989f",

        springGreen = "#b8c8e0",
        boatYellow1 = "#3a5070",
        boatYellow2 = "#4a6080",
        carpYellow = "#5a7090",

        sakuraPink = "#5a7fa5",
        waveRed = "#3a6f98",
        peachRed = "#2a5f88",
        surimiOrange = "#4a7fa8",
        katanaGray = "#415c7c",
      },
      overrides = {
        Visual = { bg = "#1a3a5a" },
        Normal = { bg = "#0e1012" },
        TelescopeNormal = { bg = "#0c0e10" },
        TelescopeBorder = { bg = "#0c0e10", fg = "#2a4f6a" },
        TelescopePromptNormal = { bg = "#0c0e10" },
      }
    },
    custom = {
      accent = "#2478cb",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#4d8dc2",
      cursor_line = "#4d8dc2",
      line_number = "#2a4f6a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#98b0c6",
    }
  },

  [ "deep_sea (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#061016",
        sumiInk1 = "#08141a",
        sumiInk2 = "#0a171e",
        sumiInk3 = "#0c1a22",
        sumiInk4 = "#101e28",
        sumiInk5 = "#162630",
        sumiInk6 = "#263644",

        waveBlue1 = "#1e3e4e",
        waveBlue2 = "#2a4a5a",

        winterGreen = "#122230",
        winterYellow = "#162a38",
        winterRed = "#122028",
        winterBlue = "#1c2838",
        autumnGreen = "#3c6678",
        autumnRed = "#2c5678",
        autumnYellow = "#4e7690",

        samuraiRed = "#1e6ca6",
        roninYellow = "#2e88c8",
        waveAqua1 = "#4e9ad8",
        dragonBlue = "#5e7088",

        oldWhite = "#9abcd8",
        fujiWhite = "#aacce8",
        fujiGray = "#3c5668",

        oniViolet = "#4e78b8",
        oniViolet2 = "#6e92c8",
        crystalBlue = "#7098d0",
        springViolet1 = "#5c88a8",
        springViolet2 = "#6e98b8",
        springBlue = "#72a0c8",
        lightBlue = "#96c0d8",
        waveAqua2 = "#6ca4a8",

        springGreen = "#c0d0e8",
        boatYellow1 = "#3c5c78",
        boatYellow2 = "#4c6c88",
        carpYellow = "#5c7c98",

        sakuraPink = "#5c8ab8",
        waveRed = "#3c7aa8",
        peachRed = "#2c6a98",
        surimiOrange = "#4c8ab8",
        katanaGray = "#446888",
      },
      overrides = {
        Visual = { bg = "#1e4666" },
        Normal = { bg = "#111416" },
        TelescopeNormal = { bg = "#0e1114" },
        TelescopeBorder = { bg = "#0e1114", fg = "#2c5a76" },
        TelescopePromptNormal = { bg = "#0e1114" },
      }
    },
    custom = {
      accent = "#2e88c8",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#4e9ad8",
      cursor_line = "#4e9ad8",
      line_number = "#2c5a76",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#9abcd8",
    }
  },

  [ "cyan_dream (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0a1418",
        sumiInk1 = "#0c181c",
        sumiInk2 = "#0e1c20",
        sumiInk3 = "#102024",
        sumiInk4 = "#14262c",
        sumiInk5 = "#1a2e36",
        sumiInk6 = "#2a4650",

        waveBlue1 = "#1e4652",
        waveBlue2 = "#2a5666",

        winterGreen = "#1a3638",
        winterYellow = "#1f3e42",
        winterRed = "#1a3034",
        winterBlue = "#253840",
        autumnGreen = "#4a8a8c",
        autumnRed = "#3a7a8c",
        autumnYellow = "#5c9aa8",

        samuraiRed = "#29a0a9",
        roninYellow = "#34b8bb",
        waveAqua1 = "#5dcec2",
        dragonBlue = "#659494",

        oldWhite = "#a8e0d6",
        fujiWhite = "#b8ede6",
        fujiGray = "#4a7c7c",

        oniViolet = "#5b9dbf",
        oniViolet2 = "#7bb7d0",
        crystalBlue = "#7ebcd8",
        springViolet1 = "#6a9caa",
        springViolet2 = "#7cbbca",
        springBlue = "#7fc4ca",
        lightBlue = "#a3e4d5",
        waveAqua2 = "#7ab8af",

        springGreen = "#c8d8f0",
        boatYellow1 = "#4a8080",
        boatYellow2 = "#5a9090",
        carpYellow = "#6aa0a0",

        sakuraPink = "#6a9fb5",
        waveRed = "#4a8fa8",
        peachRed = "#3a7f98",
        surimiOrange = "#5a9fb8",
        katanaGray = "#518c8c",
      },
      overrides = {
        Visual = { bg = "#1a5a5a" },
        Normal = { bg = "#121516" },
        TelescopeNormal = { bg = "#0f1314" },
        TelescopeBorder = { bg = "#0f1314", fg = "#3a6f6a" },
        TelescopePromptNormal = { bg = "#0f1314" },
      }
    },
    custom = {
      accent = "#34b8bb",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#5dcec2",
      cursor_line = "#5dcec2",
      line_number = "#3a6f6a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a8e0d6",
    }
  },

  [ "sky (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0f1824",
        sumiInk1 = "#121c2a",
        sumiInk2 = "#15202f",
        sumiInk3 = "#182434",
        sumiInk4 = "#1c2a3c",
        sumiInk5 = "#223248",
        sumiInk6 = "#324a68",

        waveBlue1 = "#2a4a68",
        waveBlue2 = "#365a78",

        winterGreen = "#223a48",
        winterYellow = "#28425a",
        winterRed = "#223448",
        winterBlue = "#2e3c50",
        autumnGreen = "#528aac",
        autumnRed = "#427abc",
        autumnYellow = "#649ac8",

        samuraiRed = "#3990d9",
        roninYellow = "#44a8eb",
        waveAqua1 = "#6dbef2",
        dragonBlue = "#6d95b4",

        oldWhite = "#b0d0f6",
        fujiWhite = "#c0ddfd",
        fujiGray = "#527bac",

        oniViolet = "#639dcf",
        oniViolet2 = "#83b7e0",
        crystalBlue = "#86bce8",
        springViolet1 = "#729cca",
        springViolet2 = "#84bbda",
        springBlue = "#87c4da",
        lightBlue = "#abd4e5",
        waveAqua2 = "#82b8cf",

        springGreen = "#d0e0ff",
        boatYellow1 = "#528090",
        boatYellow2 = "#6290a0",
        carpYellow = "#72a0b0",

        sakuraPink = "#729fc5",
        waveRed = "#528fb8",
        peachRed = "#427fa8",
        surimiOrange = "#629fc8",
        katanaGray = "#598cac",
      },
      overrides = {
        Visual = { bg = "#225a8a" },
        Normal = { bg = "#16181c" },
        TelescopeNormal = { bg = "#12141a" },
        TelescopeBorder = { bg = "#12141a", fg = "#426f9a" },
        TelescopePromptNormal = { bg = "#12141a" },
      }
    },
    custom = {
      accent = "#44a8eb",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#6dbef2",
      cursor_line = "#6dbef2",
      line_number = "#426f9a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#b0d0f6",
    }
  },

  [ "sky2 (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0f1824",
        sumiInk1 = "#121c2a",
        sumiInk2 = "#15202f",
        sumiInk3 = "#182434",
        sumiInk4 = "#1c2a3c",
        sumiInk5 = "#223248",
        sumiInk6 = "#324a68",

        waveBlue1 = "#3a5f90",
        waveBlue2 = "#4a6fa0",

        winterGreen = "#2a4a70",
        winterYellow = "#325070",
        winterRed = "#2a4570",
        winterBlue = "#364d70",
        autumnGreen = "#62b0f0",
        autumnRed = "#529ef0",
        autumnYellow = "#84c8ff",

        samuraiRed = "#59c6ff",
        roninYellow = "#64ddff",
        waveAqua1 = "#8de8ff",
        dragonBlue = "#8db9e0",

        oldWhite = "#d0efff",
        fujiWhite = "#e0f8ff",
        fujiGray = "#729ed8",

        oniViolet = "#83d0ff",
        oniViolet2 = "#a3daff",
        crystalBlue = "#a6dfff",
        springViolet1 = "#92cfff",
        springViolet2 = "#a4deff",
        springBlue = "#a7e7ff",
        lightBlue = "#cbe7ff",
        waveAqua2 = "#a2dbff",

        springGreen = "#7eb9ff",
        boatYellow1 = "#72a5d0",
        boatYellow2 = "#82b5e0",
        carpYellow = "#92c5f0",

        sakuraPink = "#92d2ff",
        waveRed = "#72c2e8",
        peachRed = "#62b2d8",
        surimiOrange = "#82d2ff",
        katanaGray = "#79afec",
      },
      overrides = {
        Visual = { bg = "#3a7dc0" },
        Normal = { bg = "#16181c" },
        TelescopeNormal = { bg = "#12141a" },
        TelescopeBorder = { bg = "#12141a", fg = "#62a2e0" },
        TelescopePromptNormal = { bg = "#12141a" },
      }
    },
    custom = {
      accent = "#64ddff",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.7 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.95 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.5 )
      end,
      light_blue = "#8de8ff",
      cursor_line = "#8de8ff",
      line_number = "#62a2e0",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.95 )
      end,
      notify_info_body = "#d0efff",
    }
  },

  [ "steel (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0c0e14",
        sumiInk1 = "#0e111a",
        sumiInk2 = "#10141e",
        sumiInk3 = "#121722",
        sumiInk4 = "#161b28",
        sumiInk5 = "#1c2232",
        sumiInk6 = "#2c3a4e",

        waveBlue1 = "#243244",
        waveBlue2 = "#304254",

        winterGreen = "#1c2a34",
        winterYellow = "#22323e",
        winterRed = "#1c2630",
        winterBlue = "#282c3a",
        autumnGreen = "#4c6a7c",
        autumnRed = "#3c5a7c",
        autumnYellow = "#5e7a98",

        samuraiRed = "#2970a9",
        roninYellow = "#3488cb",
        waveAqua1 = "#5d9ec2",
        dragonBlue = "#657584",

        oldWhite = "#a8c0d6",
        fujiWhite = "#b8cde6",
        fujiGray = "#4a5b6c",

        oniViolet = "#5b7daf",
        oniViolet2 = "#7b97c0",
        crystalBlue = "#7e9cc8",
        springViolet1 = "#6a8caa",
        springViolet2 = "#7c9bba",
        springBlue = "#7fa4ba",
        lightBlue = "#a3c4d5",
        waveAqua2 = "#7aa89f",

        springGreen = "#c8d8e0",
        boatYellow1 = "#4a6070",
        boatYellow2 = "#5a7080",
        carpYellow = "#6a8090",

        sakuraPink = "#6a8fa5",
        waveRed = "#4a7f98",
        peachRed = "#3a6f88",
        surimiOrange = "#5a8fa8",
        katanaGray = "#516c7c",
      },
      overrides = {
        Visual = { bg = "#1e3a4a" },
        Normal = { bg = "#111416" },
        TelescopeNormal = { bg = "#0f1114" },
        TelescopeBorder = { bg = "#0f1114", fg = "#3a4f5a" },
        TelescopePromptNormal = { bg = "#0f1114" },
      }
    },
    custom = {
      accent = "#3488cb",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#5d9ec2",
      cursor_line = "#5d9ec2",
      line_number = "#3a4f5a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a8c0d6",
    }
  },

  [ "cobalt (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0a0c18",
        sumiInk1 = "#0c0e1c",
        sumiInk2 = "#0e1020",
        sumiInk3 = "#101224",
        sumiInk4 = "#14162c",
        sumiInk5 = "#1a1c36",
        sumiInk6 = "#2a2c50",

        waveBlue1 = "#1e2652",
        waveBlue2 = "#2a3666",

        winterGreen = "#1a2238",
        winterYellow = "#1f2a42",
        winterRed = "#1a2034",
        winterBlue = "#252840",
        autumnGreen = "#4a5a8c",
        autumnRed = "#3a4a8c",
        autumnYellow = "#5c6aa8",

        samuraiRed = "#2950b9",
        roninYellow = "#3468db",
        waveAqua1 = "#5d7ee2",
        dragonBlue = "#655594",

        oldWhite = "#a8b0e6",
        fujiWhite = "#b8bded",
        fujiGray = "#4a4b7c",

        oniViolet = "#5b5dbf",
        oniViolet2 = "#7b77d0",
        crystalBlue = "#7e7cd8",
        springViolet1 = "#6a6caa",
        springViolet2 = "#7c7bca",
        springBlue = "#7f84ca",
        lightBlue = "#a3a4d5",
        waveAqua2 = "#7a88af",

        springGreen = "#6c88bb",
        boatYellow1 = "#4a4080",
        boatYellow2 = "#5a5090",
        carpYellow = "#6a60a0",

        sakuraPink = "#6a6fb5",
        waveRed = "#4a5fa8",
        peachRed = "#3a4f98",
        surimiOrange = "#5a6fb8",
        katanaGray = "#514c8c",
      },
      overrides = {
        Visual = { bg = "#1e2a6a" },
        Normal = { bg = "#101214" },
        TelescopeNormal = { bg = "#0e1012" },
        TelescopeBorder = { bg = "#0e1012", fg = "#3a3f7a" },
        TelescopePromptNormal = { bg = "#0e1012" },
      }
    },
    custom = {
      accent = "#3468db",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#5d7ee2",
      cursor_line = "#5d7ee2",
      line_number = "#3a3f7a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a8b0e6",
    }
  },

  [ "cobalt2 (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0a0c18",
        sumiInk1 = "#0c0e1c",
        sumiInk2 = "#0e1020",
        sumiInk3 = "#101224",
        sumiInk4 = "#14162c",
        sumiInk5 = "#1a1c36",
        sumiInk6 = "#2a2c50",

        waveBlue1 = "#2e3662",
        waveBlue2 = "#3a4676",

        winterGreen = "#2a2248",
        winterYellow = "#2f3052",
        winterRed = "#2a2044",
        winterBlue = "#353850",
        autumnGreen = "#6a7aac",
        autumnRed = "#5a6aac",
        autumnYellow = "#7c8ac8",

        samuraiRed = "#4970d9",
        roninYellow = "#5488fb",
        waveAqua1 = "#7d9eff",
        dragonBlue = "#8575b4",

        oldWhite = "#c8d0ff",
        fujiWhite = "#d8e0ff",
        fujiGray = "#6a6b9c",

        oniViolet = "#7b7ddf",
        oniViolet2 = "#9b97f0",
        crystalBlue = "#9e9cf8",
        springViolet1 = "#8a8cca",
        springViolet2 = "#9c9bea",
        springBlue = "#9f84ea",
        lightBlue = "#c3c4f5",
        waveAqua2 = "#9aa8cf",

        springGreen = "#c8d0ff",
        boatYellow1 = "#6a60a0",
        boatYellow2 = "#7a70b0",
        carpYellow = "#8a80c0",

        sakuraPink = "#8a8fd5",
        waveRed = "#6a7fc8",
        peachRed = "#5a6fb8",
        surimiOrange = "#7a8fd8",
        katanaGray = "#716cac",
      },
      overrides = {
        Visual = { bg = "#3e4a8a" },
        Normal = { bg = "#101214" },
        TelescopeNormal = { bg = "#0e1012" },
        TelescopeBorder = { bg = "#0e1012", fg = "#5a5f9a" },
        TelescopePromptNormal = { bg = "#0e1012" },
      }
    },
    custom = {
      accent = "#5488fb",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.7 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.95 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.5 )
      end,
      light_blue = "#7d9eff",
      cursor_line = "#7d9eff",
      line_number = "#5a5f9a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.95 )
      end,
      notify_info_body = "#c8d0ff",
    }
  },

  [ "frost (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#101620",
        sumiInk1 = "#131a26",
        sumiInk2 = "#161e2c",
        sumiInk3 = "#192232",
        sumiInk4 = "#1d283a",
        sumiInk5 = "#233046",
        sumiInk6 = "#334860",

        waveBlue1 = "#2b4862",
        waveBlue2 = "#375872",

        winterGreen = "#233846",
        winterYellow = "#294052",
        winterRed = "#233442",
        winterBlue = "#2f3c4c",
        autumnGreen = "#5388a8",
        autumnRed = "#4378b8",
        autumnYellow = "#6598c4",

        samuraiRed = "#3a8ed4",
        roninYellow = "#45a6e6",
        waveAqua1 = "#6ebcee",
        dragonBlue = "#6e93b0",

        oldWhite = "#b1cef2",
        fujiWhite = "#c1dbf9",
        fujiGray = "#5379a8",

        oniViolet = "#649bcb",
        oniViolet2 = "#84b5dc",
        crystalBlue = "#87bae4",
        springViolet1 = "#739ac6",
        springViolet2 = "#85b9d6",
        springBlue = "#88c2d6",
        lightBlue = "#acd2e1",
        waveAqua2 = "#83b6cb",

        springGreen = "#d0e8ff",
        boatYellow1 = "#537e8c",
        boatYellow2 = "#638e9c",
        carpYellow = "#739eac",

        sakuraPink = "#739dc1",
        waveRed = "#538db4",
        peachRed = "#437da4",
        surimiOrange = "#639dc4",
        katanaGray = "#5a8aa8",
      },
      overrides = {
        Visual = { bg = "#235886" },
        Normal = { bg = "#15171c" },
        TelescopeNormal = { bg = "#121418" },
        TelescopeBorder = { bg = "#121418", fg = "#436d96" },
        TelescopePromptNormal = { bg = "#121418" },
      }
    },
    custom = {
      accent = "#45a6e6",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#6ebcee",
      cursor_line = "#6ebcee",
      line_number = "#436d96",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#b1cef2",
    }
  },

  [ "teal_night (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#081214",
        sumiInk1 = "#0a1618",
        sumiInk2 = "#0c1a1c",
        sumiInk3 = "#0e1e20",
        sumiInk4 = "#122426",
        sumiInk5 = "#182c30",
        sumiInk6 = "#284446",

        waveBlue1 = "#204450",
        waveBlue2 = "#2c5460",

        winterGreen = "#143436",
        winterYellow = "#1a3c40",
        winterRed = "#14302e",
        winterBlue = "#203842",
        autumnGreen = "#408480",
        autumnRed = "#307490",
        autumnYellow = "#5294a0",

        samuraiRed = "#258aa0",
        roninYellow = "#30a2b2",
        waveAqua1 = "#59b8c8",
        dragonBlue = "#5b8e90",

        oldWhite = "#a4cace",
        fujiWhite = "#b4d7de",
        fujiGray = "#467674",

        oniViolet = "#5797b4",
        oniViolet2 = "#77b1c4",
        crystalBlue = "#7ab6ce",
        springViolet1 = "#6696a4",
        springViolet2 = "#78b5c4",
        springBlue = "#7bbec4",
        lightBlue = "#9fcecc",
        waveAqua2 = "#76b2ac",

        springGreen = "#c8e0e0",
        boatYellow1 = "#467a7c",
        boatYellow2 = "#568a8c",
        carpYellow = "#669a9c",

        sakuraPink = "#6699ac",
        waveRed = "#468994",
        peachRed = "#367984",
        surimiOrange = "#5699a4",
        katanaGray = "#4d8684",
      },
      overrides = {
        Visual = { bg = "#185456" },
        Normal = { bg = "#111516" },
        TelescopeNormal = { bg = "#0e1214" },
        TelescopeBorder = { bg = "#0e1214", fg = "#366966" },
        TelescopePromptNormal = { bg = "#0e1214" },
      }
    },
    custom = {
      accent = "#30a2b2",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#59b8c8",
      cursor_line = "#59b8c8",
      line_number = "#366966",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a4cace",
    }
  },

  [ "blueish (blueish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0a0e14",
        sumiInk1 = "#0c1117",
        sumiInk2 = "#0e131a",
        sumiInk3 = "#10151d",
        sumiInk4 = "#141b26",
        sumiInk5 = "#1a2332",
        sumiInk6 = "#2a3f5e",

        waveBlue1 = "#1e3a5f",
        waveBlue2 = "#2d4f67",

        winterGreen = "#1a3340",
        winterYellow = "#1f3a4d",
        winterRed = "#1a2838",
        winterBlue = "#252535",
        autumnGreen = "#4a7a8c",
        autumnRed = "#3a6b8c",
        autumnYellow = "#5c8aa8",

        samuraiRed = "#2980b9",
        roninYellow = "#3498db",
        waveAqua1 = "#5dade2",
        dragonBlue = "#658594",

        oldWhite = "#a8d0e6",
        fujiWhite = "#b8dbed",
        fujiGray = "#4a6b7c",

        oniViolet = "#5b8dbf",
        oniViolet2 = "#7ba7d0",
        crystalBlue = "#7e9cd8",
        springViolet1 = "#6a8caa",
        springViolet2 = "#7cabca",
        springBlue = "#7fb4ca",
        lightBlue = "#a3d4d5",
        waveAqua2 = "#7aa8af",

        springGreen = "#bac9df",
        boatYellow1 = "#4a7080",
        boatYellow2 = "#5a8090",
        carpYellow = "#6a90a0",

        sakuraPink = "#6a8fb5",
        waveRed = "#4a7fa8",
        peachRed = "#3a6f98",
        surimiOrange = "#5a8fb8",
        katanaGray = "#517c8c",
      },
      overrides = {
        Visual = { bg = "#1a4a6a" },
        Normal = { bg = "#111418" },
        TelescopeNormal = { bg = "#0f1214" },
        TelescopeBorder = { bg = "#0f1214", fg = "#3a5f7a" },
        TelescopePromptNormal = { bg = "#0f1214" },
      }
    },
    custom = {
      accent = "#4a9fb8",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#2db7ff",
      cursor_line = "#5dade2",
      line_number = "#3a5f7a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a8d0e6",
    }
  },

  [ "forest (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0a140e",
        sumiInk1 = "#0c180f",
        sumiInk2 = "#0e1c11",
        sumiInk3 = "#102013",
        sumiInk4 = "#142617",
        sumiInk5 = "#1a321d",
        sumiInk6 = "#2a4e2f",

        waveBlue1 = "#1e4a35",
        waveBlue2 = "#2d5e47",

        winterGreen = "#1a3628",
        winterYellow = "#1f3a2d",
        winterRed = "#1a2e24",
        winterBlue = "#253530",
        autumnGreen = "#4a8052",
        autumnRed = "#3a7042",
        autumnYellow = "#5c9060",

        samuraiRed = "#29a045",
        roninYellow = "#34b857",
        waveAqua1 = "#5dce6f",
        dragonBlue = "#659462",

        oldWhite = "#a8e0b2",
        fujiWhite = "#b8edc2",
        fujiGray = "#4a7c56",

        oniViolet = "#5b9d6a",
        oniViolet2 = "#7bb780",
        crystalBlue = "#7ebc8a",
        springViolet1 = "#6a9c76",
        springViolet2 = "#7cbb8c",
        springBlue = "#7fc495",
        lightBlue = "#a3e4af",
        waveAqua2 = "#7ab896",

        springGreen = "#d0f0c0",
        boatYellow1 = "#4a8055",
        boatYellow2 = "#5a9065",
        carpYellow = "#6aa075",

        sakuraPink = "#6a9f7a",
        waveRed = "#4a8f6a",
        peachRed = "#3a7f5a",
        surimiOrange = "#5a9f7a",
        katanaGray = "#518c67",
      },
      overrides = {
        Visual = { bg = "#1a4a35" },
        Normal = { bg = "#111514" },
        TelescopeNormal = { bg = "#0e1212" },
        TelescopeBorder = { bg = "#0e1212", fg = "#3a5f45" },
        TelescopePromptNormal = { bg = "#0e1212" },
      }
    },
    custom = {
      accent = "#34b857",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#5dce6f",
      cursor_line = "#5dce6f",
      line_number = "#3a5f45",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a8e0b2",
    }
  },

  [ "emerald (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#08141a",
        sumiInk1 = "#0a181d",
        sumiInk2 = "#0c1c20",
        sumiInk3 = "#0e2023",
        sumiInk4 = "#122629",
        sumiInk5 = "#182e33",
        sumiInk6 = "#284649",

        waveBlue1 = "#1e464f",
        waveBlue2 = "#2a5663",

        winterGreen = "#1a3a3f",
        winterYellow = "#1f4045",
        winterRed = "#1a3237",
        winterBlue = "#253842",
        autumnGreen = "#4a847f",
        autumnRed = "#3a746f",
        autumnYellow = "#5c949f",

        samuraiRed = "#2997a5",
        roninYellow = "#34afbd",
        waveAqua1 = "#5dc5d3",
        dragonBlue = "#65949a",

        oldWhite = "#a8dde3",
        fujiWhite = "#96bfc5",
        fujiGray = "#4a7a7f",

        oniViolet = "#5b9ba6",
        oniViolet2 = "#7bb5c0",
        crystalBlue = "#7ebaca",
        springViolet1 = "#6a9aa5",
        springViolet2 = "#7cb9c4",
        springBlue = "#7fc2c7",
        lightBlue = "#a3e2e7",
        waveAqua2 = "#7ab6bb",

        springGreen = "#80bc98",
        boatYellow1 = "#4a7e83",
        boatYellow2 = "#5a8e93",
        carpYellow = "#6a9ea3",

        sakuraPink = "#6a9db8",
        waveRed = "#4a8da2",
        peachRed = "#3a7d92",
        surimiOrange = "#5a9db8",
        katanaGray = "#518a9f",
      },
      overrides = {
        Visual = { bg = "#1a4a55" },
        Normal = { bg = "#111516" },
        TelescopeNormal = { bg = "#0d1214" },
        TelescopeBorder = { bg = "#0d1214", fg = "#3a5f6a" },
        TelescopePromptNormal = { bg = "#0d1214" },
      }
    },
    custom = {
      accent = "#34afbd",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#5dc5d3",
      cursor_line = "#5dc5d3",
      line_number = "#3a5f6a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a8dde3",
    }
  },

  [ "jade (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#061418",
        sumiInk1 = "#08181c",
        sumiInk2 = "#0a1c20",
        sumiInk3 = "#0c2024",
        sumiInk4 = "#102628",
        sumiInk5 = "#162c30",
        sumiInk6 = "#26444c",

        waveBlue1 = "#1c444c",
        waveBlue2 = "#285460",

        winterGreen = "#18363e",
        winterYellow = "#1d3e46",
        winterRed = "#182e36",
        winterBlue = "#233640",
        autumnGreen = "#48827a",
        autumnRed = "#38726a",
        autumnYellow = "#5a929a",

        samuraiRed = "#27959d",
        roninYellow = "#32adb5",
        waveAqua1 = "#5bc3cb",
        dragonBlue = "#639298",

        oldWhite = "#a6dbe1",
        fujiWhite = "#b6e8ee",
        fujiGray = "#48787e",

        oniViolet = "#5999a4",
        oniViolet2 = "#79b3be",
        crystalBlue = "#7cb8c8",
        springViolet1 = "#6898a3",
        springViolet2 = "#7ab7c2",
        springBlue = "#7dc0c5",
        lightBlue = "#a1e0e5",
        waveAqua2 = "#78b4b9",

        springGreen = "#c8f0e0",
        boatYellow1 = "#487c81",
        boatYellow2 = "#588c91",
        carpYellow = "#689ca1",

        sakuraPink = "#689bb6",
        waveRed = "#488ba0",
        peachRed = "#387b90",
        surimiOrange = "#589bb6",
        katanaGray = "#4f889d",
      },
      overrides = {
        Visual = { bg = "#184853" },
        Normal = { bg = "#101516" },
        TelescopeNormal = { bg = "#0c1214" },
        TelescopeBorder = { bg = "#0c1214", fg = "#385d68" },
        TelescopePromptNormal = { bg = "#0c1214" },
      }
    },
    custom = {
      accent = "#32adb5",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#5bc3cb",
      cursor_line = "#5bc3cb",
      line_number = "#385d68",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a6dbe1",
    }
  },

  [ "mint (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0e1814",
        sumiInk1 = "#111c17",
        sumiInk2 = "#14201a",
        sumiInk3 = "#17241d",
        sumiInk4 = "#1b2a23",
        sumiInk5 = "#213229",
        sumiInk6 = "#314a3f",

        waveBlue1 = "#294a40",
        waveBlue2 = "#355a50",

        winterGreen = "#213a32",
        winterYellow = "#264237",
        winterRed = "#21342e",
        winterBlue = "#2c3c38",
        autumnGreen = "#518a7c",
        autumnRed = "#417a6c",
        autumnYellow = "#639a8c",

        samuraiRed = "#38a090",
        roninYellow = "#43b8a8",
        waveAqua1 = "#6cced3",
        dragonBlue = "#6c95a0",

        oldWhite = "#afe0dc",
        fujiWhite = "#bfede9",
        fujiGray = "#518076",

        oniViolet = "#629daa",
        oniViolet2 = "#82b7c4",
        crystalBlue = "#85bcd0",
        springViolet1 = "#719ca9",
        springViolet2 = "#83bbc8",
        springBlue = "#86c4cb",
        lightBlue = "#aae4e1",
        waveAqua2 = "#81b8bd",

        springGreen = "#d8f0e8",
        boatYellow1 = "#51808d",
        boatYellow2 = "#61909d",
        carpYellow = "#71a0ad",

        sakuraPink = "#719fc2",
        waveRed = "#5195aa",
        peachRed = "#4185a0",
        surimiOrange = "#619fc2",
        katanaGray = "#588ca1",
      },
      overrides = {
        Visual = { bg = "#215a50" },
        Normal = { bg = "#141716" },
        TelescopeNormal = { bg = "#111414" },
        TelescopeBorder = { bg = "#111414", fg = "#416166" },
        TelescopePromptNormal = { bg = "#111414" },
      }
    },
    custom = {
      accent = "#43b8a8",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#6cced3",
      cursor_line = "#6cced3",
      line_number = "#416166",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#afe0dc",
    }
  },

  [ "sage (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#101810",
        sumiInk1 = "#131c13",
        sumiInk2 = "#162016",
        sumiInk3 = "#192419",
        sumiInk4 = "#1d2a1f",
        sumiInk5 = "#233225",
        sumiInk6 = "#334a3b",

        waveBlue1 = "#2b4a3d",
        waveBlue2 = "#375a4d",

        winterGreen = "#233a30",
        winterYellow = "#284235",
        winterRed = "#23342c",
        winterBlue = "#2e3c34",
        autumnGreen = "#538a78",
        autumnRed = "#437a68",
        autumnYellow = "#659a88",

        samuraiRed = "#3aa08c",
        roninYellow = "#45b89e",
        waveAqua1 = "#6eced1",
        dragonBlue = "#6e959e",

        oldWhite = "#b1e0da",
        fujiWhite = "#c1ede7",
        fujiGray = "#537e74",

        oniViolet = "#649da8",
        oniViolet2 = "#84b7c2",
        crystalBlue = "#87bcce",
        springViolet1 = "#739ca7",
        springViolet2 = "#85bbc6",
        springBlue = "#88c4c9",
        lightBlue = "#ace4df",
        waveAqua2 = "#83b8bb",

        springGreen = "#d8f8e0",
        boatYellow1 = "#53808b",
        boatYellow2 = "#63909b",
        carpYellow = "#73a0ab",

        sakuraPink = "#739fc0",
        waveRed = "#5395a8",
        peachRed = "#43859e",
        surimiOrange = "#639fc0",
        katanaGray = "#5a8c9f",
      },
      overrides = {
        Visual = { bg = "#235a4d" },
        Normal = { bg = "#161716" },
        TelescopeNormal = { bg = "#121412" },
        TelescopeBorder = { bg = "#121412", fg = "#436164" },
        TelescopePromptNormal = { bg = "#121412" },
      }
    },
    custom = {
      accent = "#45b89e",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#6eced1",
      cursor_line = "#6eced1",
      line_number = "#436164",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#b1e0da",
    }
  },

  [ "sea_foam (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0c1614",
        sumiInk1 = "#0f1a17",
        sumiInk2 = "#121e1a",
        sumiInk3 = "#15221d",
        sumiInk4 = "#192823",
        sumiInk5 = "#1f3029",
        sumiInk6 = "#2f483f",

        waveBlue1 = "#27483b",
        waveBlue2 = "#33584b",

        winterGreen = "#1f382e",
        winterYellow = "#244033",
        winterRed = "#1f322a",
        winterBlue = "#2a3a32",
        autumnGreen = "#4f8a76",
        autumnRed = "#3f7a66",
        autumnYellow = "#619a86",

        samuraiRed = "#36a08a",
        roninYellow = "#41b89c",
        waveAqua1 = "#6acecf",
        dragonBlue = "#6a959c",

        oldWhite = "#ade0d8",
        fujiWhite = "#bdede5",
        fujiGray = "#4f7e72",

        oniViolet = "#609da6",
        oniViolet2 = "#80b7c0",
        crystalBlue = "#83bccc",
        springViolet1 = "#6f9ca5",
        springViolet2 = "#81bbc4",
        springBlue = "#84c4c7",
        lightBlue = "#a8e4dd",
        waveAqua2 = "#7fb8b9",

        springGreen = "#d0f0e0",
        boatYellow1 = "#4f8089",
        boatYellow2 = "#5f9099",
        carpYellow = "#6fa0a9",

        sakuraPink = "#6f9fbe",
        waveRed = "#4f95a6",
        peachRed = "#3f859c",
        surimiOrange = "#5f9fbe",
        katanaGray = "#568c9d",
      },
      overrides = {
        Visual = { bg = "#1f584b" },
        Normal = { bg = "#131616" },
        TelescopeNormal = { bg = "#0f1314" },
        TelescopeBorder = { bg = "#0f1314", fg = "#3f6162" },
        TelescopePromptNormal = { bg = "#0f1314" },
      }
    },
    custom = {
      accent = "#41b89c",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#6acecf",
      cursor_line = "#6acecf",
      line_number = "#3f6162",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#ade0d8",
    }
  },

  [ "turquoise (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0a1416",
        sumiInk1 = "#0d1819",
        sumiInk2 = "#101c1c",
        sumiInk3 = "#13201f",
        sumiInk4 = "#172625",
        sumiInk5 = "#1d2e2b",
        sumiInk6 = "#2d4641",

        waveBlue1 = "#254639",
        waveBlue2 = "#315649",

        winterGreen = "#1d362c",
        winterYellow = "#223e31",
        winterRed = "#1d3028",
        winterBlue = "#283830",
        autumnGreen = "#4d8874",
        autumnRed = "#3d7864",
        autumnYellow = "#5f9884",

        samuraiRed = "#349e88",
        roninYellow = "#3fb69a",
        waveAqua1 = "#68cccd",
        dragonBlue = "#68939a",

        oldWhite = "#abddd6",
        fujiWhite = "#bbeae3",
        fujiGray = "#4d7c70",

        oniViolet = "#5e9ba4",
        oniViolet2 = "#7eb5be",
        crystalBlue = "#81baca",
        springViolet1 = "#6d9aa3",
        springViolet2 = "#7fb9c2",
        springBlue = "#82c2c5",
        lightBlue = "#a6e2db",
        waveAqua2 = "#7db6b7",

        springGreen = "#d0f8e8",
        boatYellow1 = "#4d7e87",
        boatYellow2 = "#5d8e97",
        carpYellow = "#6d9ea7",

        sakuraPink = "#6d9dbc",
        waveRed = "#4d93a4",
        peachRed = "#3d839a",
        surimiOrange = "#5d9dbc",
        katanaGray = "#548a9b",
      },
      overrides = {
        Visual = { bg = "#1d5649" },
        Normal = { bg = "#121616" },
        TelescopeNormal = { bg = "#0e1314" },
        TelescopeBorder = { bg = "#0e1314", fg = "#3d5f60" },
        TelescopePromptNormal = { bg = "#0e1314" },
      }
    },
    custom = {
      accent = "#3fb69a",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#68cccd",
      cursor_line = "#68cccd",
      line_number = "#3d5f60",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#abddd6",
    }
  },

  [ "aqua (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#061214",
        sumiInk1 = "#091617",
        sumiInk2 = "#0c1a1a",
        sumiInk3 = "#0f1e1d",
        sumiInk4 = "#132423",
        sumiInk5 = "#192c29",
        sumiInk6 = "#29443f",

        waveBlue1 = "#234437",
        waveBlue2 = "#2f5447",

        winterGreen = "#1b342a",
        winterYellow = "#203c2f",
        winterRed = "#1b2e26",
        winterBlue = "#26362e",
        autumnGreen = "#4b8672",
        autumnRed = "#3b7662",
        autumnYellow = "#5d9682",

        samuraiRed = "#329c86",
        roninYellow = "#3db498",
        waveAqua1 = "#66cacb",
        dragonBlue = "#669198",

        oldWhite = "#a9dbd4",
        fujiWhite = "#b9e8e1",
        fujiGray = "#4b7a6e",

        oniViolet = "#5c99a2",
        oniViolet2 = "#7cb3bc",
        crystalBlue = "#7fb8c8",
        springViolet1 = "#6b98a1",
        springViolet2 = "#7db7c0",
        springBlue = "#80c0c3",
        lightBlue = "#a4e0d9",
        waveAqua2 = "#7bb4b5",

        springGreen = "#c8f0e0",
        boatYellow1 = "#4b7c85",
        boatYellow2 = "#5b8c95",
        carpYellow = "#6b9ca5",

        sakuraPink = "#6b9bba",
        waveRed = "#4b91a2",
        peachRed = "#3b8198",
        surimiOrange = "#5b9bba",
        katanaGray = "#528899",
      },
      overrides = {
        Visual = { bg = "#1b5447" },
        Normal = { bg = "#111516" },
        TelescopeNormal = { bg = "#0c1212" },
        TelescopeBorder = { bg = "#0c1212", fg = "#3b5d5e" },
        TelescopePromptNormal = { bg = "#0c1212" },
      }
    },
    custom = {
      accent = "#3db498",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#66cacb",
      cursor_line = "#66cacb",
      line_number = "#3b5d5e",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#a9dbd4",
    }
  },

  [ "pine (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#081812",
        sumiInk1 = "#0b1c15",
        sumiInk2 = "#0e2018",
        sumiInk3 = "#11241b",
        sumiInk4 = "#152a21",
        sumiInk5 = "#1b3227",
        sumiInk6 = "#2b4a3d",

        waveBlue1 = "#274a39",
        waveBlue2 = "#335a49",

        winterGreen = "#1f3a2e",
        winterYellow = "#244233",
        winterRed = "#1f342a",
        winterBlue = "#2a3c32",
        autumnGreen = "#4f8a7a",
        autumnRed = "#3f7a6a",
        autumnYellow = "#619a8a",

        samuraiRed = "#36a08e",
        roninYellow = "#41b8a0",
        waveAqua1 = "#6acedd",
        dragonBlue = "#6a95a0",

        oldWhite = "#ade0dc",
        fujiWhite = "#bdeee9",
        fujiGray = "#4f8076",

        oniViolet = "#609daa",
        oniViolet2 = "#80b7c4",
        crystalBlue = "#83bcd0",
        springViolet1 = "#6f9ca9",
        springViolet2 = "#81bbc8",
        springBlue = "#84c4cb",
        lightBlue = "#a8e4e1",
        waveAqua2 = "#7fb8bd",

        springGreen = "#d8f8e8",
        boatYellow1 = "#4f808d",
        boatYellow2 = "#5f909d",
        carpYellow = "#6fa0ad",

        sakuraPink = "#6f9fc2",
        waveRed = "#4f95aa",
        peachRed = "#3f85a0",
        surimiOrange = "#5f9fc2",
        katanaGray = "#568ca1",
      },
      overrides = {
        Visual = { bg = "#1f5a49" },
        Normal = { bg = "#111615" },
        TelescopeNormal = { bg = "#0d1312" },
        TelescopeBorder = { bg = "#0d1312", fg = "#3f6166" },
        TelescopePromptNormal = { bg = "#0d1312" },
      }
    },
    custom = {
      accent = "#41b8a0",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#6acedd",
      cursor_line = "#6acedd",
      line_number = "#3f6166",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#ade0dc",
    }
  },

  [ "viridian (tealish)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#0a1610",
        sumiInk1 = "#0d1a13",
        sumiInk2 = "#101e16",
        sumiInk3 = "#132219",
        sumiInk4 = "#17281f",
        sumiInk5 = "#1d3025",
        sumiInk6 = "#2d483b",

        waveBlue1 = "#29483b",
        waveBlue2 = "#35584b",

        winterGreen = "#21382e",
        winterYellow = "#264033",
        winterRed = "#21322a",
        winterBlue = "#2c3a32",
        autumnGreen = "#518a78",
        autumnRed = "#417a68",
        autumnYellow = "#639a88",

        samuraiRed = "#38a08c",
        roninYellow = "#43b89e",
        waveAqua1 = "#6ccedb",
        dragonBlue = "#6c959e",

        oldWhite = "#afe0da",
        fujiWhite = "#bfede7",
        fujiGray = "#517e74",

        oniViolet = "#629da8",
        oniViolet2 = "#82b7c2",
        crystalBlue = "#85bcce",
        springViolet1 = "#719ca7",
        springViolet2 = "#83bbc6",
        springBlue = "#86c4c9",
        lightBlue = "#aae4df",
        waveAqua2 = "#81b8bb",

        springGreen = "#d8f0e0",
        boatYellow1 = "#51808b",
        boatYellow2 = "#61909b",
        carpYellow = "#71a0ab",

        sakuraPink = "#719fc0",
        waveRed = "#5195a8",
        peachRed = "#41859e",
        surimiOrange = "#619fc0",
        katanaGray = "#588c9f",
      },
      overrides = {
        Visual = { bg = "#21584b" },
        Normal = { bg = "#121614" },
        TelescopeNormal = { bg = "#0e1310" },
        TelescopeBorder = { bg = "#0e1310", fg = "#416164" },
        TelescopePromptNormal = { bg = "#0e1310" },
      }
    },
    custom = {
      accent = "#43b89e",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#6ccedb",
      cursor_line = "#6ccedb",
      line_number = "#416164",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#afe0da",
    }
  },

  [ "sunset (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#140a06",
        sumiInk1 = "#180c08",
        sumiInk2 = "#1c0e0a",
        sumiInk3 = "#20100c",
        sumiInk4 = "#261410",
        sumiInk5 = "#321a16",
        sumiInk6 = "#4e2a20",

        waveBlue1 = "#4a1e14",
        waveBlue2 = "#5e2d1a",

        winterGreen = "#361a10",
        winterYellow = "#3a1f14",
        winterRed = "#2e1a10",
        winterBlue = "#352520",
        autumnGreen = "#804a30",
        autumnRed = "#703a20",
        autumnYellow = "#905c40",

        samuraiRed = "#a02920",
        roninYellow = "#b83430",
        waveAqua1 = "#ce5d40",
        dragonBlue = "#946558",

        oldWhite = "#e0a890",
        fujiWhite = "#edb8a0",
        fujiGray = "#7c4a30",

        oniViolet = "#9d5b40",
        oniViolet2 = "#b77b60",
        crystalBlue = "#bc7e70",
        springViolet1 = "#9c6a50",
        springViolet2 = "#bb7c60",
        springBlue = "#c47f70",
        lightBlue = "#e4a390",
        waveAqua2 = "#b87a60",

        springGreen = "#f0d8c0",
        boatYellow1 = "#804a30",
        boatYellow2 = "#905a40",
        carpYellow = "#a06a50",

        sakuraPink = "#9f6a50",
        waveRed = "#8f4a30",
        peachRed = "#7f3a20",
        surimiOrange = "#9f5a40",
        katanaGray = "#8c5140",
      },
      overrides = {
        Visual = { bg = "#4a1a10" },
        Normal = { bg = "#161210" },
        TelescopeNormal = { bg = "#120f0c" },
        TelescopeBorder = { bg = "#120f0c", fg = "#5f3a20" },
        TelescopePromptNormal = { bg = "#120f0c" },
      }
    },
    custom = {
      accent = "#b83430",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#ce5d40",
      cursor_line = "#ce5d40",
      line_number = "#5f3a20",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#e0a890",
    }
  },

  [ "amber (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#140e0a",
        sumiInk1 = "#181110",
        sumiInk2 = "#1c1414",
        sumiInk3 = "#201718",
        sumiInk4 = "#261d20",
        sumiInk5 = "#322328",
        sumiInk6 = "#4e3a40",

        waveBlue1 = "#4a2e30",
        waveBlue2 = "#5e3e40",

        winterGreen = "#362a28",
        winterYellow = "#3a2f2c",
        winterRed = "#2e2420",
        winterBlue = "#35302c",
        autumnGreen = "#805a54",
        autumnRed = "#704a44",
        autumnYellow = "#906a64",

        samuraiRed = "#a03920",
        roninYellow = "#b84a30",
        waveAqua1 = "#ce6d50",
        dragonBlue = "#947568",

        oldWhite = "#e0b8a0",
        fujiWhite = "#edc8b0",
        fujiGray = "#7c5a44",

        oniViolet = "#9d6b50",
        oniViolet2 = "#b78b70",
        crystalBlue = "#bc8e80",
        springViolet1 = "#9c7a60",
        springViolet2 = "#bb8c70",
        springBlue = "#c48f80",
        lightBlue = "#e4b3a0",
        waveAqua2 = "#b88a70",

        springGreen = "#f8e0c8",
        boatYellow1 = "#805a40",
        boatYellow2 = "#906a50",
        carpYellow = "#a07a60",

        sakuraPink = "#9f7a60",
        waveRed = "#8f5a40",
        peachRed = "#7f4a30",
        surimiOrange = "#9f6a50",
        katanaGray = "#8c6150",
      },
      overrides = {
        Visual = { bg = "#4a2a20" },
        Normal = { bg = "#16140e" },
        TelescopeNormal = { bg = "#12110d" },
        TelescopeBorder = { bg = "#12110d", fg = "#5f4a30" },
        TelescopePromptNormal = { bg = "#12110d" },
      }
    },
    custom = {
      accent = "#b84a30",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#ce6d50",
      cursor_line = "#ce6d50",
      line_number = "#5f4a30",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#e0b8a0",
    }
  },

  [ "copper (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#12100a",
        sumiInk1 = "#16140e",
        sumiInk2 = "#1a1812",
        sumiInk3 = "#1e1c16",
        sumiInk4 = "#24221c",
        sumiInk5 = "#302e24",
        sumiInk6 = "#4c4a3a",

        waveBlue1 = "#484638",
        waveBlue2 = "#585648",

        winterGreen = "#343028",
        winterYellow = "#38342c",
        winterRed = "#2c2820",
        winterBlue = "#333028",
        autumnGreen = "#7e7050",
        autumnRed = "#6e6040",
        autumnYellow = "#8e8060",

        samuraiRed = "#9e6020",
        roninYellow = "#b67030",
        waveAqua1 = "#cc8d50",
        dragonBlue = "#928560",

        oldWhite = "#deb890",
        fujiWhite = "#ebc8a0",
        fujiGray = "#7a6044",

        oniViolet = "#9b7150",
        oniViolet2 = "#b59170",
        crystalBlue = "#ba9480",
        springViolet1 = "#9a8060",
        springViolet2 = "#b99270",
        springBlue = "#c29580",
        lightBlue = "#e2b390",
        waveAqua2 = "#b69070",

        springGreen = "#f0d8c8",
        boatYellow1 = "#7e6040",
        boatYellow2 = "#8e7050",
        carpYellow = "#9e8060",

        sakuraPink = "#9d8060",
        waveRed = "#8d6040",
        peachRed = "#7d5030",
        surimiOrange = "#9d7050",
        katanaGray = "#8a6750",
      },
      overrides = {
        Visual = { bg = "#48302a" },
        Normal = { bg = "#15140f" },
        TelescopeNormal = { bg = "#11110d" },
        TelescopeBorder = { bg = "#11110d", fg = "#5d5030" },
        TelescopePromptNormal = { bg = "#11110d" },
      }
    },
    custom = {
      accent = "#b67030",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#cc8d50",
      cursor_line = "#cc8d50",
      line_number = "#5d5030",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#deb890",
    }
  },

  [ "rust (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#140c08",
        sumiInk1 = "#18100c",
        sumiInk2 = "#1c1410",
        sumiInk3 = "#201814",
        sumiInk4 = "#261e1a",
        sumiInk5 = "#322622",
        sumiInk6 = "#4e3e38",

        waveBlue1 = "#4a3632",
        waveBlue2 = "#5e4642",

        winterGreen = "#362a24",
        winterYellow = "#3a2e28",
        winterRed = "#2e2218",
        winterBlue = "#352a24",
        autumnGreen = "#805448",
        autumnRed = "#704438",
        autumnYellow = "#906458",

        samuraiRed = "#a03018",
        roninYellow = "#b84028",
        waveAqua1 = "#ce6548",
        dragonBlue = "#946e58",

        oldWhite = "#e0ac88",
        fujiWhite = "#edbca8",
        fujiGray = "#7c5838",

        oniViolet = "#9d6548",
        oniViolet2 = "#b78568",
        crystalBlue = "#bc8878",
        springViolet1 = "#9c7458",
        springViolet2 = "#bb8668",
        springBlue = "#c48978",
        lightBlue = "#e4ad88",
        waveAqua2 = "#b88468",

        springGreen = "#f0e0c0",
        boatYellow1 = "#805438",
        boatYellow2 = "#906448",
        carpYellow = "#a07458",

        sakuraPink = "#9f7458",
        waveRed = "#8f5438",
        peachRed = "#7f4428",
        surimiOrange = "#9f6448",
        katanaGray = "#8c5b48",
      },
      overrides = {
        Visual = { bg = "#4a2418" },
        Normal = { bg = "#16130f" },
        TelescopeNormal = { bg = "#12100c" },
        TelescopeBorder = { bg = "#12100c", fg = "#5f4428" },
        TelescopePromptNormal = { bg = "#12100c" },
      }
    },
    custom = {
      accent = "#b84028",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#ce6548",
      cursor_line = "#ce6548",
      line_number = "#5f4428",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#e0ac88",
    }
  },

  [ "bronze (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#10120a",
        sumiInk1 = "#14160e",
        sumiInk2 = "#181a12",
        sumiInk3 = "#1c1e16",
        sumiInk4 = "#22241c",
        sumiInk5 = "#2e3024",
        sumiInk6 = "#4a4c3a",

        waveBlue1 = "#464838",
        waveBlue2 = "#565848",

        winterGreen = "#303228",
        winterYellow = "#34362c",
        winterRed = "#282a20",
        winterBlue = "#2f3128",
        autumnGreen = "#7c7e50",
        autumnRed = "#6c6e40",
        autumnYellow = "#8c8e60",

        samuraiRed = "#9c6220",
        roninYellow = "#b47230",
        waveAqua1 = "#ca8f50",
        dragonBlue = "#909260",

        oldWhite = "#dcba90",
        fujiWhite = "#e9caa0",
        fujiGray = "#786244",

        oniViolet = "#997350",
        oniViolet2 = "#b39370",
        crystalBlue = "#b89680",
        springViolet1 = "#988260",
        springViolet2 = "#b79470",
        springBlue = "#c09780",
        lightBlue = "#e0b590",
        waveAqua2 = "#b49270",

        springGreen = "#e8d8c0",
        boatYellow1 = "#7c6240",
        boatYellow2 = "#8c7250",
        carpYellow = "#9c8260",

        sakuraPink = "#9b8260",
        waveRed = "#8b6240",
        peachRed = "#7b5230",
        surimiOrange = "#9b7250",
        katanaGray = "#886950",
      },
      overrides = {
        Visual = { bg = "#463228" },
        Normal = { bg = "#15150e" },
        TelescopeNormal = { bg = "#11120c" },
        TelescopeBorder = { bg = "#11120c", fg = "#5b5230" },
        TelescopePromptNormal = { bg = "#11120c" },
      }
    },
    custom = {
      accent = "#b47230",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#ca8f50",
      cursor_line = "#ca8f50",
      line_number = "#5b5230",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#dcba90",
    }
  },

  [ "peach (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#140a0e",
        sumiInk1 = "#180c12",
        sumiInk2 = "#1c0e16",
        sumiInk3 = "#20101a",
        sumiInk4 = "#261420",
        sumiInk5 = "#321a28",
        sumiInk6 = "#4e2a3e",

        waveBlue1 = "#4a1e32",
        waveBlue2 = "#5e2d42",

        winterGreen = "#361a28",
        winterYellow = "#3a1f2c",
        winterRed = "#2e1a20",
        winterBlue = "#35252a",
        autumnGreen = "#804a5c",
        autumnRed = "#703a4c",
        autumnYellow = "#905c6c",

        samuraiRed = "#a02938",
        roninYellow = "#b83448",
        waveAqua1 = "#ce5d68",
        dragonBlue = "#946568",

        oldWhite = "#e0a8b8",
        fujiWhite = "#edb8c8",
        fujiGray = "#7c4a58",

        oniViolet = "#9d5b68",
        oniViolet2 = "#b77b88",
        crystalBlue = "#bc7e98",
        springViolet1 = "#9c6a78",
        springViolet2 = "#bb7c88",
        springBlue = "#c47f98",
        lightBlue = "#e4a3b8",
        waveAqua2 = "#b87a88",

        springGreen = "#f0d8e0",
        boatYellow1 = "#804a58",
        boatYellow2 = "#905a68",
        carpYellow = "#a06a78",

        sakuraPink = "#9f6a78",
        waveRed = "#8f4a58",
        peachRed = "#7f3a48",
        surimiOrange = "#9f5a68",
        katanaGray = "#8c5168",
      },
      overrides = {
        Visual = { bg = "#4a1a28" },
        Normal = { bg = "#161212" },
        TelescopeNormal = { bg = "#120f11" },
        TelescopeBorder = { bg = "#120f11", fg = "#5f3a48" },
        TelescopePromptNormal = { bg = "#120f11" },
      }
    },
    custom = {
      accent = "#b83448",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#ce5d68",
      cursor_line = "#ce5d68",
      line_number = "#5f3a48",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#e0a8b8",
    }
  },

  [ "sienna (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#120a08",
        sumiInk1 = "#160c0a",
        sumiInk2 = "#1a0e0c",
        sumiInk3 = "#1e100e",
        sumiInk4 = "#241414",
        sumiInk5 = "#301a1a",
        sumiInk6 = "#4c2a2a",

        waveBlue1 = "#481e1e",
        waveBlue2 = "#582d2d",

        winterGreen = "#341a1a",
        winterYellow = "#381f1f",
        winterRed = "#2c1414",
        winterBlue = "#332020",
        autumnGreen = "#7e4a4a",
        autumnRed = "#6e3a3a",
        autumnYellow = "#8e5a5a",

        samuraiRed = "#9e2929",
        roninYellow = "#b63434",
        waveAqua1 = "#cc5d5d",
        dragonBlue = "#926565",

        oldWhite = "#dea8a8",
        fujiWhite = "#ebb8b8",
        fujiGray = "#7a4a4a",

        oniViolet = "#9b5b5b",
        oniViolet2 = "#b57b7b",
        crystalBlue = "#ba7e7e",
        springViolet1 = "#9a6a6a",
        springViolet2 = "#b97c7c",
        springBlue = "#c27f7f",
        lightBlue = "#e2a3a3",
        waveAqua2 = "#b67a7a",

        springGreen = "#f0d0d0",
        boatYellow1 = "#7e4a4a",
        boatYellow2 = "#8e5a5a",
        carpYellow = "#9e6a6a",

        sakuraPink = "#9d6a6a",
        waveRed = "#8d4a4a",
        peachRed = "#7d3a3a",
        surimiOrange = "#9d5a5a",
        katanaGray = "#8a5151",
      },
      overrides = {
        Visual = { bg = "#481a1a" },
        Normal = { bg = "#14120e" },
        TelescopeNormal = { bg = "#110f0c" },
        TelescopeBorder = { bg = "#110f0c", fg = "#5d3a3a" },
        TelescopePromptNormal = { bg = "#110f0c" },
      }
    },
    custom = {
      accent = "#b63434",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#cc5d5d",
      cursor_line = "#cc5d5d",
      line_number = "#5d3a3a",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#dea8a8",
    }
  },

  [ "caramel (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#100e0a",
        sumiInk1 = "#14120e",
        sumiInk2 = "#181612",
        sumiInk3 = "#1c1a16",
        sumiInk4 = "#22201c",
        sumiInk5 = "#2e2c24",
        sumiInk6 = "#4a483a",

        waveBlue1 = "#464438",
        waveBlue2 = "#565448",

        winterGreen = "#302e28",
        winterYellow = "#34322c",
        winterRed = "#282620",
        winterBlue = "#2f2d28",
        autumnGreen = "#7c7a50",
        autumnRed = "#6c6a40",
        autumnYellow = "#8c8a60",

        samuraiRed = "#9c5e20",
        roninYellow = "#b46e30",
        waveAqua1 = "#ca8b50",
        dragonBlue = "#908e60",

        oldWhite = "#dcb690",
        fujiWhite = "#e9c6a0",
        fujiGray = "#785e44",

        oniViolet = "#996f50",
        oniViolet2 = "#b38f70",
        crystalBlue = "#b89280",
        springViolet1 = "#987e60",
        springViolet2 = "#b79070",
        springBlue = "#c09380",
        lightBlue = "#e0b190",
        waveAqua2 = "#b48e70",

        springGreen = "#e8d0c0",
        boatYellow1 = "#7c5e40",
        boatYellow2 = "#8c6e50",
        carpYellow = "#9c7e60",

        sakuraPink = "#9b7e60",
        waveRed = "#8b5e40",
        peachRed = "#7b4e30",
        surimiOrange = "#9b6e50",
        katanaGray = "#886550",
      },
      overrides = {
        Visual = { bg = "#462e28" },
        Normal = { bg = "#14130e" },
        TelescopeNormal = { bg = "#10100c" },
        TelescopeBorder = { bg = "#10100c", fg = "#5b4e30" },
        TelescopePromptNormal = { bg = "#10100c" },
      }
    },
    custom = {
      accent = "#b46e30",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#ca8b50",
      cursor_line = "#ca8b50",
      line_number = "#5b4e30",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#dcb690",
    }
  },

  [ "coral (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#140a0c",
        sumiInk1 = "#180c10",
        sumiInk2 = "#1c0e14",
        sumiInk3 = "#201018",
        sumiInk4 = "#26141e",
        sumiInk5 = "#321a26",
        sumiInk6 = "#4e2a3c",

        waveBlue1 = "#4a1e30",
        waveBlue2 = "#5e2d40",

        winterGreen = "#361a26",
        winterYellow = "#3a1f2a",
        winterRed = "#2e1a1e",
        winterBlue = "#352528",
        autumnGreen = "#804a5a",
        autumnRed = "#703a4a",
        autumnYellow = "#905c6a",

        samuraiRed = "#a02936",
        roninYellow = "#b83446",
        waveAqua1 = "#ce5d66",
        dragonBlue = "#946566",

        oldWhite = "#e0a8b6",
        fujiWhite = "#edb8c6",
        fujiGray = "#7c4a56",

        oniViolet = "#9d5b66",
        oniViolet2 = "#b77b86",
        crystalBlue = "#bc7e96",
        springViolet1 = "#9c6a76",
        springViolet2 = "#bb7c86",
        springBlue = "#c47f96",
        lightBlue = "#e4a3b6",
        waveAqua2 = "#b87a86",

        springGreen = "#f0d8e0",
        boatYellow1 = "#804a56",
        boatYellow2 = "#905a66",
        carpYellow = "#a06a76",

        sakuraPink = "#9f6a76",
        waveRed = "#8f4a56",
        peachRed = "#7f3a46",
        surimiOrange = "#9f5a66",
        katanaGray = "#8c5166",
      },
      overrides = {
        Visual = { bg = "#4a1a26" },
        Normal = { bg = "#161111" },
        TelescopeNormal = { bg = "#120e0f" },
        TelescopeBorder = { bg = "#120e0f", fg = "#5f3a46" },
        TelescopePromptNormal = { bg = "#120e0f" },
      }
    },
    custom = {
      accent = "#b83446",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#ce5d66",
      cursor_line = "#ce5d66",
      line_number = "#5f3a46",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#e0a8b6",
    }
  },

  [ "papaya (orangy)" ] = {
    kanagawa = {
      palette = {
        sumiInk0 = "#140c0a",
        sumiInk1 = "#18100e",
        sumiInk2 = "#1c1412",
        sumiInk3 = "#201816",
        sumiInk4 = "#261e1c",
        sumiInk5 = "#322624",
        sumiInk6 = "#4e3e3a",

        waveBlue1 = "#4a3634",
        waveBlue2 = "#5e4644",

        winterGreen = "#362a26",
        winterYellow = "#3a2e2a",
        winterRed = "#2e221e",
        winterBlue = "#352a26",
        autumnGreen = "#80544c",
        autumnRed = "#70443c",
        autumnYellow = "#90645c",

        samuraiRed = "#a0301c",
        roninYellow = "#b8402c",
        waveAqua1 = "#ce654c",
        dragonBlue = "#946e5c",

        oldWhite = "#e0ac8c",
        fujiWhite = "#edbcac",
        fujiGray = "#7c583c",

        oniViolet = "#9d654c",
        oniViolet2 = "#b7856c",
        crystalBlue = "#bc887c",
        springViolet1 = "#9c745c",
        springViolet2 = "#bb866c",
        springBlue = "#c4897c",
        lightBlue = "#e4ad8c",
        waveAqua2 = "#b8846c",

        springGreen = "#f0e0c8",
        boatYellow1 = "#80543c",
        boatYellow2 = "#90644c",
        carpYellow = "#a0745c",

        sakuraPink = "#9f745c",
        waveRed = "#8f543c",
        peachRed = "#7f442c",
        surimiOrange = "#9f644c",
        katanaGray = "#8c5b4c",
      },
      overrides = {
        Visual = { bg = "#4a241c" },
        Normal = { bg = "#161210" },
        TelescopeNormal = { bg = "#12100d" },
        TelescopeBorder = { bg = "#12100d", fg = "#5f442c" },
        TelescopePromptNormal = { bg = "#12100d" },
      }
    },
    custom = {
      accent = "#b8402c",
      light_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.6 )
      end,
      light_accent2 = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      dark_accent = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.brightness( accent, 0.4 )
      end,
      light_blue = "#ce654c",
      cursor_line = "#ce654c",
      line_number = "#5f442c",
      notify_info_border = function( accent )
        local utils = require( "obszczymucha.utils" )
        return utils.saturate( accent, 0.9 )
      end,
      notify_info_body = "#e0ac8c",
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
