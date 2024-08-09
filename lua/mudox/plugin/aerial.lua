-- vim: fml& fdn& fdm=marker fmr=〈,〉

local i = require("mudox.ui.icon")

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

local on_attach = function(bufnr)
  local ncmd = K.ncmd

  ncmd("]i", "AerialNext", { buffer = bufnr })
  ncmd("[i", "AerialPrev", { buffer = bufnr })
end

local opts = {
  highlight_on_hover = true,

  min_width = 30,
  float = float,

  close_on_select = false,
  post_jump_cmd = "normal! zzzv",

  icons = i.kind,

  filter_kind = kinds,

  show_guides = true,

  on_attach = on_attach,
}

local keys = {
  -- outline side pane
  { "gO", "<Cmd>AerialToggle<Cr>", desc = "[Aerial] Toggle outline side pane" },
  -- { "<leader>aX", "<Cmd>AerialCloseAll<Cr>", desc = "[Aerial] Close all outline windows" },
}

-- stylua: ignore start
local cmd = {
  "Open", "OpenAll", "Close", "Toggle",
  "NavOpen", "NavClose", "NavToggle",
  "Info",
}
-- stylua: ignore end

cmd = vim.tbl_map(function(e)
  return "Aerial" .. e
end, cmd)

return {
  "stevearc/aerial.nvim",
  cmd = cmd,
  keys = keys,
  opts = opts,
}
