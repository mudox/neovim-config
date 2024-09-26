-- stylua: ignore
local function hp() return require("harpoon") end

local function keys()
  local function add_file()
    hp():list():add()
    print(("Add %s to harpoon"):format(vim.fn.expand("%:t")))
  end

  -- stylua: ignore
  local k = {
    { "<leader>fa", add_file,                                               "[Harpoon] Add file",      },

    { "M",          function () hp().ui:toggle_quick_menu(hp():list()) end, "[Harpoon] Menu",          },

    { "<C-S-l>",    function () hp():list():next() end,                     "[Harpoon] Next file",     },
    { "<C-S-h>",    function () hp():list():prev() end,                     "[Harpoon] Previous file", },
  }

  for i = 1, 9 do
    -- stylua: ignore
    table.insert(k, { "<leader>" .. i, function () hp():list():select(i) end, desc = "[Harpoon] Goto file " .. i })
  end

  return k
end

local opts = {
  -- enter_on_sendcmd = true,
  -- menu = { width = 80 },
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
  config = config,
}
