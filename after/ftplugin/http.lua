vim.opt_local.foldenable = false

local function k(name)
  return function()
    require("kulala")[name]()
  end
end

-- stylua: ignore
local kulala = {
  { "<C-n>",         k"jump_next",          desc = "[Kualala] Goto next"     },
  { "<C-p>",         k"jump_prev",          desc = "[Kualala] Goto previous" },

  { "<Cr>",          k"run",                desc = "Run"                     },
  { "<leader>k<Cr>", k"run",                desc = "Run"                     },
  { "<leader>k.",    k"replay",             desc = "Rerun"                   },

  { "<leader>kc",    k"copy",               desc = "Copy as cURL"            },
  { "<leader>kf",    k'from_curl',          desc = "Paste as HTTP spec"      },

  { "<leader>ki",    k"inspect",            desc = "Inspect"                 },
  { "<C-v>",         k"toggle_view",        desc = "Toggle view"             },

  { "<C-2>",         k'search',             desc = "Goto ..."                },

  { "<leader>kX",    k'clear_cached_files', desc = "Clear"                   },
}

require("which-key").add { kulala, { buffer = 0 } }
