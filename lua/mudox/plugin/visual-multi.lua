local function init()
  vim.g.VM_mouse_mappings = 1

  vim.g.VM_silent_exit = 1
  vim.g.VM_verbose_commands = 1

  -- for performance
  vim.g.VM_live_editing = 0
  vim.g.VM_disable_syntax_in_imode = 1

  -- single esc to exit
  -- vim.g.VM_quit_after_leaving_insert_mode = 1

  -- for auto-completion
  vim.g.VM_use_first_cursor_in_line = 1

  vim.g.VM_theme = "neon"

  vim.g.VM_leader = K.p("z")
  local function k(s)
    return vim.g.VM_leader .. s
  end

  vim.g.VM_force_maps = { "<Tab>", "[", "]" }
  -- stylua: ignore
  vim.g.VM_maps = {
    ["Select All"] = k("*"),
    ["Add Cursor At Pos"] = k("+"),
    ["Reselect Last"] = k("."),

    ["Visual All"] = k("*"),
    ["Visual Add"] = k("+"),
    ["Visual Cursors"] = "<Bar>",

    ["Select Cursor Down"] = "<M-j>",
    ["Select Cursor Up"] = "<M-k>",

    ["Toggle Mappings"] = k("<Space>"),
  }
end

local config = function()
  On.user("visual_multi_start", function()
    require("illuminate").pause_buf()
    require("lualine").hide { unhide = false, place = { "statusline" } }
  end)

  On.user("visual_multi_exit", function()
    require("illuminate").resume_buf()
    require("lualine").hide { unhide = true, place = { "statusline" } }

    -- recover
    require("which-key").add {
      { "<Tab>", group = "tabpage" },
      { "]", group = "next" },
      { "[", group = "prev" },
    }
  end)
end

local function keys()
  -- stylua: ignore
  return {
    "<C-LeftMouse>",

    { "<C-n>", mode = { "n", "x" },     desc = "[VM] Add word",          },
    { K.p"z*", mode = { 'n', 'x' },     desc = "Select all",             },
    { K.p"z+", mode = { 'n', 'x' },     desc = "Add",                    },
    { K.p"z/", mode = { 'n', 'x' },     desc = "Search",                 },

    { "<M-j>",                          desc = "[VM] Select cursor down" },
    { "<M-k>",                          desc = "[VM] Select cursor up"   },

    { K.p"z.",                          desc = "Reselct"                 },

    { "<Bs>z",      "<Cmd>VMClear<Cr>", desc = "[VM] Clear"              },
    { K.p"vZ",      "<Cmd>VMDebug<Cr>", desc = "Visual Multi"            },
  }
end

return {
  "mg979/vim-visual-multi",
  keys = keys,
  init = init,
  config = config,
}
