local keys = {
  { "goc", K.c("Telescope ctags_outline"), desc = "[telescope] smart files" },
}

local function config()
  local t = require("telescope")

  -- t.setup {
  --   extensions = {
  --     ctags_outline = {
  --
  --     },
  --   },
  -- }

  t.load_extension("ctags_outline")
end

return {
  "fcying/telescope-ctags-outline.nvim",
  keys = keys,
}
