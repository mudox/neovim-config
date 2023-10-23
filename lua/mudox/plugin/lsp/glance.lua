local function opts()
  local i = require("mudox.ui.icon")
  local g = require("glance")
  local a = g.actions

  return {
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
      fold_closed = i.collapsed,
      fold_open = i.expanded,
      folded = true, -- Automatically fold list on startup
    },
  }
end

return {
  "dnlhc/glance.nvim",
  event = "LspAttach",
  opts = opts,
}
