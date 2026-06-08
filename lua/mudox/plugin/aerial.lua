local float = {
  border = "none",
  max_height = { 30, 0.6 },
}

local kinds = {
  -- fallback
  ["_"] = {
    "Module",

    "Interface",

    "Class",
    "Struct",
    "Enum",

    "Constructor",
    "Function",
    "Method",

    "Variable",
    "Constant",
  },
}

local post_parse_symbol = function(bufnr, item, ctx)
  if ctx.lang == "markdown" then
    item.kind = "MarkdownHeading"
  end
end

local opts = {
  highlight_mode = "none",

  min_width = require("mudox.ui").left_width,
  float = float,

  close_on_select = false,
  post_jump_cmd = "normal! zzzv",

  icons = {
    Collapsed = " " .. I.chevron.right,
    MarkdownHeading = "•",
  },

  post_parse_symbol = post_parse_symbol,

  filter_kind = kinds,

  show_guides = true,
}

-- stylua: ignore
local keys = {
  { K.p("wa"),  K.c"AerialToggle",     desc = "[aerial] toggle" },
  { "goa", K.c"Telescope aerial", desc = "[aerial] toggle" },
}

-- stylua: ignore
local cmd = {
  "Open", "OpenAll", "Close", "Toggle",
  "NavOpen", "NavClose", "NavToggle",
  "Info",
}

cmd = vim.tbl_map(function(e)
  return "Aerial" .. e
end, cmd)

local function config()
  require("aerial").setup(opts)
  require("telescope").load_extension("aerial")
end

return {
  "stevearc/aerial.nvim",
  cmd = cmd,
  keys = keys,
  config = config,
}
