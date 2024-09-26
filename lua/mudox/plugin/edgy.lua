-- stylua: ignore
local keys = {
  { "<leader>wh",    function() require("edgy").toggle("left") end,   desc = "[Edgy] Toggle left"    },
  { "<leader>wl",    function() require("edgy").toggle("right") end,  desc = "[Edgy] Toggle right"   },
  { "<leader>wj",    function() require("edgy").toggle("bottom") end, desc = "[Edgy] Toggle bottom"  },

  { "<leader>w/",    function() require("edgy").select() end,         desc = "[Edgy] Goto ..."       },
  { "<leader>w<Cr>", function() require("edgy").goto_main() end,      desc = "[Edgy] Goto main area" },

  { "<leader>w-",    function() require("edgy").close() end,          desc = "[Edgy] Close all"      },
  { "<Bs>e",         function() require("edgy").close() end,          desc = "[Edgy] Close all"      },
  { "<Bs>h",         function() require("edgy").close("left") end,    desc = "[Edgy] Close left"     },
  { "<Bs>l",         function() require("edgy").close("right") end,   desc = "[Edgy] Close right"    },
  { "<Bs>j",         function() require("edgy").close("bottom") end,  desc = "[Edgy] Close bottom"   },
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

-- stylua: ignore
local trouble = {
  { title = "[Trouble] Symbols",     mode = "symbols",     pos = "left"   },
  { title = "[Trouble] Diagnostics", mode = "diagnostics", pos = "bottom" },
  { title = "[Trouble] Todo",        mode = "todo",        pos = "bottom" },
}

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
}

local s = 4
local ui_keys = {
  ["<C-Right>"] = function(win)
    win:resize("width", s)
  end,
  ["<C-Left>"] = function(win)
    win:resize("width", -s)
  end,
  ["<C-Up>"] = function(win)
    win:resize("height", s)
  end,
  ["<C-Down>"] = function(win)
    win:resize("height", -s)
  end,
}

local ui = require("mudox.ui")
-- stylua: ignore
local opts = {
  left      = left,
  right     = right,
  bottom    = bottom,

  keys      = ui_keys,

  options   = {
    left    = { size = ui.left_width },
    bottom  = { size = 0.3 },
    right   = { size = ui.right_width },
    top     = { size = 0.3 },
  },

  icons     = {
    -- use `title` to show distinct icon for each pane
    closed  = "󱂬 ",
    open    = "󱂬 ",
  },

  animate   = { enabled = false },

  wo = {
    winhighlight = "", -- remove winhl
  }
}

for _, v in ipairs(trouble) do
  opts[v.pos] = opts[v.pos] or {}
  table.insert(opts[v.pos], {
    title = v.title,
    ft = "trouble",
    filter = function(_, win)
      return vim.w[win].trouble
        and vim.w[win].trouble.mode == v.mode
        and vim.w[win].trouble.type == "split"
        and not vim.w[win].trouble_preview
    end,
  })
end

return {
  -- "folke/edgy.nvim",
  dir = "~/Git/neovim/edgy.nvim", -- HACK: fix `check_main`
  event = "VeryLazy",
  keys = keys,
  init = init,
  opts = opts,
  branch = "mudox", -- track: https://github.com/folke/edgy.nvim/issues/58
}
