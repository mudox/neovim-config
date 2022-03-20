local i = require("mudox.ui").icons

-- stylua: ignore start
local opts = {
  signs = {
    error       = i.error,
    warning     = i.warn,
    information = i.info,
    hint        = i.hint,
    other       = "﫠",
  },
}
-- stylua: ignore end

require("trouble").setup(opts)
