-- vim: fdm=marker fmr=〈,〉

-- Options 〈
local opts = {
  signs = {
    -- stylua: ignore start
    error = " ",
    warning = " ",
    hint = "➠ ",
    information = " ",
    other = "﫠",
    -- stylua: ignore end
  },
}
-- 〉

require("trouble").setup(opts)

-- Mappings 〈
local ncmd = require("mudox.keymap").ncmd
ncmd(",x<Space>", "TroubleToggle")

ncmd(",xw", "TroubleToggle workspace_diagnostics")
ncmd(",xd", "TroubleToggle document_diagnostics")

ncmd(",xq", "TroubleToggle quickfix")
ncmd(",xl", "TroubleToggle loclist")

ncmd(",xr", "TroubleToggle lsp_references")
-- 〉
