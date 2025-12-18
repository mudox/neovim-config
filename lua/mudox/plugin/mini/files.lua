local M = {}

function M.setup()
  require("mini.files").setup {
    mappings = {
      go_in_plus = "<Cr>",
    },
  }

  -- require("mudox.plugin.mini.files_layout")
end

-- stylua: ignore
M.keys = {
  { "<M-'>", function() MiniFiles.open(vim.fn.expand("%")) end, desc = "[mini] open %:h" },
  { K.p"om", function() MiniFiles.open() end,                   desc = "[mini] open cwd" },
}

return M
