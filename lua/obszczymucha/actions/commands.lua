local color_utils = require( "obszczymucha.actions.utils.color" )

return {
  {
    name = "Toggle color highlighting",
    action = "CccHighlighterToggle",
  },
  {
    name = "Pick color",
    action = "CccPick",
    condition = color_utils.is_hex_color_at_cursor,
    score = 0
  },
  {
    name = "Start debugging",
    action = "DapNew",
    condition = function()
      return not require("dap").session()
    end
  },
  {
    name = "Stop debugging",
    action = "DapTerminate",
    condition = function()
      return require("dap").session()
    end
  }
}
