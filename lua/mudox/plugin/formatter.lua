local function opts()
  local util = require("formatter.util")

  local filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua,
    },

    sh = {
      require("formatter.filetypes.sh").shfmt,
    },

    zh = {
      require("formatter.filetypes.sh").shfmt,
    },

    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  }

  return {
    logging = false,
    filetype = filetype,
  }
end

local keys = {
  { "\\q", "<Cmd>FormatLock<Cr>", desc = "Format by formatter.nvim" },
  { "\\w", "<Cmd>FormatWriteLock<Cr>", desc = "Format and write by formatter.nvim" },
}

return {
  "mhartington/formatter.nvim",
  cmd = { "Format", "FormatWrite", "FormatLock", "FormatWriteLock" },
  keys = keys,
  opts = opts,
}
