local M = {}

function M.setup()
  require("mini.files").setup {
    files = {
      mappings = {
        go_in_plus = "<Cr>",
      },
    },
  }
end

-- stylua: ignore
M.keys = {
  { "<M-'>", function() MiniFiles.open(vim.fn.expand('%')) end, desc = "[mini] open cwd" },
}

return M
