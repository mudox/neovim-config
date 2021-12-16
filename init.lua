-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Penlight
pl = require("pl.import_into")()

-- Mode 〈
--
-- if mode is not `default`, then try require `name` from 'mode.<mode_name>'
-- otherwise require `name`
local mode
if vim.fn.exists("g:vscode") == 1 then
	mode = "vscode"
else
	mode = os.getenv("MDX_NVIM_MODE") or "default"
end

vim.g.mdx_nvim_mode = mode
vim.cmd([[ lockvar g:mdx_nvim_mode ]])
-- 〉

-- Common paths
stdpath = require("path")

-- JavaScript
vim.g.node_host_prog = "/opt/homebrew/bin/neovim-node-host"

-- Python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

-- Config
require(stdpath("settings"))
require(stdpath("mappings"))
require("pluginmanager").load(stdpath("plugins"))
require(stdpath("post"))

-- packer_compiled
vim.cmd(("source %s"):format(stdpath.packer_compiled))
