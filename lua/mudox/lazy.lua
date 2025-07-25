local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local output = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
  if vim.api.nvim_get_vvar("shell_error") ~= 0 then
    vim.api.nvim_echo({ "Error cloning lazy.nvim repository...\n\n" .. output }, true, { err = true })
  end
  local oldcmdheight = vim.o.cmdheight
  vim.opt.cmdheight = 2
  vim.notify("Please wait while plugins are installed...")
  On("User", {
    desc = "Load Mason and Treesitter after Lazy installs plugins",
    once = true,
    pattern = "LazyInstall",
    callback = function()
      vim.cmd.bw()
      vim.opt.cmdheight = oldcmdheight
      vim.tbl_map(function(module)
        pcall(require, module)
      end, { "nvim-treesitter", "mason" })
    end,
  })
end
vim.opt.rtp:prepend(lazypath)

-- stylua: ignore
local icons = {
  cmd        = "",
  config     = "",
  event      = "",
  ft         = "",
  init       = "",
  source     = "",
  keys       = "",
  plugin     = "",
  import     = "",

  lazy       = "",

  loaded     = "✓",
  not_loaded = "-",

  runtime    = "",
  start      = "",

  task       = "✔ ",

  list       = { "", "  ", "  ", "  " },
}

local ui = {
  backdrop = 100, -- remove backdrop
  -- a number <1 is a percentage., >1 is a fixed size
  size = { width = 0.6, height = 0.8 },
  wrap = true, -- wrap the lines in the ui
  -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
  border = "none",
  icons = icons,
  -- leave nil, to automatically select a browser depending on your OS.
  -- If you want to use a specific browser, you can define it here
  browser = nil, ---@type string?
  throttle = 20, -- how frequently should the ui process render events
  custom_keys = {
    -- you can define custom key maps here.
    -- To disable one of the defaults, set it to false

    -- open lazygit log
    ["<localleader>l"] = function(plugin)
      require("lazy.util").float_term({ "lazygit", "log" }, {
        cwd = plugin.dir,
      })
    end,

    -- open a terminal for the plugin dir
    ["<localleader>t"] = function(plugin)
      require("lazy.util").float_term(nil, {
        cwd = plugin.dir,
      })
    end,
  },
}

local performance = {
  rtp = {
    disabled_plugins = {
      "gzip",
      "matchit",
      "matchparen",
      "netrwPlugin",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    },
  },
}

vim.g.mapleader = K.leader
require("lazy").setup {
  spec = "mudox.plugin",
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = performance,
  change_detection = {
    enabled = false,
    notify = false,
  },
  ui = ui,
}
