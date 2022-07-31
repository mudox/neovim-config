local i = require("mudox.ui").icons
local kind = require("lspsaga.lspkind")
-- see lua/lspsaga/lspkind.lua
-- kind[type_number][2] = icon

local opts = {
  move_in_saga = { prev = "K", next = "J" },
  diagnostic_header = { i.error, i.warn, i.info, i.hint },
  code_action_icon = "💡",
  code_action_lightbulb = {
    enable = true,
    sign = true,
    enable_in_insert = false,
    sign_priority = 20,
    virtual_text = false,
  },
  finder_icons = {
    def = "  ",
    ref = " ",
    link = "  ",
  },
  finder_action_keys = {
    open = "<Cr>",
    vsplit = "v",
    split = "s",
    tabe = "t",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  definition_preview_icon = "  ",
  symbol_in_winbar = {
    in_custom = false,
    enable = false,
    separator = " ",
    show_file = true,
    click_support = false,
  },
}

require("lspsaga").init_lsp_saga(opts)
