local function opts()
  local g = require("glance")
  local a = g.actions

  return {
    border = {
      enable = true,
      top_char = " ",
      bottom_char = " ",
    },
    preview_win_opts = {
      cursorline = false,
      number = false,
      wrap = false,

      statuscolumn = "",
      foldcolumn = "0",
      signcolumn = "no",

      winhl = "Folded:GlancePreviewNormal",
    },
    mappings = {
      list = {
        ["J"] = a.next_location,
        ["K"] = a.previous_location,

        ["<C-v>"] = a.jump_vsplit,
        ["<C-s>"] = a.jump_split,
        ["<C-t>"] = a.jump_tab,
      },
      preview = {
        ["J"] = a.next_location,
        ["K"] = a.previous_location,
      },
    },
    folds = {
      fold_closed = I.chevron.right,
      fold_open = I.chevron.down,
      folded = true, -- Automatically fold list on startup
    },
  }
end

return {
  "dnlhc/glance.nvim",
  event = "LspAttach",
  opts = opts,
}
