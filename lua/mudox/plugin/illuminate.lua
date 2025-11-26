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
    left = function()
      require("illuminate").goto_next_reference(true)
      vim.cmd.normal { "zv", bang = true }
    end,
    right = function()
      require("illuminate").goto_prev_reference(true)
      vim.cmd.normal { "zv", bang = true }
    end,
  }

  local function setup_keymaps()
    K.nmap("]]", X.dirop.left(op))
    K.nmap("[[", X.dirop.right(op))
  end

  setup_keymaps()

  -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
  On("FileType", { callback = setup_keymaps })
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
