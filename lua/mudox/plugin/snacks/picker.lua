-- stylua: ignore
local function p(c) return K.p"s" .. c end

local function functions()
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
      width = 0.5,
      min_width = 80,
      height = 0.8,
      min_height = 30,

      border = "rounded",
      title = "{title} {live} {flags}",
      title_pos = "center",
      backdrop = false,

      box = "vertical",
      { win = "input", height = 1, border = "single" },
      { win = "list", border = "single" },
      { win = "preview", title = "{preview}", height = 0.4, border = "single" },
    },
  },
}

-- stylua: ignore
local keys = {
  { p":",             function() Snacks.picker.pickers() end,         desc = "pickers"                 },
  { p".",             function() Snacks.picker.resume() end,          desc = "resume"                  },

  { K.sc"f",          smart,                                          desc = "[snacks] files"          },
  { p"f",             smart,                                          desc = "files"                   },
  { p"r",             recent,                                         desc = "recent"                  },
  { p"F",             function() Snacks.picker.git_files() end,       desc = "git files"               },

  { p"b",             function() Snacks.picker.buffers() end,         desc = "buffers"                 },

  { K.sc"G",          function() Snacks.picker.grep() end,            desc = "[snacks] grep"           },
  { p"g",             function() Snacks.picker.grep() end,            desc = "grep"                    },

  { "<C-S-/>",        function() Snacks.picker.help() end,            desc = "[snacks] help"           },
  { p"h",             function() Snacks.picker.help() end,            desc = "help"                    },

  { p"C",             function() Snacks.picker.command_history() end, desc = "command history"         },
  { p"n",             function() Snacks.picker.notifications() end,   desc = "notification history"    },

  { p"p",             function() Snacks.picker.lazy() end,            desc = "plugins"                 },

  { K.ip"i",          function() Snacks.picker.icons() end,           desc = "[snacks] icons",         mode = 'i' },
  { K.ip"y",          function() Snacks.picker.yanky() end,           desc = "[snacks] yanky",         mode = 'i' },

  -- symbols
  { "gof",            functions,                                      desc = "[snacks] goto functions" },
}

local opts = {
  ui_select = true,

  layout = {
    preset = function()
      return vim.o.columns >= 120 and "telescope" or "vertical"
    end,
    layouts = layouts,
  },

  sources = {
    select = {
      layout = {
        hidden = { "preview" },
        layout = {
          width = 0.5,
          min_width = 80,
          max_width = 100,
          height = 0.4,
          min_height = 2,

          border = false,
          backdrop = false,

          box = "vertical",
          { win = "input", height = 1, border = "single" },
          { win = "list", border = "single" },
          { win = "preview", height = 0.4, border = "single" },
        },
      },
    },
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
