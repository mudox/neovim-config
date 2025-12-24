local M = {}

function M.setup()
  require("mini.surround").setup {
    mappings = {
      add = "qa",
      delete = "qd",
      replace = "qr",

      find = "q]",
      find_left = "q[",
      highlight = "qv",
    },

    search_method = "cover_or_next",

    respect_selection_type = true,
  }
end

return M
