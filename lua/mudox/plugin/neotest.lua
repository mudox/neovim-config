local dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "antoinemadec/FixCursorHold.nvim",

  "vim-test/vim-test",

  "nvim-neotest/neotest-jest",
  "nvim-neotest/neotest-plenary",
  "nvim-neotest/neotest-python",
  "rouge8/neotest-rust",

  "nvim-neotest/neotest-vim-test", -- for those do not have adapters
}

local function opts()
  return {
    adapters = {
      require("neotest-jest"),
      require("neotest-plenary"),
      require("neotest-python"),
      require("neotest-rust"),
    },
    floating = {
      border = require("mudox.ui.icons").border.corner,
    },
  }
end

local function m()
  return require("neotest")
end

-- stylua: ignore start
-- test / debug
local function test_nearest()          m().run.run() end
local function debug_nearest()         m().run.run({ strategy = "dap" }) end
local function test_file()             m().run.run(vim.fn.expand("%")) end
local function debug_file()            m().run.run({ vim.fn.expand("%"), strategy = "dap" }) end
local function test_last()             m().run.run_last() end
local function debug_last()            m().run.run_last({ strategy = "dap" }) end

-- stop
local function stop_nearest()          m().run.stop() end
local function attach_to_nearest()     m().run.attach() end

-- ui
local function toggle_summary()        m().summary.toggle() end
local function open_summary()          m().summary.open() end
local function open_output()           m().output.open() end
local function open_output_panel()     m().output_panel.toggle() end

-- watch
local function watch_file()            m().watch.toggle(vim.fn.expand("%")) end

-- jump
local function goto_next_test()        m().jump.next() end
local function goto_prev_test()        m().jump.prev() end

local function goto_next_failed_test() m().jump.next({ status = "failed" }) end
local function goto_prev_failed_test() m().jump.prev({ status = "failed" }) end

local keys = {
  -- run
  { "<leader>cc",       test_nearest,          desc = "[Neotest] Test nearest"},
  { "<leader>cC",       debug_nearest,         desc = "[Neotest] Debug nearest"},
  { "<leader>cf",       test_file,             desc = "[Neotest] Test file"},
  { "<leader>cF",       debug_file,            desc = "[Neotest] Debug file"},

  -- run                last
  { "<leader>c.",       test_last,             desc = "[Neotest] Last"},
  { "<leader>c>",       debug_last,            desc = "[Neotest] Last with debugger"},

  -- stop
  { "<leader>c<Bs>",    stop_nearest,          desc = "[Neotest] Stop nearest"},

  -- debug
  { "<leader>ca",       attach_to_nearest,     desc = "[Neotest] Attach to nearest"},

  -- watch
  { "<leader>cw",       watch_file,            desc = "[Neotest] Watch file"},

  -- ui
  { "<leader>c<Space>", toggle_summary,        desc = "[Neotest] Toggle summary"},
  { "<leader>cs",       open_summary,          desc = "[Neotest] Open summary"},
  { "<leader>cv",       open_output,           desc = "[Neotest] Show output"},
  { "<leader>cV",       open_output_panel,     desc = "[Neotest] Show output panel"},

  -- jump
  { "]t",               goto_next_test,        desc = "[Neotest] Goto next test"},
  { "[t",               goto_prev_test,        desc = "[Neotest] Goto previous test"},
  { "]T",               goto_next_failed_test, desc = "[Neotest] Goto next failed test"},
  { "[T",               goto_prev_failed_test, desc = "[Neotest] Goto previous failed test"},
}
-- stylua: ignore end

return {
  "nvim-neotest/neotest",
  dependencies = dependencies,
  opts = opts,
  keys = keys,
}
