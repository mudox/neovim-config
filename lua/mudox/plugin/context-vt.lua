local opts = {
  highlight = "Comment",

  disable_ft = {},
  -- disable display of virtual text below blocks for indentation based languages
  disable_virtual_lines_ft = { "python", "yaml" },

  min_rows = 8,

  ---@diagnostic disable-next-line: unused-local
  custom_parser = function(node, ft, opts)
    local utils = require("nvim_context_vt.utils")
    local text = utils.get_node_text(node)[1]

    -- trim white spaces
    text = text:gsub("^%s*(.-)%s*$", "%1")

    return "   " .. text
  end,
}

return {
  "haringsrob/nvim_context_vt",
  event = { "BufRead", "BufNewFile" },
  opts = opts,
}
