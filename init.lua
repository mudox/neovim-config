-- vim: fdm=marker fmr=〈,〉

-- penlight
pl = require("pl.import_into")()

-- mode
require("resolve_mode")

-- common paths
stdpath = require("path")

-- config
require(stdpath("settings"))
require(stdpath("mappings"))
require("pluginmanager").load(stdpath("plugins"))
require(stdpath("post"))

-- packer_compiled
vim.cmd(("source %s"):format(stdpath.packer_compiled))
