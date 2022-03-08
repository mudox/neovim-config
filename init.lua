-- vim: fdm=marker fmr=〈,〉

-- luarocks
pl = require("mudox.luarocks")

-- mode
require("mudox.resolve_mode")

-- common paths
stdpath = require("mudox.path")

-- config
require(stdpath("settings"))
require(stdpath("mappings"))
require(stdpath("auto_commands"))
require("mudox.plugin_manager")
require(stdpath("post"))

-- packer_compiled
vim.cmd(("source %s"):format(stdpath.packer_compiled))
