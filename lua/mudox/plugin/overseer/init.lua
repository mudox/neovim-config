-- stylua: ignore
local function r(name) return require("mudox.plugin.overseer." .. name) end

local templates = {
  "builtin",

  "mudox.quick_run",
  "mudox.run_by_neovim",
}

-- stylua: ignore
-- see
-- + overseer/task_list/keymaps.lua
-- + overseer/task_list/actions.lua
-- + https://github.com/stevearc/overseer.nvim/blob/master/doc/reference.md#setup-options
local task_list_keymaps = {
  -- navigate
  ["k"]    = "keymap.prev_task",
  ["j"]    = "keymap.next_task",

  -- scroll
  ["<C-j"] = false,
  ["<C-k"] = false,
  ["{"]    = "keymap.scroll_output_up",
  ["}"]    = "keymap.scroll_output_down",
}

local function opts()
  local border = I.border.corner

  return {
    -- strategy = { "jobstart", use_terminal = true },

    templates = templates,

    actions = r("actions"),

    task_list = {
      separator = "",
      keymaps = task_list_keymaps,
    },

    confirm = {
      border = border,
      win_opts = {
        winblend = 0,
      },
    },

    task_launcher = {
      border = border,
      win_opts = {
        winblend = 0,
      },
    },

    form = {
      border = border,
      win_opts = {
        winblend = 0,
      },
    },

    task_win = {
      padding = 8,
      border = border,
      win_opts = {
        winblend = 0,
      },
    },

    help_win = {
      border = border,
    },
  }
end

local function config()
  -- order matters
  require("dap")
  require("overseer").setup(opts())
  require("dap.ext.vscode").json_decode = require("overseer.json").decode
end

return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerInfo", "OverseerBuild" },
  keys = r("keymaps"),
  config = config,
}
