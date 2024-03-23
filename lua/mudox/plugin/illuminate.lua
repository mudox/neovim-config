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

  local op = {
    name = "illuminate",
    next = function()
      require("illuminate").goto_next_reference(true)
    end,
    prev = function()
      require("illuminate").goto_prev_reference(true)
    end,
  }

  local function setup_keymaps()
    K.nmap("]]", X.dirop.wrap(op, "next"))
    K.nmap("[[", X.dirop.wrap(op, "prev"))
  end

  setup_keymaps()

  -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
  vim.api.nvim_create_autocmd("FileType", { callback = setup_keymaps })
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
