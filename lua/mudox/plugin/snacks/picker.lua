-- stylua: ignore
local function p(c) return K.p"s" .. c end

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
  { p":",             function() Snacks.picker.pickers() end,         desc = "Pickers"                 },
  { p".",             function() Snacks.picker.resume() end,          desc = "Resume"                  },

  { K.sc"f",          smart,                                          desc = "[snacks] Files"          },
  { p"f",             smart,                                          desc = "Files"                   },
  { p"r",             recent,                                         desc = "Recent"                  },
  { p"F",             function() Snacks.picker.git_files() end,       desc = "Git files"               },

  { p"b",             function() Snacks.picker.buffers() end,         desc = "Buffers"                 },
  { "<C-S-o>",        function() Snacks.picker.buffers() end,         desc = "Buffers"                 },

  { K.sc"G",          function() Snacks.picker.grep() end,            desc = "[snacks] Grep"           },
  { p"g",             function() Snacks.picker.grep() end,            desc = "Grep"                    },

  { "<C-S-/>",        function() Snacks.picker.help() end,            desc = "[snacks] Help"           },
  { p"h",             function() Snacks.picker.help() end,            desc = "Help"                    },

  { p"C",             function() Snacks.picker.command_history() end, desc = "Command history"         },
  { p"n",             function() Snacks.picker.notifications() end,   desc = "Notification history"    },

  { p"p",             function() Snacks.picker.lazy() end,            desc = "Plugins"                 },

  { K.ip"i",          function() Snacks.picker.icons() end,           desc = "[snacks] Icons",         mode = 'i' },
  { K.ip"y",          function() Snacks.picker.yanky() end,           desc = "[snacks] Yanky",         mode = 'i' },

  -- symbols
  { "gof",            function_symbols,                               desc = "[snacks] Goto functions" },
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
