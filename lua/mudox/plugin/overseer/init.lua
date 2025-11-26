local function r(name)
  return require("mudox.plugin.overseer." .. name)
end

local templates = {
  "builtin",

  "mudox.quick_run",
  "mudox.run_neovim_lua_script",
}

-- stylua: ignore
local task_list_keymaps = {
  o          = false,
  ["]"]      = false,
  ["["]      = false,

  -- navigate
  ["{"]      = false,
  ["}"]      = false,
  ["<C-n>"]  = "NextTask",
  ["<C-p>"]  = "PrevTask",

  -- scroll
  ["<C-j>"]  = "ScrollOutputDown",
  ["<C-k>"]  = "ScrollOutputUp",

  -- detail
  ["<C-h>"]  = false,
  ["<C-l>"]  = false,
  m          = "IncreaseDetail",
  l          = "DecreaseDetail",
  M          = "IncreaseAllDetail",
  L          = "DecreaseAllDetail",

  -- custom
  ["<C-x>"]  = "<CMD>OverseerQuickAction duplicate<CR>",
  ["<C-Cr>"] = "<CMD>OverseerQuickAction run<CR>",
}

local function opts()
  local border = I.border.corner

  return {
    -- strategy = { "jobstart", use_terminal = true },

    templates = templates,
    actions = r("actions"),

    task_list = {
      direction = "right",
      separator = "",
      bindings = task_list_keymaps,
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
