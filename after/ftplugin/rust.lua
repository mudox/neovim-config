-- stylua: ignore start
local function k(key)  return ";l" .. key                      end
local function c(cmd)  return "<Cmd>RustLsp " .. cmd .. "<Cr>" end
local function d(desc) return "[Rust] " .. desc                end
-- stylua: ignore end

-- stylua: ignore
local keymaps = {
  [";l"] = {
    name = "+rust",

    -- actions
    a         = { c("codeAction"),        d("Code actions")        },
    k         = { c("hover actions"),     d("Hover")               },

    -- check & run & debug
    c         = { c("flyCheck"),          d("Check")               },
    r         = { c("runnables"),         d("Run")                 },
    d         = { c("debuggables"),       d("Debug")               },

    -- macro
    E         = { c("expandMacro"),       d("Expand macros")       },
    M         = { c("rebuildProcMacros"), d("Rebuild proc macros") },

    -- goto
    t         = { c("openCargo"),         d("Open Cargo.toml")     },
    p         = { c("parentModule"),      d("Goto parent module")  },

    -- diagnostic
    ["?"]     = { c("explainError"),      d("Explain errors")      },

    -- view
    T         = { c("syntaxTree"),        d("View syntax tree")    },
    -- view create graph

    -- refactor
    J         = { c("joinLines"),         d("Join lines")          },
    ["<M-k>"] = { c("moveItem up"),       d("Move item up")        },
    ["<M-j>"] = { c("moveItem down"),     d("Move item down")      },
  },
}

require("which-key").add(keymaps, { buffer = vim.api.nvim_get_current_buf() })
