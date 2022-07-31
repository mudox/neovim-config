local gitsigns = require("gitsigns")

-- stylua: ignore start
local signs = {
  add          = { hl = "GitSignsAdd",    text = "┃", numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn"    },
  change       = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  delete       = { hl = "GitSignsDelete", text = "┃", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
  topdelete    = { hl = "GitSignsDelete", text = "┃", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
  changedelete = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
}
-- stylua: ignore end

local on_attach = function(bufnr)
  -- Setup keymaps
  local function map(from, to)
    local nreq = require("mudox.keymap").nreq
    nreq(from, "gitsigns", to, { buffer = bufnr })
  end

  map(",g<Space>", "toggle_signs()")

  map(",gs", "stage_hunk()")
  map(",gu", "undo_stage_hunk()")
  map(",gD", "reset_hunk()")

  map(",gd", "diffthis()")
  map(",gb", "blame_line()")

  map(",gv", "preview_hunk()")
  map("gG", "preview_hunk()")

  map("]g", "next_hunk()")
  map("[g", "prev_hunk()")
end

gitsigns.setup {
  on_attach = on_attach,

  -- UI
  signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
  signs = signs,
  sign_priority = -100, -- show on leftmost sign column

  numhl = true,
  linehl = false,

  -- Blame
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = true,
  },

  update_debounce = 100,
  max_file_length = 40000,

  status_formatter = nil, -- Use default

  -- Preview
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },

  yadm = {
    enable = false,
  },
}
