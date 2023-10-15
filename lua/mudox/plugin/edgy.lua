-- stylua: ignore
local keys = {
  { "<leader>we",       function() require("edgy").select() end,    desc = "[Edgy] Goto Edgy window" },
  { "<leader>wm",       function() require("edgy").goto_main() end, desc = "[Edgy] Goto main area" },
  { "<leader>wx",       function() require("edgy").close() end,     desc = "[Edgy] Close all edgy windows" },
}

local function is_not_floating(_, win)
  return vim.api.nvim_win_get_config(win).relative == ""
end

local function init()
  -- views can only be fully collapsed with the global statusline
  vim.opt.laststatus = 3
  -- Default splitting will cause your main splits to jump when opening an edgebar.
  -- To prevent this, set `splitkeep` to either `screen` or `topline`.
  vim.opt.splitkeep = "screen"
end

local left = {
  -- NvimTree filesystem always takes half the screen height
  {
    title = "Files",
    ft = "NvimTree",
  },
  {
    title = "Outline",
    ft = "aerial",
  },

  -- DAP
  {
    title = "Breakpoints",
    ft = "dapui_breakpoints",
    filter = is_not_floating,
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
    title = "Git (Fugitive)",
    ft = "fugitive",
  },
  "Trouble",
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
}

local right = {
  {
    title = "Tests",
    ft = "neotest-summary",
  },
  {
    title = "Search & Replace",
    ft = "spectre_panel",
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
}

-- stylua: ignore start
local function opts()
  local i = require("mudox.ui.icons")

  return {
    left      = left,
    right     = right,
    bottom    = bottom,

    options   = {
      left    = { size = 30 },
      bottom  = { size = 0.3 },
      right   = { size = 83 },
      top     = { size = 0.3 },
    },
    icons     = {
      closed  = i.collapsed,
      open    = i.expanded,
    },
    animate   = {
      enabled = false,
    },
    wo = {
      winhighlight = "", -- disable for clear window separator line
    }
  }
end
-- stylua: ignore end

return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  keys = keys,
  cond = function()
    return md ~= "man"
  end,
  init = init,
  opts = opts,
}
