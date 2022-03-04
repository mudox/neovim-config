-- vim: fdm=marker fmr=〈,〉

-- luarocks
require('mudox.luarocks')

-- penlight
pl = require("pl.import_into")()

-- mode
require("mudox.resolve_mode")

-- common paths
stdpath = require("mudox.path")

-- config
require(stdpath("settings"))
require(stdpath("mappings"))
require("mudox.pluginmanager").load(stdpath("plugins"))
require(stdpath("post"))

-- packer_compiled
vim.cmd(("source %s"):format(stdpath.packer_compiled))
