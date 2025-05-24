local prefix = ";r"

local function c(t)
  t[1] = prefix .. t[1]
  t[2] = "<Cmd>RustLsp " .. t[2] .. "<Cr>"
  return t
end

local function p(t)
  t[1] = prefix .. t[1]
  t[2] = ":<C-u>RustLsp " .. t[2] .. " "
  t[2] = t[2]:gsub("%s+$", " ")
  t.silent = false
  return t
end

-- stylua: ignore
local keymaps = {
  buffer = vim.api.nvim_get_current_buf(),

  { prefix,    group = "rust" },

  -- main command
  p{ "<Space>", "",                   desc = ":RustLsp ..."        },

  -- acitons
  c{ "a",       "codeAction",         desc = "Code actions ..."    },

  -- check & run & debug
  c{ "c",       "flyCheck",           desc = "Check"               },
  c{ "r",       "runnables",          desc = "Runables"            },
  c{ "d",       "debuggables",        desc = "Debuggables"         },

  -- macro
  c{ "E",       "expandMacro",        desc = "Expand macros"       },
  c{ "M",       "rebuildProcMacros",  desc = "Rebuild proc macros" },

  -- navigation
  c{ "=",       "openCargo",          desc = "Open Cargo.toml"     },
  c{ "-",       "parentModule",       desc = "Goto parent module"  },
  p{ "/",       "workspaceSymbol",    desc = "Search symbols"      },

  -- diagnostic
  c{ "?",       "explainError",       desc = "Explain errors"      },
  c{ "x",       "renderdiagnostic",   desc = "Render diagnostic"   },
  c{ "X",       "relatedDiagnostics", desc = "Related diagnostics" },

  -- view
  c{ "T",       "syntaxTree",         desc = "View syntax tree"    },

  -- refactor
  p{ "s",       "ssr",                desc = "SSR"                 },

  -- view
  p{ "G",       "crateGraph ",        desc = "Crate graph"         },
  c{ "T",       "syntaxTree",         desc = "Syntax tree"         },
}

require("which-key").add(keymaps)
