local keys = {
  { "<C-Space>", desc = "Begin / expand selection", mode = { "n", "x" } },
  { "<Bs>", desc = "Shrink selection", mode = "x" },
}

local opts = {}

opts.ensure_installed = {
  "c",
  "lua",
  "query",
  "vim",
  "vimdoc",
}

opts.auto_install = true

opts.highlight = {
  enable = true,

  ---@diagnostic disable-next-line: unused-local
  disable = function(lang, buf)
    local max_filesize = 50 * 1024 -- 50 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,
}

opts.indent = {
  enable = true,
}

opts.incremental_selection = {
  enable = false, -- use flash.nvim instead
  keymaps = {
    init_selection = "<C-Space>",
    node_incremental = "<C-Space>",
    scope_incremental = "<Nop>",
    node_decremental = "<Bs>",
  },
}

opts.query_linter = {
  enable = true,
  use_virtual_text = true,
  lint_events = { "BufWrite", "CursorHold" },
}

local function config()
  require("nvim-treesitter.configs").setup(opts)

  -- disable injection queries for better performance
  -- vim.treesitter.query.set("lua", "injections", "")
end

local function init()
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.o.foldtext = "v:lua.require('mudox.ui.fold').foldtext()"
  -- vim.o.foldminlines = 6
  vim.o.foldnestmax = 3
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstallInfo" },
    keys = keys,
    init = init,
    config = config,
  },
}
