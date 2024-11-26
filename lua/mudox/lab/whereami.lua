local f = vim.fs

local M = {}

local home_dir = f.normalize("~")
local git_dir = f.normalize("~/Git")
local dev_dir = f.normalize("~/Develop")

-- stylua: ignore
local named_dirs = {
  DOTFILES      = f.join(git_dir, "dotfiles"),
  NEOVIM_CONFIG = f.join(git_dir, "neovim-config"),
  TMUX_CONFIG   = f.join(git_dir, "tmux-config"),
  HS_CONFIG     = f.join(git_dir, "hs-config"),
}

local i = 1
local named_dirs_lookup = {}
M.Kind = {}
for name, path in ipairs(named_dirs) do
  named_dirs_lookup[path] = i
  M.kind[i] = name
  i = i + 1
end

-- stylua: ignore
M.Project = {
  RUST   = "Cargo.toml",
  PYTHON = "pyproject.toml",
}

function M.resolve(path)
  path = f.normalize(path)
  path = vim.uv.fs_realpath(path)

  local kind = M.Kind[named_dirs_lookup[path]]
  if kind then
    return "kind", kind
  end
end

return M
