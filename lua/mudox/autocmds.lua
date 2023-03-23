-- TODO: move my autocmds

local function augroup(name)
  return vim.api.nvim_create_augroup("mudox_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.fn.execute("tabnext " .. tab)
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
local close_with_q = augroup("close_with_q")
autocmd("FileType", {
  group = close_with_q,
  pattern = {
    "help",
    "lspinfo",
    "lspinfo",
    "man",
    "notify",
    "null-ls-info",
    "PlenaryTestPopup",
    "qf",
    "qr_panel",
    "startuptime",
    "tsplayground",
    "OverseerList",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<Cr>", { buffer = event.buf, silent = true })
  end,
})

-- Wrap lines and check for spell in text filetypes
autocmd("FileType", {
  group = augroup("wrap_spell"),
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
