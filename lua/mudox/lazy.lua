-- Bootstrap lazy.nvim
local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(install_path) then
  -- stylua: ignore
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    install_path
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or install_path)

-- Load lazy.nvim
-- stylua: ignore start
icons = {
  cmd        = "🄲 ",
  config     = " ",
  event      = "🄴 ",
  ft         = "🄵 ",
  init       = "🄸 ",
  source     = "🅂 ",
  keys       = "🄺 ",
  plugin     = "🄿 ",
  import     = "🅁 ",

  -- cmd = " ",
  -- config = " ",
  -- event = " ",
  -- ft = " ",
  -- init = " ",
  -- source = " ",
  -- keys = " ",
  -- plugin = " ",
  -- import = " ",

  lazy       = " ",
  loaded     = "●",
  not_loaded = "○",
  runtime    = " ",
  start      = " ",
  task       = "✔ ",
  list       = {
    "●",
    "➜",
    "★",
    "‒",
  },
}
-- stylua: ignore end

local ui = {
  -- a number <1 is a percentage., >1 is a fixed size
  size = { width = 0.8, height = 0.8 },
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
    -- disable some rtp plugins
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

vim.g.mapleader = "," -- surpress `lazy.nvim` warning message at startup
require("lazy").setup {
  spec = "mudox.plugin",
  defaults = {
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = performance,
  ui = ui,
}
