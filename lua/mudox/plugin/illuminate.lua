-- local denylist = {
--   "aerial",
--   "aerial-nav",
--   "DiffviewFiles",
--   "dirvish",
--   "DressingInput",
--   "dropbar_menu",
--   "fugitive",
--   "harpoon",
--   "help",
--   "lazy",
--   "man",
--   "mason",
--   "NvimTree",
--   "oil",
--   "OverseerForm",
--   "OverseerList",
--   "qf",
--   "TelescopePrompt",
--   "toggleterm",
--   "alpha",
-- }

local allowlist = {
  "c",
  "cpp",
  "javascript",
  "lua",
  "python",
  "rust",
  "swift",
  "typescript",
  "lua",
}

local opts = {
  delay = 200,
  filetypes_denylist = {}, -- for `allowlist` to take effect
  filetypes_allowlist = allowlist,
}

local function config()
  require("illuminate").configure(opts)

  local function map(key, dir)
    vim.keymap.set("n", key, function()
      require("illuminate")["goto_" .. dir .. "_reference"](true)
    end)
  end

  map("]]", "next")
  map("[[", "prev")

  -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      local buffer = vim.api.nvim_get_current_buf()
      map("]]", "next", buffer)
      map("[[", "prev", buffer)
    end,
  })
end

return {
  "RRethy/vim-illuminate",
  event = { "BufRead", "BufNewFile" },
  keys = {
    { "]]", desc = "Goto next reference" },
    { "[[", desc = "Goto prev reference" },
  },
  config = config,
}
