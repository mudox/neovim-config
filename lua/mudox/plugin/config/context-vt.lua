require("nvim_context_vt").setup {
  -- Override the internal highlight group name
  highlight = "Comment",

  -- Disable virtual text for given filetypes
  -- Default is an empty table
  disable_ft = {},
  disable_virtual_lines_ft = { 'python' },

  -- How many lines required after starting position to show virtual text
  -- Default is 1 (equals two lines total)
  min_rows = 12,

  -- Callback to override the generated virtual text.
  -- You can also use this to filter out node types.
  ---@diagnostic disable-next-line: unused-local
  custom_parser = function(node, ft, opts)
    local ts = require("nvim-treesitter.ts_utils")
    local text = ts.get_node_text(node)[1]

    -- trim white spaces
    text = text:gsub("^%s*(.-)%s*$", "%1")

    return " " .. text
  end,
}
