-- if mode is not `default`, then try require `name` from 'mode.<mode_name>'
-- otherwise require `name`

local function resolve_mode()
  local mode
  if vim.fn.exists("g:vscode") == 1 then
    return "vscode"
  end

  mode = vim.trim(os.getenv("MDX_NVIM_MODE") or "")
  if #mode > 0 then
    return mode
  end

  mode = vim.trim(os.getenv("DEFAULT_NVIM_MODE") or "")
  if #mode > 0 then
    return mode
  end

  return "lsp"
end

vim.g.mdx_nvim_mode = resolve_mode()
vim.cmd([[ lockvar g:mdx_nvim_mode ]])
