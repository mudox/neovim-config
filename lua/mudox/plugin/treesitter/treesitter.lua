-- local keys = {
--   { "<C-Space>", desc = "Begin / expand selection", mode = { "n", "x" } },
--   { "<Bs>", desc = "Shrink selection", mode = "x" },
-- }

local opts = {}

opts.ensure_installed = {
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
}

-- tree-sitter-cli is installed by mason
opts.auto_install = true

opts.highlight = {
  enable = true,

  ---@diagnostic disable-next-line: unused-local
  disable = function(lang, buf)
    --- disable for big buffer
    local max_filesize = 50 * 1024 -- 50 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
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
  -- treesitter folding
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.o.foldtext = "" -- use default transparent foldtext
  -- vim.o.foldtext = "v:lua.require('mudox.ui.fold').foldtext()"
  -- vim.o.foldminlines = 6
  vim.o.foldnestmax = 3
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nushell/tree-sitter-nu", ft = "nu" },
    },
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstallInfo" },
    -- keys = keys,
    init = init,
    config = config,
  },
}
