local M = {}

local function nop()
  print("This keymap is disabled for current buffer")
end

local function on_open()
  -- start insert mode
  vim.cmd("startinsert!")

  -- disable mappings to leave terminal mode
  local k = require("mudox.lib.keymap")
  local keys = { "<Esc>", "<C-\\><C-n>" }
  for _, key in ipairs(keys) do
    k.tmap(key, nop, { buffer = 0 })
  end
end

function M:init_gitui()
  local Term = require("toggleterm.terminal").Terminal
  self.gitui = Term:new {
    cmd = "gitui",
    dir = "git_dir",
    direction = "float",
    on_open = on_open,
  }
end

function M:init_lazygit()
  local Term = require("toggleterm.terminal").Terminal
  self.lazygit = Term:new {
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    on_open = on_open,
  }
end

function M:init()
  self:init_gitui()
  self:init_lazygit()
end

return M
