local opts = {
  -- integrate with tree-sitter
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },

  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  disable_in_visualblock = true,

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

local function config()
  local ap = require("nvim-autopairs")
  ap.setup(opts)

  -- map <Cr> integrate with `nvim-cmp`
  -- local cmp = require("cmp")
  -- local cmp_pairs = require("nvim-autopairs.completion.cmp")
  -- cmp.event:on("confirm_done", cmp_pairs.on_confirm_done())
end

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = config,
}
