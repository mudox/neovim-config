-- vim: fdm=marker fmr=〈,〉

-- stylua: ignore start
local opts = {
  signs = {
    error       = " ",
    warning     = " ",
    hint        = "➠ ",
    information = " ",
    other       = "﫠",
  },
}
-- stylua: ignore end

require("trouble").setup(opts)
