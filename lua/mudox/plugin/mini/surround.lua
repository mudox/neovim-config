local M = {}

function M.setup()
  require("mini.surround").setup {
    -- stylua: ignore
    mappings = {
      add       = "sa",
      delete    = "sd",
      replace   = "sr",

      find      = "s]",
      find_left = "s[",
      highlight = "sv",
    },

    search_method = "cover_or_next",

    respect_selection_type = true,
  }
end

return M
