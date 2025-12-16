local M = {}

function M.setup()
  require("mini.files").setup()
end

-- stylua: ignore
M.keys = {
  { K.p("fQ"), function() MiniFiles.open() end, desc = "[mini] open cwd" },
  { K.p("fq"), function() MiniFiles.open(vim.fn.expand('%')) end, desc = "[mini] open %" },
}

return M
