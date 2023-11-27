local function get()
  local mode

  -- for neovide gui app
  if vim.g.neovide then
    return "neovide"
  end

  -- for neovim extension inside vscode
  if vim.g.vscode then
    return "vscode"
  end

  -- usage: `MDX_NVIM_MODE=python nvim`
  mode = vim.trim(vim.env.MDX_NVIM_MODE or "")
  if #mode > 0 then
    return mode
  end

  -- default mode - 'main'
  return "main"
end

local mode = get()
vim.g.mdx_nvim_mode = mode
vim.cmd([[ lockvar g:mdx_nvim_mode ]])
