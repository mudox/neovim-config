-- vim: fdm=marker fmr=〈,〉

local dirman = {
  config = {
    workspaces = {
      home = "/Users/mudox/OneDrive/Neorg/home",
    },
    default_workspace = "home",
  },
}

local completion = {
  config = {
    engine = "nvim-cmp",
  },
}

local journal = {
  config = {
    workspace = "home",
    strategy = "flat",
  },
}

local toc = {
  config = {
    default_toc_mode = "split",
    toc_split_placement = "right",
  },
}

-- stylua: ignore start
local metagen = {
  config = {
    type = "empty",
    template = {
      { "title",       "" },
      { "description", "" },

      { "authors",     "mudox" },

      { "categories",  "" },
      { "tags",        "" },

      { "version",     function() return require("neorg.config").norg_version end },

      { "created",     function() return os.date("%Y-%m-%dT%H:%M") end },
      { "updated",     function() return os.date("%Y-%m-%dT%H:%M") end },
    },
  },
}
-- stylua: ignore end

local function s(name)
  return require("mudox.plugin.neorg." .. name)
end

-- stylua: ignore start
local opts = {
  load = {
    -- default modules
    ["core.defaults"]               = {},
    ["core.esupports.metagen"]      = metagen,
    ["core.keybinds"]               = s"keybinds",

    -- non-default modules
    ["core.completion"]             = completion,
    ["core.concealer"]              = s"concealer",
    ["core.dirman"]                 = dirman,
    ["core.journal"]                = journal,
    ["core.qol.toc"]                = toc,

    -- external modules
    ["core.integrations.telescope"] = {},
  },
}
-- stylua: ignore end

local keys = {
  { "<Space>e", "<Cmd>Neorg workspace home<Cr>", desc = "Open Neorg Home Workspace" },
  { "<leader>tef", "<Cmd>Telescope neorg find_norg_files<Cr>", desc = "Neorg Notes" },
  { "<leader>tel", "<Cmd>Telescope neorg find_linkable<Cr>", desc = "Neorg Notes" },
}

local function init()
  vim.cmd([[cabbrev N Neorg]])
end

return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  ft = "norg",
  cmd = { "N", "Neorg" },
  keys = keys,
  init = init,
  opts = opts,
  dependencies = {
    "plenary.nvim",
    "nvim-neorg/neorg-telescope",
  },
  cond = false,
}
