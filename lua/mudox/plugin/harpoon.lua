local function mark()
  return require("harpoon.mark")
end

local function ui()
  return require("harpoon.ui")
end

local function add_file()
  mark().add_file()
  print(("Add %s to harpoon"):format(vim.fn.expand("%:t")))
end

-- stylua: ignore
local keys = {
  { "a",       add_file,                                 "Add file",      },

  { "<Space>", function () ui().toggle_quick_menu() end, "Menu",          },
  { "M",       function () ui().toggle_quick_menu() end, "Menu",          k =  "l", },

  { "<C-S-l>", function () ui().nav_next() end,          "Next file",     k =  "l", },
  { "<C-S-h>", function () ui().nav_prev() end,          "Previous file", k =  "l", },
}

keys = K.lazy_keys(keys, {
  key_prefix = "<leader>e",
  desc_prefix = "Harpoon",
})

for i = 1, 9 do
  -- stylua: ignore
  table.insert(keys, { "<leader>" .. i, function () ui().nav_file(i) end, desc = "[Harpoon] Goto file " .. i })
end

local opts = {
  enter_on_sendcmd = true,
  menu = { width = 80 },
}

return {
  "ThePrimeagen/harpoon",
  dependencies = "plenary.nvim",
  keys = keys,
  opts = opts,
}
