local function code_actions()
  require("actions-preview").code_actions()
end

local opts = function()
  return {
    diff = {
      algorithm = "patience",
      ignore_whitespace = true,
    },
    telescope = require("telescope.themes").get_dropdown { winblend = 10 },
  }
end

return {
  "aznhe21/actions-preview.nvim",
  opts = opts,
  keys = {
    { "\\a", code_actions, desc = "Code Action" },
  },
}
