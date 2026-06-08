return {
  setup = function()
    require("mini.icons").setup {
      file = {
        ["README.md"] = { glyph = "" },
      },
      extension = {
        md = { glyph = "" },
      },
    }
    _G.MiniIcons.mock_nvim_web_devicons()
  end,
}
