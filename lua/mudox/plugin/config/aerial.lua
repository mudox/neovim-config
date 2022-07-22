-- vim: fdm=marker fmr=〈,〉

local i = require("mudox.ui").icons

local float = {
  border = "none",
  max_height = { 20, 0.6 },
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

  -- "Variable",
  -- "Constant",
}

local on_attach = function(bufnr)
  local ncmd = require("mudox.keymap").ncmd

  ncmd("J", "AerialNext", { buffer = bufnr })
  ncmd("K", "AerialPrev", { buffer = bufnr })
end

require("aerial").setup {
  highlight_on_hover = true,

  min_width = 30,
  float = float,

  close_on_select = true,
  post_jump_cmd = "normal! zzzv",

  icons = i.lsp.kind,

  filter_kind = kinds,

  show_guides = true,

  on_attach = on_attach,
}
