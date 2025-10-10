local float = {
  border = "none",
  max_height = { 30, 0.6 },
}

local kinds = {
  "Module",

  "Interface",

  "Class",
  "Struct",
  "Enum",

  "Constructor",
  "Function",
  "Method",

  "Variable",
  "Constant",
}

local opts = {
  highlight_on_hover = true,

  min_width = require("mudox.ui").left_width,
  float = float,

  close_on_select = false,
  post_jump_cmd = "normal! zzzv",

  icons = I.kind,

  filter_kind = kinds,

  show_guides = true,
}

local keys = {
  { K.p"wa", "<Cmd>AerialToggle<Cr>", desc = "[Aerial] Toggle" },
}

-- stylua: ignore
local cmd = {
  "Open", "OpenAll", "Close", "Toggle",
  "NavOpen", "NavClose", "NavToggle",
  "Info",
}

cmd = vim.tbl_map(function(e)
  return "Aerial" .. e
end, cmd)

return {
  "stevearc/aerial.nvim",
  cmd = cmd,
  keys = keys,
  opts = opts,
}
