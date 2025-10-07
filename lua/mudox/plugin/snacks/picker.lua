-- stylua: ignore
local function k(c) return "<leader>s" .. c end

-- stylua: ignore
local keys = {
  { k":",             function() Snacks.picker.pickers() end,         desc = "Pickers"              },

  { k"<Space>",       function() Snacks.picker.smart() end,           desc = "Smart find files"     },
  { ",f",             function() Snacks.picker.smart() end,           desc = "Smart find files"     },
  { k"f",             function() Snacks.picker.files() end,           desc = "Files"                },
  { k"g",             function() Snacks.picker.git_files() end,       desc = "Git files"            },
  { k"r",             function() Snacks.picker.recent() end,          desc = "Recent"               },

  { k"b",             function() Snacks.picker.buffers() end,         desc = "Buffers"              },
  -- { "<C-S-o>",    function() Snacks.picker.buffers() end,         desc = "Buffers"              },

  { k"P",             function() Snacks.picker.projects() end,        desc = "Projects"             },

  { ",S",             function() Snacks.picker.grep() end,            desc = "Grep"                 },

  { ",h",             function() Snacks.picker.help() end,            desc = "Help"                 },

  { k"C",             function() Snacks.picker.command_history() end, desc = "Command history"      },
  { k"n",             function() Snacks.picker.notifications() end,   desc = "Notification history" },

  { k"p",             function() Snacks.picker.lazy() end,            desc = "Plugins"              },
}

local opts = {
  ui_select = true,

  layout = {
    -- The default layout for "telescopy" pickers, e.g. `files`, `commands`, ...
    -- It will not override non-standard pickers, e.g. `explorer`, `lines`, ...
    preset = function()
      return vim.o.columns >= 120 and "telescope" or "vertical"
    end,
    layouts = {
      telescope = {
        -- Copy from https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#telescope
        reverse = false,
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
