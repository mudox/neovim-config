-- vim: fdm=marker fmr=〈,〉

local function cmd(c)
  return ("<Cmd>%s<Cr>"):format(c)
end

local function make_req(mod)
  return function(c)
    return ([[<Cmd>lua require("%s").%s<Cr>]]):format(mod, c)
  end
end

-- Telescope 〈

local req = make_req("telescope")

local telescope = {
  name = "Telescope",

  ["<Space>"] = { cmd("Telescope resume"), "Resume" },
  [":"] = {
    function()
      local opts = {
        include_extensions = true,
        preview = { hide_on_startup = true },
      }
      require("telescope.builtin").builtin(opts)
    end,
    "Telescope pickers",
  },

  -- Vim
  h = { cmd("Telescope help_tags"), "Vim help" },
  o = { cmd("Telescope vim_options"), "Vim options" },

  -- Files
  f = { cmd("Telescope find_files"), "Files" },
  c = { cmd("Telescope git_status"), "Git changed files" },
  R = { req("extensions.live_grep_args.live_grep_raw()"), "Rg raw mode" },

  -- Grep
  G = { cmd("Telescope grep_string"), "Grep cword" },

  -- LSP & Tree-Sitter
  s = { cmd("Telescope treesitter"), "Tree-Sitter symbols" },
  S = { cmd("Telescope lsp_dynamic_workspace_symbols"), "LSP (dynamic) workspace symbols" },

  ["?"] = { cmd("Telescope diagnostics bufnr=0"), "Diagnostics" },
  ["."] = { cmd("Telescope lsp_code_actions"), "Code actions" },
  r = { cmd("Telescope lsp_references"), "LSP references" },

  -- Aerial
  a = { cmd("Telescope aerial"), "Aerial" },

  -- Packer
  p = { req("extensions.packer.packer()"), "Packer plugins" },

  -- File browser
  ["/"] = { req("extensions.file_browser.file_browser()"), "File browser" },

  -- Notify
  n = { cmd("Telescope notify"), "Notifications" },

  -- Todo
  t = { cmd("TodoTelescope"), "Todo list" },

  -- Neoclip
  v = { cmd("Telescope neoclip"), "Neoclip" },

  -- Heading
  l = { cmd("Telescope heading"), "Heading" },
}

-- 〉

-- Trouble 〈

local trouble = {
  name = "Trouble",

  ["<Space>"] = { cmd("TroubleToggle"), "Toggle" },
  R = { cmd("TroubleRefresh"), "Refresh" },

  d = { cmd("Trouble document_diagnostics"), "Document diagnostics" },
  D = { cmd("Trouble workspace_diagnostics"), "Workspace diagnostics" },

  q = { cmd("Trouble quickfix"), "Quickfix" },
  l = { cmd("Trouble loclist"), "Loclist" },

  r = { cmd("Trouble lsp_references"), "LSP references" },

  t = { cmd("TodoTrouble"), "Trouble todo" },
}

-- 〉

-- DAP 〈

req = make_req("dap")
local dap = {
  name = "DAP",

  -- Breakpoint
  b = { req("toggle_breakpoint()"), "Toggle breakpoint" },
  c = { req("set_breakpoint(vim.fn.input('Breakpoint condition: '))"), "Add conditional breakpoint" },
  p = { req("set_breakpoint(nil, nil, vim.fn.input('Log point message: '))"), "Add log point" },
  e = { req("set_exception_breakpoints({'all'})"), "Set breakpoint for all exceptions" },
  X = { req("clear_breakpoint()"), "Clear all breakpoints" },

  -- Session control
  ["<Space>"] = { req("run_last()"), "Re-run last debug session" },
  ["."] = { req("terminate()"), "Terminate current debug session" },
  ["]"] = { req("run_to_cursor()"), "Continues execution to current currsor" },
  u = { req("up()"), "Up a stack frame" },
  d = { req("down()"), "Down a stack frame" },

  -- REPL
  [":"] = { req("repl.toggle()"), "Toggle REPL" },
}

req = make_req("dap.ui.widgets")
dapi = { req("hover()"), "Hover" }

req = make_req("dapui")
dapt = { req("toggle()"), "Toggle panes" }
daph = { req("toggle(1)"), "Toggle sidebar" }
dapj = { req("toggle(2)"), "Toggle tray" }

req = make_req("dap-python")
dapC = { req("test_class()"), "Test current class" }
dapM = { req("test_method()"), "Test current method" }
dapS = { req("debug_selection()"), "Debug selection" }

local telescope_dap = {
  name = "DAP",

  [":"] = { cmd("Telescope dap commands"), "DAP Commands" },
  c = { cmd("Telescope dap configurations"), "DAP configurations" },
  v = { cmd("Telescope dap variables"), "DAP variables" },
  f = { cmd("Telescope dap frames"), "DAP frames" },
  b = { cmd("Telescope dap list_breakpoints"), "DAP breakpoints" },
}

telescope.d = telescope_dap

-- 〉

-- Test 〈

local test = {
  name = "Test",

  -- Summary window
  l = { cmd("UltestSummary"), "Summary window" },
  L = { cmd("UltestSummary!"), "Summary window focused" },
  s = { cmd("UltestSummary"), "Summary window" },
  S = { cmd("UltestSummary!"), "Summary window focused" },

  -- Test
  ["<Space>"] = { cmd("UltestLast"), "Test last" },

  f = { cmd("Ultest"), "Test file" },
  n = { cmd("UltestNearest"), "Test nearest" },

  ["."] = { cmd("UltestStop"), "Stop all tests" },
  c = { cmd("UltestClear"), "Clear test results" },

  -- Debug
  D = { cmd("UltestDebug"), "Debug file" },
  d = { cmd("UltestDebugNearest"), "Test debug nearest" },
}

req = make_req("dap-python")
testC = { req("test_class()"), "Test current class" }
testM = { req("test_method()"), "Test current method" }
testS = { req("debug_selection()"), "Debug selection" }

-- 〉

-- Aerial 〈

local aerial = {
  name = "Aerial",

  ["<Space>"] = { cmd("AerialToggle!"), "Toggle aerial window" },
  a = { cmd("AerialOpen"), "Open aerial window" },

  h = { cmd("AerialOpen! left"), "Left pane" },
  H = { cmd("AerialOpen left"), "Left pane focused" },
  l = { cmd("AerialOpen! right"), "Right pane" },
  L = { cmd("AerialOpen right"), "Right pane focused" },
  f = { cmd("AerialOpen float"), "Float window focused" },

  A = { cmd("AerialOpenAll"), "Open aerial window for all visible windows" },
  c = { cmd("AerialClose"), "Close current aerial window" },
  C = { cmd("AerialCloseAll"), "Close all visible aerial windows" },
  o = { cmd("AerialCloseAllButCurrent"), "Close all but current aerial window" },

  i = { cmd("AerialInfo"), "Aerial debug info" },
}

-- 〉

-- Packer 〈

local packer = {
  name = "Packer",

  S = { cmd("PackerSync"), "`PackerUpdate` then `PackerSync`" },
  s = { cmd("PackerStatus"), "Show packer status" },
  c = { cmd("PackerClean"), "Clean packer plugins" },
  C = { cmd("PackerCompile"), "Regenerate `packer_compiled` file" },
  I = { cmd("PackerInstall"), "Install plugins" },
}

-- 〉

-- Git 〈

req = make_req("gitsigns")

local gitsigns = {
  name = "Git",

  ["<Space>"] = { req("toggle_signs()"), "Toggle GitSigns signs" },

  -- Stage
  s = { req("stage_hunk()"), "Stage hunk" },
  S = { req("stage_buffer()"), "Stage current file" },
  u = { req("undo_stage_hunk()"), "Undo stage hunk" },
  D = { req("reset_hunk()"), "Reset (discard) hunk" },

  -- Diff
  d = { req("diffthis()"), "Diff this file" },
  v = { req("preview_hunk()"), "Preview hunk changes" },

  -- Blame
  b = { req("blame_line()"), "Blame line" },
}

-- 〉

-- LSP 〈

local function toggle_lsp_lines()
  local flag = not vim.diagnostic.config().virtual_lines
  print("LSP lines has been " .. (flag and "enabled" or "disabled"))
  vim.diagnostic.config { virtual_lines = flag }
end

local lsp = {
  name = "LSP",

  i = { cmd("LspInfo"), "LSP server info" },
  I = { cmd("Mason"), "LSP install info (Mason)" },

  l = { toggle_lsp_lines, "Toggle LSP lines" },

  R = { cmd("LspRestart"), "Restart LSP server" },
  ["<Space>"] = { cmd("LspRestart"), "Restart LSP server" },
}

-- 〉

-- Refactoring 〈

local refactoring = {
  normal = {
    name = "Refactor",

    b = {
      function()
        require("refactoring").refactor("Extract Block")
      end,
      "Extract Block",
    },
    B = {
      function()
        require("refactoring").refactor("Extract Block To File")
      end,
      "Extract Block To File",
    },

    i = {
      function()
        require("refactoring").refactor("Inline Variable")
      end,
      "Inline Variable",
    },

    p = {
      function()
        require("refactoring").debug.printf { below = false }
      end,
      "Print function call",
    },
    c = {
      function()
        require("refactoring").debug.cleanup {}
      end,
      "Cleanup debug prints",
    },

    -- Trev-J
    j = {
      function()
        require("trevj").format_at_cursor()
      end,
      "Reverse J",
    },
  },

  visual = {
    name = "Refactor",

    r = {
      function()
        require("refactoring").select_refactor()
      end,
      "Refactor selection",
    },

    p = {
      function()
        require("refactoring").debug.print_var {}
      end,
      "Print variable",
    },
  },
}

-- 〉

-- Overseer 〈

local overseer = {
  name = "Over Seer",

  ["<Space>"] = { cmd("OverseerToggle"), "Toggle task list" },

  [":"] = { cmd("OverseerRun"), "Run" },
  r = { cmd("OverseerRun"), "Run" },
  c = { cmd("OverseerRunCmd"), "Run Command" },

  b = { cmd("OverseerBuilder"), "Task builder" },
}

-- 〉

-- SnipRun 〈

local sniprun = {
  normal = {
    name = "Snip Run",

    i = { cmd("SnipInfo"), "Info" },

    ["<Space>"] = { cmd("SnipRun"), "Run current line" },
    l = { cmd("SnipRun"), "Run current line" },
    x = { "<Plug>SnipRunOperator", "Run snip operator" },

    ["."] = { cmd("SnipReset"), "Stop running" },
    r = { cmd("SnipReplMemoryClean"), "Clean REPL memory" },

    c = { cmd("SnipClose"), "Clear results displaying" },
  },

  visual = {
    name = "Snip Run",

    ["<Space>"] = { cmd("SnipRun"), "Run selection" },
  },
}

-- 〉

-- Zen 〈

local zen = {
  name = "Zen Mode",

  ["<Space>"] = { cmd("TZAtaraxis"), "Zen" },

  a = { cmd("TZAtaraxis"), "Zen" },
  f = { cmd("TZFocus"), "Focus" },
  m = { cmd("TZMinimalist"), "Hide decorations" },
}

-- 〉

-- Toggle 〈

local toggle = {
  name = "Toggle / switch",

  q = { cmd("call mudox#lib#toggleQuickFix()"), "Quickfix list" },
  l = { cmd("call mudox#lib#toggleLocList()"), "Location list" },

  L = { toggle_lsp_lines, "LSP lines" },

  w = {
    function()
      vim.go.winbar = (vim.go.winbar == "") and "%=%m %t" or nil
    end,
    "Windown bar",
  },
}

-- 〉

-- Second comma 〈

vim.cmd([[ command! BufOnly silent! execute "%bd|e#|bd#" ]])

local second_comma = {
  name = "Misc",

  e = { cmd("edit"), "Run command `:edit!`" },
  s = { cmd("lua _mdx_remerge_my_luasnip_snippets()"), "Reload my LuaSnip snippets" },
  o = { cmd("BufOnly"), "Close other buffers" },

  w = {
    function()
      local function filter(ids)
        return ids
      end

      local wid = require("window-picker").pick_window {
        include_current_win = true,
        filter_func = filter,
      }
      if type(wid) == "number" then
        vim.api.nvim_set_current_win(wid)
      end
    end,
    "Switch window",
  },
}

-- Second comma 〉

-- Leader comma 〈

local comma = {
  name = "Plugin prefix",

  a = aerial,
  d = dap,
  u = test,
  -- e = emmet,
  g = gitsigns,
  p = packer,
  t = telescope,
  m = trouble,
  l = lsp,
  r = refactoring.normal,
  o = overseer,
  x = sniprun.normal,
  z = zen,

  [","] = second_comma,
}

-- 〉

-- Leader: space - common functions 〈

local space = {
  name = "The space key mappings",

  r = { cmd("Telescope oldfiles"), "File History" },
  g = { cmd("Git"), "Fugitive" },
  d = { cmd("DiffviewOpen"), "Diff view" },
  z = { cmd("TZAtaraxis"), "Zen mode" },
}

--〉

-- Leader: backslash - refactoring 〈

local swap = {
  name = "Swap",

  f = "Swap parameter forwards",
  b = "Swap parameter backwards",
}

req = make_req("neogen")
local neogen = {
  name = "Neogen",

  f = { req("generate({type='func'})"), "Annotate function" },
  c = { req("generate({type='class'})"), "Annotate class" },
  t = { req("generate({type='type'})"), "Annotate type" },
  F = { req("generate({type='file'})"), "Annotate file" },
}

local backslash = {
  name = "Refactoring",

  af = { cmd("Neoformat"), "Neoformat" },
  ef = { "m`gg=G``", "Format (=) entire file" },

  sp = { cmd("lua require('spectre').open()"), "Spectre" },
  gs = { "<Esc><Esc>:%s/", "Global substitution", silent = false },

  g = neogen,
  s = swap,
}

--〉

require("packer").loader("which-key.nvim")
local wk = require("which-key")

-- Normal mode
wk.register {
  ["<Space>"] = space,
  [","] = comma,
  ["\\"] = backslash,

  t = telescope,
  yo = toggle,
}

-- Visual mode
wk.register({
  {
    name = "Comman leader",

    r = refactoring.visual,
    x = sniprun.visual,
  },
}, { mode = "v" })
