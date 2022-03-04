-- vim: fdm=marker fmr=〈,〉

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

require(stdpath("settings"))
require(stdpath("mappings"))
require("pluginmanager").load(stdpath("plugins"))
require(stdpath("post"))

-- packer_compiled
vim.cmd(("source %s"):format(stdpath.packer_compiled))
