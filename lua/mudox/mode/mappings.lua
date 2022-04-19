-- vim: fdm=marker fmr=〈,〉

vim.g.mapleader = ","

-- Keymap helpers 〈
---@diagnostic disable: unused-local
local k = require("mudox.keymap")

local nmap = k.nmap
local nnop = k.nnop
local ncmd = k.ncmd

local imap = k.imap
local icmd = k.icmd

local vmap = k.vmap

local cmap = k.cmap
---@diagnostic enable: unused-local
-- 〉

-- Normal mode mappings 〈

-- sensible `n, N`
nmap("n", '"Nn"[v:searchforward]', { expr = true })
nmap("N", '"Nn"[v:searchforward]', { expr = true })

-- quick save file
ncmd("<C-s>", "update")
icmd("<C-s>", "update")

-- sensible `j, k`
nmap("j", "gj")
nmap("k", "gk")
nnop("gj")
nnop("gk")

-- `option-J,K,H,L` to jump among tabs
ncmd("L", "bnext")
ncmd("H", "bNext")
nmap("<M-l>", "gt")
nmap("<M-h>", "gT")

-- `q` triggers macro recording too easily
nmap("\\q", "q")
nnop("q")

-- `Q` triggers Ex mode too easily
nnop("Q")

-- sensible `zi`
nmap("zi", "zizz")

-- command history
-- `nvim_set_keymap` fails to handle `noremap` option
cmap("<C-p>", "<Up>", { remap = true })

-- search
nmap("n", "nzvzz", { remap = true })
nmap("N", "Nzvzz", { remap = true })

-- open fold
nmap("zj", "zjzx", { remap = true })
nmap("zk", "zkzx", { remap = true })
nmap("g;", "g;zv", { remap = true })
nmap("g,", "g,zv", { remap = true })

-- quickly close window
ncmd("<C-w><C-w>", "wincmd q")

-- quickly wipeout buffer
ncmd("<C-w>r", "call mudox#lib#wipeoutBuffer()")

-- quickfix/location list window toggle
ncmd("<M-/>l", "call mudox#lib#toggleLocList()")
ncmd("yoL", "call mudox#lib#toggleLocList()")
ncmd("<M-/>q", "call mudox#lib#toggleQuickFix()")
ncmd("yoq", "call mudox#lib#toggleQuickFix()")

-- 〉

-- Insert mode mappings 〈

imap("<M-;>", "<Esc>A")

-- 〉

-- Which-key 〈
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

  -- Files
  ["f"] = { cmd("Telescope git_files"), "Git files" },
  ["c"] = { cmd("Telescope git_status"), "Git changed files" },
  ["R"] = { req("extensions.live_grep_raw.live_grep_raw()"), "Rg raw mode" },

  -- Grep
  ["g"] = { cmd("Telescope live_grep"), "Live grep" },
  ["G"] = { cmd("Telescope grep_string"), "Grep cword" },

  -- LSP & Tree-Sitter
  ["s"] = { cmd("Telescope treesitter"), "Tree-Sitter symbols" },
  ["S"] = { cmd("Telescope lsp_dynamic_workspace_symbols"), "LSP (dynamic) workspace symbols" },

  ["?"] = { cmd("Telescope diagnostics bufnr=0"), "Diagnostics" },
  ["."] = { cmd("Telescope lsp_code_actions"), "Code actions" },
  ["r"] = { cmd("Telescope lsp_references"), "LSP references" },

  -- Vim
  ["o"] = { cmd("Telescope vim_options"), "Vim options" },

  -- Aerial
  ["a"] = { cmd("Telescope aerial"), "Aerial" },

  -- Packer
  ["p"] = { req("extensions.packer.packer()"), "Packer plugins" },
  ["/"] = { req("extensions.file_browser.file_browser()"), "File browser" },

  -- Notify
  ["n"] = { cmd("Telescope notify"), "Notifications" },

  -- Project
  ["w"] = { cmd("Telescope projects"), "Project" },
}

-- 〉

-- Trouble 〈

local trouble = {
  name = "Trouble",

  ["<Space>"] = { cmd("TroubleToggle"), "Troubles toggle" },

  ["w"] = { cmd("TroubleToggle workspace_diagnostics"), "Trouble workspace diagnostics" },
  ["d"] = { cmd("TroubleToggle document_diagnostics"), "Trouble document diagnostics" },

  ["q"] = { cmd("TroubleToggle quickfix"), "Trouble quickfix" },
  ["l"] = { cmd("TroubleToggle loclist"), "Trouble loclist" },

  ["r"] = { cmd("TroubleToggle lsp_references"), "Trouble lsp references" },
}

-- 〉

-- DAP 〈

req = make_req("dap")
local dap = {
  name = "DAP",

  -- Breakpoint
  ["b"] = { req("toggle_breakpoint()"), "Toggle breakpoint" },
  ["c"] = { req("set_breakpoint(vim.fn.input('Breakpoint condition: '))"), "Add conditional breakpoint" },
  ["p"] = { req("set_breakpoint(nil, nil, vim.fn.input('Log point message: '))"), "Add log point" },
  ["e"] = { req("set_exception_breakpoints({'all'})"), "Set breakpoint for all exceptions" },
  ["X"] = { req("clear_breakpoint()"), "Clear all breakpoints" },

  -- Session control
  ["<Space>"] = { req("run_last()"), "Re-run last debug session" },
  ["."] = { req("terminate()"), "Terminate current debug session" },
  ["]"] = { req("run_to_cursor()"), "Continues execution to current currsor" },
  ["u"] = { req("up()"), "Up a stack frame" },
  ["d"] = { req("down()"), "Down a stack frame" },

  -- REPL
  [":"] = { req("repl.toggle()"), "Toggle REPL" },
}

req = make_req("dap.ui.widgets")
dap["i"] = { req("hover()"), "Hover" }

req = make_req("dapui")
dap["t"] = { req("toggle()"), "Toggle panes" }
dap["h"] = { req("toggle('sidebar')"), "Toggle sidebar" }
dap["j"] = { req("toggle('tray')"), "Toggle tray" }

req = make_req("dap-python")
dap["C"] = { req("test_class()"), "Test current class" }
dap["M"] = { req("test_method()"), "Test current method" }
dap["S"] = { req("debug_selection()"), "Debug selection" }

local telescope_dap = {
  name = "DAP",

  [":"] = { cmd("Telescope dap commands"), "DAP Commands" },
  ["c"] = { cmd("Telescope dap configurations"), "DAP configurations" },
  ["v"] = { cmd("Telescope dap variables"), "DAP variables" },
  ["f"] = { cmd("Telescope dap frames"), "DAP frames" },
  ["b"] = { cmd("Telescope dap list_breakpoints"), "DAP breakpoints" },
}

telescope.d = telescope_dap

-- 〉

-- Test 〈

local test = {
  name = "Test",

  -- Summary window
  ["l"] = { cmd("UltestSummary"), "Summary window" },
  ["L"] = { cmd("UltestSummary!"), "Summary window focused" },
  ["s"] = { cmd("UltestSummary"), "Summary window" },
  ["S"] = { cmd("UltestSummary!"), "Summary window focused" },

  -- Test
  ["<Space>"] = { cmd("UltestLast"), "Test last" },

  ["f"] = { cmd("Ultest"), "Test file" },
  ["n"] = { cmd("UltestNearest"), "Test nearest" },

  ["."] = { cmd("UltestStop"), "Stop all tests" },
  ["c"] = { cmd("UltestClear"), "Clear test results" },

  -- Debug
  ["D"] = { cmd("UltestDebug"), "Debug file" },
  ["d"] = { cmd("UltestDebugNearest"), "Test debug nearest" },
}

req = make_req("dapui")
dap["t"] = { req("toggle()"), "Toggle panes" }
dap["h"] = { req("toggle('sidebar')"), "Toggle sidebar" }
dap["j"] = { req("toggle('tray')"), "Toggle tray" }

req = make_req("dap-python")
dap["C"] = { req("test_class()"), "Test current class" }
dap["M"] = { req("test_method()"), "Test current method" }
dap["S"] = { req("debug_selection()"), "Debug selection" }

-- 〉

-- Aerial 〈

local aerial = {
  name = "Aerial",

  ["<Space>"] = { cmd("AerialToggle!"), "Toggle aerial window" },
  ["a"] = { cmd("AerialOpen"), "Open aerial window" },

  ["h"] = { cmd("AerialOpen! left"), "Left pane" },
  ["H"] = { cmd("AerialOpen left"), "Left pane focused" },
  ["l"] = { cmd("AerialOpen! right"), "Right pane" },
  ["L"] = { cmd("AerialOpen right"), "Right pane focused" },
  ["f"] = { cmd("AerialOpen float"), "Float window focused" },

  ["i"] = { cmd("AerialInfo"), "Aerial debug info" },
}

-- 〉

-- Packer 〈

local packer = {
  name = "Packer",

  ["S"] = { cmd("PackerSync"), "`PackerUpdate` then `PackerSync`" },
  ["s"] = { cmd("PackerStatus"), "Show packer status" },
  ["c"] = { cmd("PackerClean"), "Clean packer plugins" },
  ["C"] = { cmd("PackerCompile"), "Regenerate `packer_compiled` file" },
  ["I"] = { cmd("PackerInstall"), "Install plugins" },
}

-- 〉

-- Git 〈

req = make_req("gitsigns")

local gitsigns = {
  name = "Git (Fugitive, Gitsigns)",

  ["<Space>"] = { req("toggle_signs()"), "Toggle GitSigns signs" },

  -- Stage
  ["s"] = { req("stage_hunk()"), "Stage hunk" },
  ["S"] = { req("stage_buffer()"), "Stage current file" },
  ["u"] = { req("undo_stage_hunk()"), "Undo stage hunk" },
  ["D"] = { req("reset_hunk()"), "Reset (discard) hunk" },

  -- Diff
  ["d"] = { req("diffthis()"), "Diff this file" },
  ["v"] = { req("preview_hunk()"), "Preview hunk changes" },

  -- Blame
  ["b"] = { req("blame_line()"), "Blame line" },
}

-- 〉

-- LSP 〈

local lsp = {
  name = "LSP",

  ["i"] = { cmd("LspInfo"), "LSP server info" },
  ["I"] = { cmd("LspInstallInfo"), "LSP install info" },

  ["R"] = { cmd("LspRestart"), "Restart LSP server" },
  ["<Space>"] = { cmd("LspRestart"), "Restart LSP server" },
}

-- 〉

-- Second comma 〈

vim.cmd([[ command! BufOnly silent! execute "%bd|e#|bd#" ]])

local second_comma = {
  name = "Misc",

  ["e"] = { cmd("edit"), "Run command `:edit!`" },
  ["s"] = { cmd("lua _mdx_remerge_my_luasnip_snippets()"), "Reload my LuaSnip snippets" },
  ["o"] = { cmd("BufOnly"), "Close other buffers" },
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
  x = trouble,
  l = lsp,

  [","] = second_comma,
}

-- 〉

-- Leader: space 〈

local space = {
  name = "The space key mappings",

  r = { cmd("Telescope oldfiles"), "File history" },
  o = { cmd("NeorgStart"), "Start Neorg" },
}

--〉

-- vim.cmd([[PackerLoad which-key.nvim legendary.nvim]])
vim.cmd([[PackerLoad which-key.nvim]])
local wk = require("which-key")

wk.register {
  ["<Space>"] = space,
  [","] = comma,
}

-- 〉
