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
local gid = vim.api.nvim_create_augroup("MudoxKeymap", { clear = true })
vim.api.nvim_create_autocmd("UIEnter", {
  group = gid,
  callback = function()
    require(stdpath("mappings"))
  end,
})

-- Packer
vim.cmd(("source %s"):format(stdpath.packer_compiled))
