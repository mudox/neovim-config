-- vim: fml& fdn& fdm=marker fmr=〈,〉

-- References
--   autocmds.lua from LazyVim
--   3-autocmds.lua from NormalView

local g = function(name)
  return vim.api.nvim_create_augroup("mdx_" .. name, { clear = true })
end

-- Checktime 〈

On({ "CursorHold", "FocusGained", "TermClose", "TermLeave" }, {
  group = g("checktime"),
  command = "silent! checktime",
})

-- Check if we 〉

-- Auto resize windows 〈

On("VimResized", {
  group = g("equalize_splits"),
  desc = "Auto-re-equalize windows",
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. tab)
  end,
})

-- Auto resize window 〉

-- Quit with `q` 〈

On("FileType", function(event)
  vim.bo[event.buf].buflisted = false
  vim.keymap.set("n", "q", "<Cmd>quit<Cr>", { buffer = event.buf, silent = true })
end, {
  group = g("close_with_q"),
  desc = "Close using `q`",
  pattern = {
    "aerial-nav",
    "checkhealth",
    "fugitive",
    "fugitiveblame",
    "grug-far",
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
})

-- Close with `q` 〉

-- Wrap & check spell 〈

On("FileType", function()
  vim.opt_local.wrap = true
  vim.opt_local.spell = true
end, {
  group = g("wrap_spell"),
  desc = "Wrap lines and check spelling",
  pattern = {
    "gitcommit",
    "markdown",
    "neorg",
  },
})

-- Wrap & check spell 〉

-- Unfold for small files 〈

On("BufRead", {
  group = g("unfold_for_small_file"),
  desc = "No fold for small files",
  callback = function()
    if vim.fn.line("$") < 20 then
      vim.wo.foldenable = false
    end
  end,
})

-- Unfold for small files 〉

-- Restore cmdheight 〈

On("CursorHold", function()
  if vim.o.cmdheight ~= 2 then
    vim.o.cmdheight = 2
  end
end)

-- Restore cmdheight 〉

On("TermEnter", function()
  vim.cmd.startinsert { bang = true }
end)
