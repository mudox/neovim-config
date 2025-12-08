-- vim: fml& fdn& fdm=marker fmr=〈,〉

-- References
--   autocmds.lua from LazyVim
--   3-autocmds.lua from NormalView

-- Checktime 〈

On({ "CursorHold", "FocusGained", "TermClose", "TermLeave" }, {
  group = V.ag.checktime,
  command = "silent! checktime",
})

-- Check if we 〉

-- Auto resize windows 〈

On("VimResized", {
  group = V.ag.window,
  desc = "Auto-re-equalize windows",
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. tab)
  end,
})

-- Auto resize window 〉

-- Quit with `q` 〈

On("FileType", function()
  vim.bo.buflisted = false
  K.nmap("q", K.c("close"), { buffer = true, nowait = true })
end, {
  group = V.ag.q,
  desc = "quit",
  pattern = {
    "OverseerList",
    "PlenaryTestPopup",
    "aerial-nav",
    "checkhealth",
    "fugitive",
    "fugitiveblame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "null-ls-info",
    "nvim-undotree",
    "qf",
    "qr_panel",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "pager",
  },
})

On.CmdwinEnter(function()
  K.nmap("q", K.c("close"), { buffer = true, nowait = true })
end, { once = true })

-- Close with `q` 〉

-- Wrap & check spell 〈

On("FileType", function()
  vim.opt_local.wrap = true
  vim.opt_local.spell = true
end, {
  group = V.ag.spell,
  desc = "spell check + wrap lines",
  pattern = {
    "gitcommit",
    "markdown",
    "neorg",
  },
})

-- Wrap & check spell 〉

-- Unfold for small files 〈

-- Unfold for small files 〉

-- Lock cmdheight 〈

On("CursorHold", function()
  if vim.o.cmdheight ~= 2 then
    vim.o.cmdheight = 2
  end
end)

-- Lock cmdheight 〉

-- Disable folding in insert mode 〈

-- Disable folding in insert mode 〉

-- DO NOT ues event earlier than UIEnter
-- event `TermOpen` will not be triggered
On.UIEnter(function()
  require("mudox.lab.xpress")
end)
