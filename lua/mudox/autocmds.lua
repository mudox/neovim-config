-- vim: fdm=marker fmr=〈,〉
-- TODO: move in my autocmds

-- References
-- -> autocmds.lua from LazyVim
-- -> 3-autocmds.lua from NormalView

local autocmd = vim.api.nvim_create_autocmd

local augroup = function(name)
  return vim.api.nvim_create_augroup("mudox_" .. name, { clear = true })
end

-- Checktime 〈

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Check if we 〉

-- Flash on yanking 〈

autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  desc = "Flash on yanking",
  callback = function()
    vim.highlight.on_yank { timeout = 250 }
  end,
})

-- Flash on yanking 〉

-- Auto resize windows 〈

autocmd("VimResized", {
  group = augroup("resize_splits"),
  desc = "Auto-resize (re-equalize) windows when needed",
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.fn.execute("tabnext " .. tab)
  end,
})

-- Auto resize window 〉

-- Go to last loc when opening a buffer 〈

autocmd("BufRead", {
  group = augroup("last_loc"),
  desc = "Jump to last known location after opening a file",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Go to last loc when opening a buffer 〉

-- Close with `q` 〈

local close_with_q = augroup("close_with_q")
autocmd("FileType", {
  group = close_with_q,
  desc = "Close specific filetypes using `q`",
  pattern = {
    "aerial-nav",
    "fugitive",
    "help",
    "lspinfo",
    "lspinfo",
    "man",
    "notify",
    "null-ls-info",
    "OverseerList",
    "PlenaryTestPopup",
    "qf",
    "qr_panel",
    "query",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<Cr>", { buffer = event.buf, silent = true })
  end,
})

-- Close with `q` 〉

-- Wrap & spell 〈

autocmd("FileType", {
  group = augroup("wrap_spell"),
  desc = "Wrap lines and enable spell checking for specific filetypes",
  pattern = {
    "gitcommit",
    "markdown",
    "neorg",
  },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Wrap & spell 〉

-- Colorscheme 〈

-- local c = require("mudox.ui").colors
-- local d = c.diff
-- local cmd = table.concat({
--   -- transparent background
--   "hi Normal guibg=NONE",

--   -- transparent sign column
--   "hi GitGutterAdd guibg=NONE",
--   "hi GitGutterDelete guibg=NONE",
--   "hi GitGutterChange guibg=NONE",

--   -- diff
--   ("hi DiffAdd guibg=%s"):format(d.add.bg),
--   ("hi DiffDelete guibg=%s"):format(d.delete.bg),
--   ("hi DiffChange guifg=%s guibg=%s"):format(d.change.fg, d.change.bg),
--   ("hi DiffText guifg=%s"):format(d.text.fg),

--   -- brighter text
--   "hi Folded guifg=#999999 guibg=NONE",

--   -- brighter border and border title
--   "hi link FloatBorder TelescopeBorder",

--   -- lsp highlight cursor
--   "hi default link LspReferenceText CursorColumn",
--   "hi default link LspReferenceRead LspReferenceText",
--   "hi default link LspReferenceWrite LspReferenceText",

--   -- copilot
--   "hi CopilotSuggestion guifg=#237cff",
-- }, "\n")

-- gid = vim.api.nvim_create_augroup("MudoxColorScheme", { clear = true })
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   group = gid,
--   command = cmd,
-- })

-- 〉
