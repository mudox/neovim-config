local function open(builtin, opts)
  opts = vim.deepcopy(opts)
  return function()
    local defaults = { cwd = require("mudox.lib.path").get_root() }
    opts = vim.tbl_deep_extend("force", defaults, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat(opts.cwd .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

local keys = {
  { "<leader>,", "<Cmd>Telescope buffers show_all_buffers=true<Cr>", desc = "Switch Buffer" },
  { "", open("live_grep"), desc = "Find in Files (Grep)" }, -- <C-/>
  { "<leader>:", "<Cmd>Telescope command_history<Cr>", desc = "Command History" },
  { "<C-p>", open("files"), desc = "Find Files (root dir)" },
  -- find
  { "<leader>fb", "<Cmd>Telescope buffers<Cr>", desc = "Buffers" },
  { "<leader>ff", open("files"), desc = "Find Files (root dir)" },
  { "<leader>fF", open("files", { cwd = false }), desc = "Find Files (cwd)" },
  { "<leader>fr", "<Cmd>Telescope oldfiles<Cr>", desc = "Recent" },
  -- git
  { "<leader>gc", "<Cmd>Telescope git_commits<CR>", desc = "commits" },
  { "<leader>gs", "<Cmd>Telescope git_status<CR>", desc = "status" },
  -- search
  { "<leader>sa", "<Cmd>Telescope autocommands<Cr>", desc = "Auto Commands" },
  { "<leader>sb", "<Cmd>Telescope current_buffer_fuzzy_find<Cr>", desc = "Buffer" },
  { "<leader>sc", "<Cmd>Telescope command_history<Cr>", desc = "Command History" },
  { "<leader>sC", "<Cmd>Telescope commands<Cr>", desc = "Commands" },
  { "<leader>sd", "<Cmd>Telescope diagnostics<Cr>", desc = "Diagnostics" },
  { "<leader>sg", open("live_grep"), desc = "Grep (root dir)" },
  { "<leader>sG", open("live_grep", { cwd = false }), desc = "Grep (cwd)" },
  { "<leader>sh", "<Cmd>Telescope help_tags<Cr>", desc = "Help Pages" },
  { "<leader>sH", "<Cmd>Telescope highlights<Cr>", desc = "Search Highlight Groups" },
  { "<leader>sk", "<Cmd>Telescope keymaps<Cr>", desc = "Key Maps" },
  { "<leader>sM", "<Cmd>Telescope man_pages<Cr>", desc = "Man Pages" },
  { "<leader>sm", "<Cmd>Telescope marks<Cr>", desc = "Jump to Mark" },
  { "<leader>so", "<Cmd>Telescope vim_options<Cr>", desc = "Options" },
  { "<leader>sR", "<Cmd>Telescope resume<Cr>", desc = "Resume" },
  { "<leader>sw", open("grep_string"), desc = "Word (root dir)" },
  { "<leader>sW", open("grep_string", { cwd = false }), desc = "Word (cwd)" },
  { "<leader>uC", open("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  {
    "<leader>ss",
    open("lsp_document_symbols", {
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
    }),
    desc = "Goto Symbol",
  },
  {
    "<leader>sS",
    open("lsp_workspace_symbols", {
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
    }),
    desc = "Goto Symbol (Workspace)",
  },
}

local opts = {
  defaults = {
    -- prompt_prefix = " ",
    -- selection_caret = " ",
    selection_caret = " ",
    prompt_prefix = " ",
    multi_icon = "│",

    -- Layout
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      prompt_position = "top",
    },

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

    mappings = {
      i = {
        ["<c-t>"] = function(...)
          return require("trouble.providers.telescope").open_with_trouble(...)
        end,
        ["<a-i>"] = function()
          open("find_files", { no_ignore = true })()
        end,
        ["<a-h>"] = function()
          open("find_files", { hidden = true })()
        end,
        ["<C-Down>"] = function(...)
          return require("telescope.actions").cycle_history_next(...)
        end,
        ["<C-Up>"] = function(...)
          return require("telescope.actions").cycle_history_prev(...)
        end,
        ["<C-f>"] = function(...)
          return require("telescope.actions").preview_scrolling_down(...)
        end,
        ["<C-b>"] = function(...)
          return require("telescope.actions").preview_scrolling_up(...)
        end,
      },
      n = {
        ["q"] = function(...)
          return require("telescope.actions").close(...)
        end,
      },
    },
  },
}

local dependencies = {
  "tsakirist/telescope-lazy.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "nvim-telescope/telescope-live-grep-args.nvim",
}

local function config(_, opts)
  local telescope = require("telescope")

  telescope.setup(opts)

  local extensions = {
    "lazy",
    "fzf",
    "live_grep_args",
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
