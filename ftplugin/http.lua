local function k(name)
  return function()
    require("kulala")[name]()
  end
end

local function r(name)
  return ("<Cmd>Rest %s<Cr>"):format(name)
end

-- stylua: ignore
local kulala = {
  { "<C-n>",         k("jump_next"),   desc = "[Kualala] Goto next"     },
  { "<C-p>",         k("jump_prev"),   desc = "[Kualala] Goto previous" },

  { "<leader>k<Cr>", k("run"),         desc = "[Kualala] Run"           },
  { "<leader>k.",    k("replay"),      desc = "[Kualala] Replay"        },

  { "<leader>kc",    k("copy"),        desc = "[Kualala] Copy"          },

  { "<leader>kv",    k("toggle_view"), desc = "[Kualala] Toggle view"   },
}

-- stylua: ignore
local rest = {
  { "<leader>r<Cr>", r"run",        desc = "[Rest] Run"               },
  { "<leader>r.",    r"last",       desc = "[Rest] Run last"          },

  { "<leader>rv",    r"open",       desc = "[Rest] Open result pane"  },

  { "<leader>rl",    r"logs",       desc = "[Rest] Edit logs file"    },
  { "<leader>rc",    r"cookies",    desc = "[Rest] Edit cookies file" },

  { "<leader>rev",   r"env show",   desc = "[Rest] Show env file"     },
  { "<leader>res",   r"env select", desc = "[Rest] Select env file"   },
}

require("which-key").add { { kulala, rest }, { buffer = 0 } }
