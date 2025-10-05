-- stylua: ignore
local function r(name) return require("mudox.plugin.snacks." .. name) end

local function init()
  On.very_lazy(r("toggle"))
end

-- stylua: ignore
local function k(c) return "<leader>s" .. c

end
-- stylua: ignore
local keys = {
  -- file
  { k"<Space>",       function() Snacks.picker.smart() end,           desc = "Smart find files"        },
  { "<Space><Space>", function() Snacks.picker.smart() end,           desc = "Smart find files"        },
  { k"f",             function() Snacks.picker.files() end,           desc = "Files"                   },
  { k"r",             function() Snacks.picker.recent() end,          desc = "Recent"                  },
  { k"g",             function() Snacks.picker.git_files() end,       desc = "Git files"               },

  { k"b",             function() Snacks.picker.buffers() end,         desc = "Buffers"                 },

  { k"P",             function() Snacks.picker.projects() end,        desc = "Projects"                },

  { k"\\",            function() Snacks.explorer() end,               desc = "File explorer"           },
  { "<leader>fl",     function() Snacks.explorer() end,               desc = "File explorer"           },

  { ",s",             function() Snacks.picker.grep() end,            desc = "Grep"                    },

  { "<C-S-/>",        function() Snacks.picker.help() end,            desc = "Help"                    },

  { k"C",             function() Snacks.picker.command_history() end, desc = "Command history"         },
  { k"n",             function() Snacks.picker.notifications() end,   desc = "Notification history"    },

  { "<leader>ps",     function() Snacks.profiler.scratch() end,       desc = "Profiler scratch buffer" },
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
