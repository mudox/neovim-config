return {
  "RRethy/vim-illuminate",
  event = { "BufRead", "BufNewFile" },
  opts = {
    delay = 200,
    -- filetypes_denylist = {
    --   "aerial",
    --   "aerial-nav",
    --   "DiffviewFiles",
    --   "dirvish",
    --   "dropbar_menu",
    --   "DressingInput",
    --   "fugitive",
    --   "help",
    --   "lazy",
    --   "man",
    --   "mason",
    --   "NvimTree",
    --   "qf",
    --   "TelescopePrompt",
    -- },
    filetypes_allowlist = {
      "c",
      "cpp",
      "javascript",
      "lua",
      "python",
      "rust",
      "swift",
      "typescript",
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)

    local function map(key, dir, buffer)
      vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
      end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
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
  end,
  keys = {
    { "]]", desc = "Next Reference" },
    { "[[", desc = "Prev Reference" },
  },
}
