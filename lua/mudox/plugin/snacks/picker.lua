-- stylua: ignore
local function k(c) return K.p"s" .. c end

-- stylua: ignore
local keys = {
  { k":",             function() Snacks.picker.pickers() end,         desc = "Pickers"              },
  { k".",             function() Snacks.picker.resume() end,          desc = "Resume"               },

  { "<Space><Space>", function() Snacks.picker.smart() end,           desc = "[Snacks] Files"       },
  { K.sc"f",          function() Snacks.picker.smart() end,           desc = "[Snacks] Files"       },
  { k"g",             function() Snacks.picker.git_files() end,       desc = "Git files"            },
  { k"r",             function() Snacks.picker.recent() end,          desc = "Recent"               },

  { k"b",             function() Snacks.picker.buffers() end,         desc = "Buffers"              },
  { "<C-S-o>",        function() Snacks.picker.buffers() end,         desc = "Buffers"              },

  { K.sc"G",          function() Snacks.picker.grep() end,            desc = "[Snacks] Grep"        },

  { "<C-S-/>",        function() Snacks.picker.help() end,            desc = "Help"                 },

  { k"C",             function() Snacks.picker.command_history() end, desc = "Command history"      },
  { k"n",             function() Snacks.picker.notifications() end,   desc = "Notification history" },

  { k"p",             function() Snacks.picker.lazy() end,            desc = "Plugins"              },

  { "<C-k>i",         function() Snacks.picker.icons() end,           desc = "[Snacks] Icons",      mode = 'i' },
  { "<C-k>y",         function() Snacks.picker.yanky() end,           desc = "[Snacks] Yanky",      mode = 'i' },
}

local opts = {
  ui_select = false,

  layout = {
    -- The default layout for "telescopy" pickers, e.g. `files`, `commands`, ...
    -- It will not override non-standard pickers, e.g. `explorer`, `lines`, ...
    preset = function()
      return vim.o.columns >= 120 and "telescope" or "vertical"
    end,

    layouts = {
      telescope = {
        -- Copy from https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#telescope
        reverse = true,
        layout = {
          box = "horizontal",
          backdrop = false,
          width = 0.8, -- Change the width
          height = 0.9,
          border = "none",
          {
            box = "vertical",
            {
              win = "input",
              height = 1,
              border = "none",
              title = "{title} {live} {flags}",
              title_pos = "center",
            },
            {
              win = "list",
              title = " Results ",
              title_pos = "center",
              border = "none",
            },
          },
          {
            win = "preview",
            title = "{preview:Preview}",
            width = 0.51, -- Change the preview width
            border = "none",
            title_pos = "center",
          },
        },
      },
    },
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
