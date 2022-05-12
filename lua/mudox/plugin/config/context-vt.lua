-- LATER: config structure has been updated
-- See: https://github.com/haringsrob/nvim_context_vt#advanced-usage
local opts = {
  highlight = "Comment",

  disable_ft = {},
  disable_virtual_lines_ft = { "python" },

  min_rows = 12,

  ---@diagnostic disable-next-line: unused-local
  custom_parser = function(node, ft, opts)
    local utils = require('nvim_context_vt.utils')
    local text = utils.get_node_text(node)[1]

    -- trim white spaces
    text = text:gsub("^%s*(.-)%s*$", "%1")

    return " " .. text
  end,
}

require("nvim_context_vt").setup(opts)
