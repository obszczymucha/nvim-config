local saga = require( "lspsaga" )

saga.setup( {
  border_style = "single",
  saga_winblend = 0,
  symbol_in_winbar = {
    enable = true
  },
  rename = {
    quit = '<A-q>',
    in_select = true
  },
  code_action = {
    keys = {
      quit = { "q", "<Esc>" },
      exec = "<CR>"
    }
  },
  ui = {
    -- currently only round theme
    theme = 'round',
    -- border type can be single,double,rounded,solid,shadow.
    border = 'rounded',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = ' ',
    code_action = '💡',
    diagnostic = '🐞',
    incoming = ' ',
    outgoing = ' ',
    colors = {
      --float window normal bakcground color
      normal_bg = '#1d1536',
      --title background color
      title_bg = '#afd700',
      red = '#e95678',
      magenta = '#b33076',
      orange = '#FF8700',
      yellow = '#f7bb3b',
      green = '#afd700',
      cyan = '#36d0e0',
      blue = '#61afef',
      purple = '#CBA6F7',
      white = '#d1d4cf',
      black = '#1c1c19',
    },
    kind = {},
  },
} )
