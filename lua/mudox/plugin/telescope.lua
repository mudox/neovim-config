local function open(name, opts)
  opts = vim.deepcopy(opts)
  return function()
    local defaults = { cwd = require("mudox.lib.path").get_root() }
    opts = vim.tbl_deep_extend("force", defaults, opts or {})
    if name == "files" then
      local in_git_repo = vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true"
      if in_git_repo then
        opts.show_untracked = true
        name = "git_files"
      else
        name = "find_files"
      end
    end
    require("telescope.builtin")[name](opts)
  end
end

local function cmd(subcmd)
  return "<Cmd>Telescope " .. subcmd .. "<Cr>"
end

local function files()
  local defaults = { cwd = require("mudox.lib.path").get_root() }
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  local in_git_repo = vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true"
  if in_git_repo then
    opts.show_untracked = true
    name = "git_files"
  else
    name = "find_files"
  end

  require("telescope.builtin")[name](opts)
end

local function builtins()
  local opts = {
    include_extensions = true,
    preview = { hide_on_startup = true },
  }
  require("telescope.builtin").builtin(opts)
end

local function document_symbos()
  return open("lsp_document_symbols", {
    symbols = {
      "Class",
      "Function",
      "Method",
      "Constructor",
      "Interface",
      "Module",
      "Struct",
      "Trait",
      "Field",
      "Property",
    },
  })
end

local function workspace_symbols()
  return open("lsp_workspace_symbols", {
    symbols = {
      "Class",
      "Function",
      "Method",
      "Constructor",
      "Interface",
      "Module",
      "Struct",
      "Trait",
      "Field",
      "Property",
    },
  })
end

local keys = {
  { ":", builtins, desc = "All Telescope Pickers" },
  { "<Space>", cmd("resume"), desc = "Resume" },

  -- lsp
  { "?", cmd("diagnostics bufnr=0"), desc = "Document Diagnostics" },
  { "!", cmd("diagnostics"), desc = "Workspace Diagnostics" },
  { ".", cmd("lsp_code_actions"), desc = "Code Actions" },

  -- vim
  { "h", cmd("help_tags"), desc = "Vim Help" },
  { "o", cmd("vim_options"), desc = "Vim Options" },
  { "H", cmd("highlights"), desc = "Highlight Groups" },
  { "/", cmd("current_buffer_fuzzy_find"), desc = "Search in Buffer" },
  { "k", cmd("keymaps"), desc = "Key Maps" },
  { "c", cmd("command_history"), desc = "Command History" },
  { "C", cmd("commands"), desc = "Commands" },

  -- symbols
  {"<M-8>", document_symbos, desc = "Document Symbols"},
  {"<M-9>", workspace_symbols, desc = "Workspace Symbols"},
  {"<M-i>", cmd("treesitter"), desc = "TreeSitter Symbols"},

  -- grep
  { "w", open("grep_string"), desc = "Grep <Word> Under Cursor" },
  { "W", open("grep_string", { cwd = false }), desc = "Grep <Word> Under Cursor (from file dir)" },
  { "g", open("live_grep"), desc = "Live Grep" },
  { "G", open("live_grep", { cwd = false }), desc = "Live Grep (from file dir)" },

  -- files
  { "f", open("files"), desc = "Find Files (root dir, find_files)" },
  { "F", open("files", { cwd = false }), desc = "Find Files (from file dir, find_files)" },

  -- plugins
  { "p", cmd("lazy"), desc = "Lazy" },

  -- git
  { "gc", cmd("git_commits"), desc = "commits" },
  { "gs", cmd("git_status"), desc = "status" },

  -- search

  { "sM", cmd("man_pages"), desc = "Man Pages" },
  { "sm", cmd("marks"), desc = "Jump to Mark" },
  { "ss", document_symbos(), desc = "Document Symbols" },
  { "sS", workspace_symbols(), desc = "Workspace Symbols" },
}

for _, key in pairs(keys) do
  key[1] = "<leader>t" .. key[1]
end

local shortcuts = {
  { "<C-p>", files, desc = "Smart Find Files (root dir, git_files or find_files)" },
  { "", open("live_grep"), desc = "Find in Files (Grep)" }, -- <C-/>
  { "<C-b>", cmd("buffers show_all_buffers=true"), desc = "Switch Buffer" },
  { "<Space>r", cmd("oldfiles"), desc = "Recent" },
}

vim.list_extend(keys, shortcuts)

local mappings = {
  i = {
    -- no normal mode
    ["<Esc>"] = function(...)
      return require("telescope.actions").close(...)
    end,

    -- clear prompt input
    ["<C-u>"] = false,

    -- preview
    ["?"] = function(...)
      require("telescope.actions.layout").toggle_preview(...)
    end,
    ["<C-f>"] = function(...)
      return require("telescope.actions").preview_scrolling_down(...)
    end,
    ["<C-b>"] = function(...)
      return require("telescope.actions").preview_scrolling_up(...)
    end,

    -- <C-s> for horizontal split open
    -- <C-v> for vertical split open
    -- <C-t> for tabpage open
    ["<C-s>"] = function(...)
      require("telescope.action").select_horizontal(...)
    end,

    ["<C-x>"] = function(...)
      return require("trouble.providers.telescope").open_with_trouble(...)
    end,

    ["<A-i>"] = function()
      open("find_files", { no_ignore = true })()
    end,
    ["<a-h>"] = function()
      open("find_files", { hidden = true })()
    end,

    -- history
    ["<C-j>"] = function(...)
      return require("telescope.actions").cycle_history_next(...)
    end,
    ["<C-k>"] = function(...)
      return require("telescope.actions").cycle_history_prev(...)
    end,
  },
  n = {
    ["q"] = function(...)
      return require("telescope.actions").close(...)
    end,
  },
}

local opts = {
  defaults = {
    -- icons
    selection_caret = " ",
    prompt_prefix = " ",
    multi_icon = "│",

    -- layout
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      prompt_position = "top",
    },

    -- files finder
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim", -- trim indentations
    },

    mappings = mappings,
  },
}

local dependencies = {
  "tsakirist/telescope-lazy.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "nvim-telescope/telescope-live-grep-args.nvim",
}

local function config(_, options)
  local telescope = require("telescope")

  telescope.setup(options)

  local extensions = {
    "lazy",
    "fzf",
    "live_grep_args",
    "notify",
  }
  for _, name in ipairs(extensions) do
    require("telescope").load_extension(name)
  end
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = dependencies,
  keys = keys,
  opts = opts,
  config = config,
}
