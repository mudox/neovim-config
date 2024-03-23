-- vim: fml& fdn& fdm=marker fmr=〈,〉

-- References
--   autocmds.lua from LazyVim
--   3-autocmds.lua from NormalView

local on = vim.api.nvim_create_autocmd

local g = function(name)
  return vim.api.nvim_create_augroup("mdx_" .. name, { clear = true })
end

-- Checktime 〈

on({ "CursorHold", "FocusGained", "TermClose", "TermLeave" }, {
  group = g("checktime"),
  command = "checktime",
})

-- Check if we 〉

-- Auto resize windows 〈

on("VimResized", {
  group = g("equalize_splits"),
  desc = "Auto-re-equalize windows",
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. tab)
  end,
})

-- Auto resize window 〉

-- Go to last loc when opening a buffer 〈

-- on("BufRead", {
--   group = g("last_loc"),
--   desc = "Jump to last known location after opening a file",
--   callback = function(event)
--     local exclude = { "gitcommit" }
--     local buf = event.buf
--     if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
--       return
--     end
--     vim.b[buf].lazyvim_last_loc = true
--     local mark = vim.api.nvim_buf_get_mark(buf, '"')
--     local lcount = vim.api.nvim_buf_line_count(buf)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })
--
-- Go to last loc when opening a buffer 〉

-- Close with `q` 〈

on("FileType", {
  group = g("close_with_q"),
  desc = "Close using `q`",
  pattern = {
    "aerial-nav",
    "checkhealth",
    "fugitive",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "null-ls-info",
    "OverseerList",
    "PlenaryTestPopup",
    "qf",
    "qr_panel",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<Cr>", { buffer = event.buf, silent = true })
  end,
})

-- Close with `q` 〉

-- Wrap & check spell 〈

on("FileType", {
  group = g("wrap_spell"),
  desc = "Wrap lines and check spelling",
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

-- Wrap & check spell 〉

-- User event MdxSessionStart 〈

if vim.fn.argc(-1) == 0 then
  on("User", {
    pattern = "AlphaClosed",
    desc = "Start session after Alpha closed",
    callback = function()
      vim.api.nvim_exec_autocmds("User", { pattern = "MdxSessionStart" })
    end,
  })
else
  on("User", {
    pattern = "VeryLazy",
    desc = "Start session on 1st buffer load",
    callback = function()
      vim.api.nvim_exec_autocmds("User", { pattern = "MdxSessionStart" })
    end,
  })
end

-- User event MdxSessionStart 〉

-- Unfold for small files 〈

on("BufRead", {
  group = g("unfold_for_small_file"),
  desc = "No fold for small files",
  callback = function()
    if vim.fn.line("$") < 20 then
      vim.wo.foldenable = false
    end
  end,
})

-- Unfold for small files 〉
