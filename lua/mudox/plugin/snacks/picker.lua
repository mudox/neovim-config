-- stylua: ignore
local function k(c) return K.p"s" .. c end

local function function_symbols()
  Snacks.picker.treesitter {
    filter = { default = { "Function", "Method" } },
    layout = {
      layout = {
        backdrop = false,
        row = 1,
        width = 0.33,
        min_width = 80,
        height = 0.8,
        border = "none",
        box = "vertical",
        { win = "preview", title = "{preview}", height = 0.4, border = "single" },
        { win = "input", height = 1, border = "single" },
        { win = "list", border = "single" },
        -- },
      },
    },
  }
end

local function smart()
  Snacks.picker.smart { multi = { "buffers", "files" } }
end

local function recent()
  Snacks.picker.recent { filter = { cwd = true } }
end

local layouts = {
  vertical = {
    layout = {
      backdrop = false,

      width = 0.5,
      min_width = 80,
      height = 0.8,
      min_height = 30,

      border = "rounded",
      title = "{title} {live} {flags}",
      title_pos = "center",

      box = "vertical",
      { win = "input", height = 1, border = "single" },
      { win = "list", border = "single" },
      { win = "preview", title = "{preview}", height = 0.4, border = "single" },
    },
  },
}

-- stylua: ignore
local keys = {
  { k":",             function() Snacks.picker.pickers() end,         desc = "Pickers"                 },
  { k".",             function() Snacks.picker.resume() end,          desc = "Resume"                  },

  { K.sc"f",          smart,                                          desc = "[Snacks] Files"          },
  { k"f",             smart,                                          desc = "Files"                   },
  { k"r",             recent,                                         desc = "Recent"                  },
  { k"F",             function() Snacks.picker.git_files() end,       desc = "Git files"               },

  { k"b",             function() Snacks.picker.buffers() end,         desc = "Buffers"                 },
  { "<C-S-o>",        function() Snacks.picker.buffers() end,         desc = "Buffers"                 },

  { K.sc"G",          function() Snacks.picker.grep() end,            desc = "[Snacks] Grep"           },
  { k"g",             function() Snacks.picker.grep() end,            desc = "Grep"                    },

  { "<C-S-/>",        function() Snacks.picker.help() end,            desc = "[Snacks] Help"           },
  { k"h",             function() Snacks.picker.help() end,            desc = "Help"                    },

  { k"C",             function() Snacks.picker.command_history() end, desc = "Command history"         },
  { k"n",             function() Snacks.picker.notifications() end,   desc = "Notification history"    },

  { k"p",             function() Snacks.picker.lazy() end,            desc = "Plugins"                 },

  { "<C-k>i",         function() Snacks.picker.icons() end,           desc = "[Snacks] Icons",         mode = 'i' },
  { "<C-k>y",         function() Snacks.picker.yanky() end,           desc = "[Snacks] Yanky",         mode = 'i' },

  -- symbols
  { K.sc'sf',         function_symbols,                               desc = "[Snacks] Goto functions" },
}

local opts = {
  ui_select = false,

  layout = {
    preset = function()
      return vim.o.columns >= 120 and "telescope" or "vertical"
    end,
    layouts = layouts,
  },

  sources = {
    files = {},
    explorer = {
      diagnostics = false,
      layout = {
        layout = {
          position = "right",
        },
      },
    },
    lines = {
      layout = {
        preset = function()
          return vim.o.columns >= 120 and "telescope" or "vertical"
        end,
      },
    },
  },
}

return {
  opts = opts,
  keys = keys,
}
