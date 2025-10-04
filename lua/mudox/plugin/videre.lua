return {
  "Owen-Dechow/videre.nvim",
  dependencies = {
    "Owen-Dechow/graph_view_yaml_parser", -- Optional: add YAML support
    "Owen-Dechow/graph_view_toml_parser", -- Optional: add TOML support
    "a-usr/xml2lua.nvim", -- Optional | Experimental: add XML support
  },

  cmd = "Videre",

  opts = {
    round_units = false,
    simple_statusline = false,

    editor_type = "floating",
    floating_editor_style = {
      margin = 5,
      border = "none",
      zindex = 10,
    },
  },
}
