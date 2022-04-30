-- vim: fdm=marker fmr=〈,〉

-- Luarocks
pl = require("mudox.luarocks")

-- Mode
require("mudox.resolve_mode")

-- Common paths
stdpath = require("mudox.path")

-- Config
require(stdpath("settings"))
require(stdpath("auto_commands"))
require("mudox.plugin_manager")
require(stdpath("post"))

-- Mappings
vim.api.nvim_create_augroup("Mudox", { clear = true })
vim.api.nvim_create_autocmd("UIEnter", {
  group = "Mudox",
  callback = function()
    require(stdpath("mappings"))
  end,
})

-- Packer
vim.cmd(("source %s"):format(stdpath.packer_compiled))
