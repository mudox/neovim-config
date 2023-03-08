local pairs = require("nvim-autopairs")

pairs.setup {
  -- integrate with tree-sitter
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },

  disable_filetype = { "TelescopePrompt", "spectre_panel" },

  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}

-- map <Cr> integrate with `nvim-cmp`
local cmp = require("cmp")
local cmp_pairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_pairs.on_confirm_done { map_char = { tex = "" } })
