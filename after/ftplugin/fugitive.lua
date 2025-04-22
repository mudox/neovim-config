-- stylua: ignore
local keys = {
  { "<Space>P", K.c"G push",   desc = "[Fugitive] push" },
  { "<Space>B", K.c"G browse", desc = "[Fugitive] browse" },
}

require("which-key").add(keys)
