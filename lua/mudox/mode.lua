local function resolve_mode()
  local mode

  -- for neovim extension inside vscode
  if vim.fn.exists("g:vscode") == 1 then
    return "vscode"
  end

  -- usage: `MDX_NVIM_MODE=python nvim`
  mode = vim.trim(os.getenv("MDX_NVIM_MODE") or "")
  if #mode > 0 then
    return mode
  end

  -- default mode - 'main'
  return "main"
end

local mode = resolve_mode()
vim.g.mdx_nvim_mode = mode
vim.cmd([[ lockvar g:mdx_nvim_mode ]])

return mode
