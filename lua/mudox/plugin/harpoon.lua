-- stylua: ignore
local function hp() return require("harpoon") end

local function keys()
  local function add_file()
    hp():list():add()
    print(("Add %s to harpoon"):format(vim.fn.expand("%:t")))
  end

  -- stylua: ignore
  local k = {
    { "<leader>ea", add_file,                                               desc = "[Harpoon] Add file",      },

    { "<leader>eh", function () hp().ui:toggle_quick_menu(hp():list()) end, desc = "[Harpoon] Menu",          },

    { "<C-S-l>",    function () hp():list():next() end,                     desc = "[Harpoon] Next file",     },
    { "<C-S-h>",    function () hp():list():prev() end,                     desc = "[Harpoon] Previous file", },
  }

  for i = 1, 5 do
    -- stylua: ignore
    table.insert(k, { "<leader>" .. i, function () hp():list():select(i) end, desc = "[Harpoon] Goto file " .. i })
  end

  return k
end

local opts = {
  save_on_toggle = true,
  sync_on_ui_close = true,
}

local function config()
  hp().setup(opts)

  hp():extend {
    UI_CREATE = function(cx)
      vim.keymap.set("n", "<C-v>", function()
        hp().ui:select_menu_item { vsplit = true }
      end, { buffer = cx.bufnr })

      vim.keymap.set("n", "<C-s>", function()
        hp().ui:select_menu_item { split = true }
      end, { buffer = cx.bufnr })

      vim.keymap.set("n", "<C-t>", function()
        hp().ui:select_menu_item { tabedit = true }
      end, { buffer = cx.bufnr })
    end,
  }
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = "plenary.nvim",
  keys = keys(),
  -- config = config,
}
