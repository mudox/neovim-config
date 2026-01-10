local M = {}

function M.setup()
  require("mini.files").setup {
    mappings = {
      go_in_plus = "<Cr>",
    },
    options = {
      use_as_default_explorer = false,
    },
  }

  -- require("mudox.plugin.mini.files_layout")
end

-- stylua: ignore
M.keys = {
  { K.p"om", function() MiniFiles.open(vim.fn.expand("%")) end, desc = "[mini] %:h" },
  { K.p"oM", function() MiniFiles.open() end,                   desc = "[mini] cwd" },
}

return M
