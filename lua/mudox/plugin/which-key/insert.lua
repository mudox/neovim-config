local function append(c)
  return function()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_get_current_line()
    local ws = line:match("^%s+") or ""
    vim.api.nvim_buf_set_lines(0, row - 1, row, false, { line .. c, ws })
    vim.api.nvim_win_set_cursor(0, { row + 1, ws:len() })
  end
end

-- stylua: ignore
return {
  { "<C-k>",    group = "insert leader" },

  mode = "i",
  {
    { "<C-;>",    append(";"), desc = "Append ; + NL" },
    { "<C-,>",    append(","), desc = "Append , + NL" },
    { "<C-S-Cr>", append(""),  desc = "Newline"       },
  },
}
