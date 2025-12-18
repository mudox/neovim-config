local M = {}

function M.setup()
  require("mini.align").setup {
    mappings = {
      -- start = "\\a",
      -- start_with_preview = "\\A",
    },
  }
end

return M
