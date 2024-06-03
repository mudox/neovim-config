-- TODO: adapt to find all AP actions
---@diagnostic disable-next-line: unused-local, unused-function
local function local_shell_scripts()
  local files = require("overseer.files")

  return {
    generator = function(opts, cb)
      local scripts = vim.tbl_filter(function(filename)
        return filename:match("%.z?sh$")
      end, files.list_files(opts.dir))

      local templates = {}
      for _, filename in ipairs(scripts) do
        table.insert(templates, {
          name = "Run " .. filename,
          params = {
            args = { optional = true, type = "list", delimiter = " " },
          },
          builder = function(params)
            return {
              cmd = { files.join(opts.dir, filename) },
              args = params.args,
            }
          end,
        })
      end

      cb(templates)
    end,
  }
end

local templates = {
  "builtin",

  "mudox.quick_run",
  "mudox.run_neovim_lua_script",
}

local function opts()
  local border = require("mudox.ui.icon").border.corner

  local task_list = {
    direction = "right",
    separator = "",

    -- stylua: ignore
    bindings = {
      o            = false,
      ["]"]        = false,
      ["["]        = false,

      -- navigate
      ["{"]        = false,
      ["}"]        = false,
      ["<C-n>"]    = "NextTask",
      ["<C-p>"]    = "PrevTask",

      -- scroll
      ["<C-j>"]    = "ScrollOutputDown",
      ["<C-k>"]    = "ScrollOutputUp",

      -- detail
      ["<C-h>"]    = false,
      ["<C-l>"]    = false,
      m            = "IncreaseDetail",
      l            = "DecreaseDetail",
      M            = "IncreaseAllDetail",
      L            = "DecreaseAllDetail",
    },
  }

  return {
    templates = templates,

    task_list = task_list,
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
  keys = require("mudox.plugin.overseer.keymaps"),
  config = config,
}
