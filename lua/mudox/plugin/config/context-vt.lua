require("nvim_context_vt").setup {
  -- Override the internal highlight group name
  -- Default is 'ContextVt'
  highlight = "CustomContextVt",

  -- Disable virtual text for given filetypes
  -- Default is an empty table
  disable_ft = {},

  -- How many lines required after starting position to show virtual text
  -- Default is 1 (equals two lines total)
  min_rows = 8,

  -- Callback to override the generated virtual text.
  -- You can also use this to filter out node types.
  custom_text_handler = function(node, ts_utils)
    -- If you return `nil`, no virtual text will be displayed.
    -- if node:type() == 'function' then
    -- return nil
    -- end

    -- This is the standard text
    return "--> " .. ts_utils.get_node_text(node)[1]
  end,
}
