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
