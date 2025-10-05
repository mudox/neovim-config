-- stylua: ignore
local function r(name) return require("mudox.plugin.snacks." .. name) end

local function init()
  On.very_lazy(r("toggle"))
end

local k = "<leader>s"
-- stylua: ignore
local keys = {
  -- common
  { k .. "<Space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files"       },
  { k .. "b",       function() Snacks.picker.buffers() end,                                 desc = "Buffers"                },
  { k .. "w",       function() Snacks.picker.grep() end,                                    desc = "Grep"                   },
  { k .. "C",       function() Snacks.picker.command_history() end,                         desc = "Command History"        },
  { k .. "n",       function() Snacks.picker.notifications() end,                           desc = "Notification History"   },

  { k .. "\\",      function() Snacks.explorer() end,                                       desc = "File Explorer"          },
  { "<leader>fl",   function() Snacks.explorer() end,                                       desc = "File Explorer"          },

  -- find
  { k .. "fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers"                },
  { k .. "fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File"       },
  { k .. "ff",      function() Snacks.picker.files() end,                                   desc = "Find Files"             },
  { k .. "fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files"         },
  { k .. "fp",      function() Snacks.picker.projects() end,                                desc = "Projects"               },
  { k .. "fr",      function() Snacks.picker.recent() end,                                  desc = "Recent"                 },

  -- profiler
  { "<leader>ps",   function() Snacks.profiler.scratch() end,                               desc = "Profiler Scratch Buffer" },
}

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 900,
  keys = keys,
  init = init,
  opts = function()
    -- stylua: ignore
    return {
      bigfile      = {},
      dashboard    = { enabled = not C.alpha },
      input        = {},
      picker       = r"picker",
      quickfile    = {},

      toggle       = {
        which_key  = true,
        wk_desc    = {
          enabled  = "󰝥  ",
          disabled = "󰝦  ",
        },
      },
    }
  end,
}
