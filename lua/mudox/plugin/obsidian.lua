-- ref: https://github.com/obsidian-nvim/obsidian.nvim/wiki

---@diagnostic disable-next-line: unused-local
local enter_note = function(note)
  K.ndel("<Cr>", { buffer = true })
  -- K.ndel("]]", { buffer = true })
  -- K.ndel("[[", { buffer = true })

  -- stylua: ignore
  require("which-key").add {
    buffer = true,
    { "<C-Cr>", function() return require("obsidian.api").smart_action() end, expr = true, desc = "[obsidian] smart action", }
  }
end

local ui = {
  ignore_conceal_warn = true,

  external_link_icon = { char = "" },

  -- stylua: ignore
  checkboxes = {
    ["/"] = { char = "󰛂 ", hl_group = "in_progress" },

    ["!"] = { char = "󰩴 ", hl_group = "important"   },
    ["?"] = { char = " ", hl_group = "question"    },
    ["I"] = { char = "󰰅 ", hl_group = "idea"        },

    ["<"] = { char = "󰧙 ", hl_group = "rescheduled" },
    [">"] = { char = "󰧛 ", hl_group = "scheduled"   },

    ["x"] = { char = "󰅗 ", hl_group = "done"        },
    ["h"] = { char = "󰍷 ", hl_group = "on_hold"     },
    ["-"] = { char = "󰅚 ", hl_group = "cancelled"   },

    ["p"] = { char = "󰬬 ", hl_group = "pro"         },
    ["c"] = { char = "󰬧 ", hl_group = "con"         },

    ["i"] = { char = " ", hl_group = "info"        },
  },

  -- stylua: ignore
  hl_groups = {
    in_progress = { bold = true, fg = "#68c0e7" },

    important   = { bold = true, fg = "#f8dca8" },
    question    = { bold = true, fg = "#f9a980" },
    idea        = { bold = true, fg = "#f9dda9" },

    scheduled   = { bold = true, fg = "#68c0e7" },
    rescheduled = { bold = true, fg = "#9fde9b" },

    done        = { bold = true, fg = "#9fde9b" },
    on_hold     = { bold = true, fg = "#c29df2" },
    cancelled   = { bold = true, fg = "#f0809d" },

    pro         = { bold = true, fg = "#9fde9b" },
    con         = { bold = true, fg = "#f0809d" },

    info        = { bold = true, fg = "#79a8f4" },
  },
}

local opts = {
  legacy_commands = false,

  workspaces = {
    {
      name = "mudox",
      path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/mudox",
    },
  },

  frontmatter = {
    enabled = false,
  },

  templates = {
    folder = "/Templates",
  },

  note = {
    template = "Default.md",
  },

  daily_notes = {
    folder = "/Daily",
    date_format = "%Y/%Y-%m-%d",
    template = "Daily.md",
  },

  footer = {
    enabled = false,
  },

  attachments = {
    folder = "/Assets",
  },

  checkbox = {
    order = { " ", "/", "x" },
  },

  ui = ui,

  callbacks = {
    enter_note = enter_note,
  },
}

-- stylua: ignore start
local function k(key) return K.p("n") .. key end
local function c(cmd) return K.c("Obsidian " .. cmd) end
-- stylua: ignore end

local function keys()
  -- stylua: ignore
  return {
    { k"=", c"today",             desc = "today"             },
    { k"[", c"yesterday",         desc = "yesterday"         },
    { k"]", c"tomorrow",          desc = "tomorrow"          },
    { k"d", c"dailies",           desc = "dailies"           },

    { k"n", c"new",               desc = "new"               },
    { k"N", c"new_from_template", desc = "new from template" },
    { k"t", c"template",          desc = "template"          },

    { k"o", c"open",              desc = "open in obsidian"  },
  }
end

return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  cmd = "Obsidian",
  keys = keys,
  opts = opts,
}
