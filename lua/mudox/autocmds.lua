-- vim: fml& fdn& fdm=marker fmr=〈,〉

-- References
--   autocmds.lua from LazyVim
--   3-autocmds.lua from NormalView

-- Checktime 〈

On({
  "BufEnter",
  "CursorHold",
  "CursorHoldI",
  "FocusGained",
  "TermClose",
  "TermLeave",
}, {
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
local fts = {
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
}
On("BufEnter", function(ev)
  if vim.tbl_contains(fts, vim.bo[ev.buf].filetype) then
    vim.bo[ev.buf].buflisted = false
    K.nmap("q", K.c("wincmd c"), { buffer = ev.buf, nowait = true, remap = false })
    K.nmap("<Bs>", K.c("wincmd c"), { buffer = ev.buf, nowait = true, remap = false })
  end
end, {
  group = V.ag.q,
  desc = "quit",
})

-- Close with `q` 〉

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

-- Command window 〈

On.CmdwinEnter(function(ev)
  local opts = { buffer = ev.buf, nowait = true, remap = false, silent = true }
  K.nmap("<Cr>", "<Cr>", opts)
  K.nmap("q", K.c("close"), opts)
end)

-- Command window 〉

On.BufWritePost(function()
  vim.cmd.trust()
end, { pattern = "\\.nvim\\.lua" })
