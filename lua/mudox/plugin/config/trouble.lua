-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Settings 〈

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

-- 〉

-- Key mappings 〈

local nmap = require("mudox.keymap").nmap
nmap("<M-]>", function()
  require("trouble").next { skip_groups = true, jump = true }
end)
nmap("<M-[>", function()
  require("trouble").previous { skip_groups = true, jump = true }
end)

-- 〉
