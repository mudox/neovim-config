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
  On.User("visual_multi_start", function()
    vim.opt.eventignore = { "TextChangedI", "TextChangedP", "InsertCharPre", "CursorMovedI" }

    require("illuminate").pause_buf()
    require("lualine").hide { unhide = false, place = { "statusline" } }
    require("nvim-autopairs").disable()
  end)

  On.User("visual_multi_exit", function()
    vim.o.eventignore = ""

    require("illuminate").resume_buf()
    require("lualine").hide { unhide = true, place = { "statusline" } }
    require("nvim-autopairs").enable()
  end)
end

local function keys()
  -- stylua: ignore
  return {
    "<C-LeftMouse>",

    { "<C-n>", mode = { "n", "x" },     desc = "[VM] Add word",          },
    { K.p"z*", mode = { 'n', 'x' },     desc = "select all",             },
    { K.p"z+", mode = { 'n', 'x' },     desc = "add",                    },
    { K.p"z/", mode = { 'n', 'x' },     desc = "search",                 },

    { "<M-j>",                          desc = "[VM] Select cursor down" },
    { "<M-k>",                          desc = "[VM] Select cursor up"   },

    { K.p"z.",                          desc = "reselct"                 },

    { "<Bs>z",      "<Cmd>VMClear<Cr>", desc = "[VM] Clear"              },
    { K.p"vZ",      "<Cmd>VMDebug<Cr>", desc = "visual multi"            },
  }
end

return {
  "mg979/vim-visual-multi",
  keys = keys,
  init = init,
  config = config,
}
