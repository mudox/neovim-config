local M = {}

function M.setup()
  require("mini.files").setup()
end

-- stylua: ignore
M.keys = {
  { K.p("fq"), function() MiniFiles.open() end, desc = "[mini] files" },
}

return M
