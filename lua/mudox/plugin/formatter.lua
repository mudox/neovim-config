local function opts()
  local util = require("formatter.util")

  local filetype = {
    json = {
      require("formatter.filetypes.json").fixjson,
      require("formatter.filetypes.json").jq,
    },

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
  { "\\q", "<Cmd>FormatLock<Cr>", desc = "[Formatter] Format document" },
  { "\\w", "<Cmd>FormatWriteLock<Cr>", desc = "[Formatter] Format and write" },
}

return {
  "mhartington/formatter.nvim",
  cmd = { "Format", "FormatWrite", "FormatLock", "FormatWriteLock" },
  keys = keys,
  opts = opts,
  cond = false, -- use `conform` instead
}
