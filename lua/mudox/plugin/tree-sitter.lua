local keys = {
  { "<c-space>", desc = "Increment selection" },
  { "<bs>", desc = "Decrement selection", mode = "x" },
}

local opts = {
  highlight = { enable = true },
  indent = { enable = true, disable = { "python" } },
  context_commentstring = { enable = true, enable_autocmd = false },
}

opts.ensure_installed = {
  "bash",
  "c",
  "html",
  "http",
  "javascript",
  "json",
  "lua",
  "luap",
  "markdown",
  "markdown_inline",
  "python",
  "query", -- TreeSitter query language
  "regex",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

opts.incremental_selection = {
  enable = true,
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

local textobjects = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  init = function()
    -- PERF: no need to load the plugin, if we only need its queries for mini.ai
    local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    local enabled = false
    if opts.textobjects then
      for _, mod in ipairs { "move", "select", "swap", "lsp_interop" } do
        if opts.textobjects[mod] and opts.textobjects[mod].enable then
          enabled = true
          break
        end
      end
    end
    if not enabled then
      require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
    end
  end,
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    dependencies = { textobjects, },
    keys = keys,
    opts = opts,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
