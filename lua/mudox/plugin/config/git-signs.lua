local gitsigns = require("gitsigns")

-- Make background transparent
-- GitSignsXXX linked to GitGutterXXX
vim.cmd([[
hi GitGutterAdd guibg=NONE
hi GitGutterChange guibg=NONE
hi GitGutterDelete guibg=NONE
hi GitGutterChangeDelete guibg=NONE
]])

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
  local function bind(from, to)
    local ncmd = require("mudox.keymap").ncmd
    to = ([[lua require("gitsigns").%s]]):format(to)
    ncmd(from, to, { bufnr = bufnr })
  end

  bind(",g<Space>", "toggle_signs()")

  bind(",gs", "stage_hunk()")
  bind(",gu", "undo_stage_hunk()")
  bind(",gD", "reset_hunk()")

  bind(",gd", "diffthis()")
  bind(",gb", "blame_line()")

  bind(",gv", "preview_hunk()")
  bind("gG", "preview_hunk()")

  bind("]g", "next_hunk()")
  bind("[g", "prev_hunk()")
end

gitsigns.setup {
  on_attach = on_attach,

  -- UI
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
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
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },

  yadm = {
    enable = false,
  },
}
