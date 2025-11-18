-- stylua: ignore
local keys = {
  { K.p"wh",    function() require("edgy").toggle("left") end,   desc = "[Edgy] Toggle left"    },
  { K.p"wl",    function() require("edgy").toggle("right") end,  desc = "[Edgy] Toggle right"   },
  { K.p"wj",    function() require("edgy").toggle("bottom") end, desc = "[Edgy] Toggle bottom"  },

  { K.p"w/",    function() require("edgy").select() end,         desc = "[Edgy] Goto ..."       },
  { K.p"w<Cr>", function() require("edgy").goto_main() end,      desc = "[Edgy] Goto main area" },

  { K.p"w-",    function() require("edgy").close() end,          desc = "[Edgy] Close all"      },
  { "<Bs>e",         function() require("edgy").close() end,          desc = "[Edgy] Close all"      },
  { "<Bs>h",         function() require("edgy").close("left") end,    desc = "[Edgy] Close left"     },
  { "<Bs>l",         function() require("edgy").close("right") end,   desc = "[Edgy] Close right"    },
  { "<Bs>j",         function() require("edgy").close("bottom") end,  desc = "[Edgy] Close bottom"   },
}

local function init()
  -- views can only be fully collapsed with the global statusline
  vim.opt.laststatus = 3
  -- Default splitting will cause your main splits to jump when opening an edgebar.
  -- To prevent this, set `splitkeep` to either `screen` or `topline`.
  vim.opt.splitkeep = "screen"
end

local function opts()
  local left = {
    {
      title = "Files",
      ft = "NvimTree",
    },
    "Outline",
    {
      title = "Aerial",
      ft = "aerial",
    },
    {
      title = "Trouble",
      ft = "trouble",
      filter = function(_, win)
        return vim.w[win].trouble
          and vim.w[win].trouble.type == "split"
          and vim.w[win].trouble.position == "left"
          and not vim.w[win].trouble_preview
      end,
    },

    -- DAP,
    {
      title = "Breakpoints",
      ft = "dapui_breakpoints",
      filter = function(_, win)
        return not U.window.is_floating(win)
      end,
    },
    {
      title = "Watches",
      ft = "dapui_watches",
      filter = is_not_floating,
    },
    {
      title = "Scopes",
      ft = "dapui_scopes",
      filter = is_not_floating,
    },

    {
      title = "Stacks",
      ft = "dapui_stacks",
      filter = is_not_floating,
    },
  }

  local bottom = {
    {
      title = "QuickFix / LocList",
      ft = "qf",
    },
    {
      title = "DAPUI Console",
      ft = "dapui_console",
    },
    {
      title = "DAP REPL",
      ft = "dap-repl",
    },
    {
      title = "Test output",
      ft = "neotest-output-panel",
    },
    {
      title = "Noice",
      ft = "noice",
      filter = function(_, win)
        return vim.api.nvim_win_get_config(win).relative == ""
      end,
    },
    {
      title = "Trouble",
      ft = "trouble",
      filter = function(_, win)
        return vim.w[win].trouble
          and vim.w[win].trouble.type == "split"
          and vim.w[win].trouble.position == "bottom"
          and not vim.w[win].trouble_preview
      end,
    },
  }

  local right = {
    {
      title = "Undo Tree",
      ft = "nvim-undotree",
    },
    {
      title = "Tests",
      ft = "neotest-summary",
    },
    {
      title = "Markdown Help",
      ft = "markdown",
      filter = function(buf)
        return vim.bo[buf].buftype == "help"
      end,
    },
    {
      title = "Neovim Help",
      ft = "help",
      filter = function(buf)
        return vim.bo[buf].buftype == "help"
      end,
    },
    {
      title = "Neovim Options",
      ft = "vim",
      filter = function()
        return vim.fn.bufname("%") == "option-window"
      end,
    },
    {
      title = "Man Page",
      ft = "man",
      filter = function(buf)
        return vim.bo[buf].buftype == "nofile"
      end,
    },
    {
      title = "Tasks",
      ft = "OverseerList",
    },
    {
      title = "Trouble",
      ft = "trouble",
      filter = function(_, win)
        return vim.w[win].trouble
          and vim.w[win].trouble.type == "split"
          and vim.w[win].trouble.position == "right"
          and not vim.w[win].trouble_preview
      end,
    },
  }

  local ui = require("mudox.ui")

  -- stylua: ignore
  return {
    left      = left,
    right     = right,
    bottom    = bottom,

    options   = {
      left    = { size = ui.left_width },
      bottom  = { size = 0.3 },
      right   = { size = ui.right_width },
      top     = { size = 0.3 },
    },

    icons     = {
      closed  = "󱂬 ",
      open    = "󱂬 ",
    },

    animate   = { enabled = false },

    wo = {
      winhighlight = "", -- remove winhl
    }
  }
end

return {
  "folke/edgy.nvim",
  dir = "~/Git/neovim-plugins/edgy.nvim", -- HACK: fix `check_main`
  branch = "mudox", -- track: https://github.com/folke/edgy.nvim/issues/58

  event = "VeryLazy",
  keys = keys,

  init = init,
  opts = opts,
}
