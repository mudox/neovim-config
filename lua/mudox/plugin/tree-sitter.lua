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
  "help",
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

local playground = {
  "nvim-treesitter/playground",
  cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor", "TSNodeUnderCursor" },
}

-- stylua: ignore start
playground.keys = {
  { "<leader>vc", "<Cmd>TSCaptureUnderCursor<Cr>", desc = "TreeSitter Capture" },
  { "<leader>vn", "<Cmd>TSNodeUnderCursor<Cr>", desc = "TreeSitter Node" },
}
-- stylua: ignore end

-- See: https://github.com/nvim-treesitter/playground#setup
opts.playground = {
  enable = true,
  disable = {},
  updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  persist_queries = false, -- Whether the query persists across vim sessions
  keybindings = {
    toggle_query_editor = "o",
    toggle_hl_groups = "i",
    toggle_injected_languages = "t",
    toggle_anonymous_nodes = "a",
    toggle_language_display = "I",
    focus_language = "f",
    unfocus_language = "F",
    update = "R",
    goto_node = "<cr>",
    show_help = "?",
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
    dependencies = { textobjects, playground },
    keys = keys,
    opts = opts,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
