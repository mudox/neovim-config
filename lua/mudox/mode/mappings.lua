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
ncmd("yoL", "call mudox#lib#toggleLocList()")
ncmd("yoq", "call mudox#lib#toggleQuickFix()")

vim.cmd([[nmap <Space>s <Esc><Esc>:%s/]])

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

  -- Vim
  ["h"] = { cmd("Telescope help_tags"), "Vim help" },
  ["o"] = { cmd("Telescope vim_options"), "Vim options" },

  -- Files
  ["c"] = { cmd("Telescope git_status"), "Git changed files" },
  ["R"] = { req("extensions.live_grep_raw.live_grep_raw()"), "Rg raw mode" },

  -- Grep
  ["G"] = { cmd("Telescope grep_string"), "Grep cword" },

  -- LSP & Tree-Sitter
  ["s"] = { cmd("Telescope treesitter"), "Tree-Sitter symbols" },
  ["S"] = { cmd("Telescope lsp_dynamic_workspace_symbols"), "LSP (dynamic) workspace symbols" },

  ["?"] = { cmd("Telescope diagnostics bufnr=0"), "Diagnostics" },
  ["."] = { cmd("Telescope lsp_code_actions"), "Code actions" },
  ["r"] = { cmd("Telescope lsp_references"), "LSP references" },

  -- Aerial
  ["a"] = { cmd("Telescope aerial"), "Aerial" },

  -- Packer
  ["p"] = { req("extensions.packer.packer()"), "Packer plugins" },

  -- File browser
  ["/"] = { req("extensions.file_browser.file_browser()"), "File browser" },

  -- Notify
  ["n"] = { cmd("Telescope notify"), "Notifications" },

  -- Project
  ["w"] = { cmd("Telescope projects"), "Project" },

  -- Todo
  ["t"] = { cmd("TodoTelescope"), "Todo list" },

  -- Neoclip
  ["v"] = { cmd("Telescope neoclip"), "Neoclip" },

  -- Heading
  ["l"] = { cmd("Telescope heading"), "Heading" },
}

-- 〉

-- Trouble 〈

local trouble = {
  name = "Trouble",

  ["<Space>"] = { cmd("TroubleToggle"), "Toggle" },
  ["R"] = { cmd("TroubleRefresh"), "Refresh" },

  ["d"] = { cmd("Trouble document_diagnostics"), "Document diagnostics" },
  ["D"] = { cmd("Trouble workspace_diagnostics"), "Workspace diagnostics" },

  ["q"] = { cmd("Trouble quickfix"), "Quickfix" },
  ["l"] = { cmd("Trouble loclist"), "Loclist" },

  ["r"] = { cmd("Trouble lsp_references"), "LSP references" },

  ["t"] = { cmd("TodoTrouble"), "Trouble todo" },
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

  ["A"] = { cmd("AerialOpenAll"), "Open aerial window for all visible windows" },
  ["c"] = { cmd("AerialClose"), "Close current aerial window" },
  ["C"] = { cmd("AerialCloseAll"), "Close all visible aerial windows" },
  ["o"] = { cmd("AerialCloseAllButCurrent"), "Close all but current aerial window" },

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

-- Refactoring 〈

local refactoring = {
  name = "Refactoring",

  ["b"] = { make_req("refactoring")('refactor("Extract Block")'), "Extract Block" },
  ["B"] = { make_req("refactoring")('refactor("Extract Block To File")'), "Extract Block To File" },

  ["i"] = { make_req("refactoring")('refactor("Inline Variable")'), "Inline Variable under cursor" },

  ["p"] = { make_req("refactoring")("debug.printf({below = false})"), "Print function call" },

  ["c"] = { make_req("refactoring")("debug.cleanup({})"), "Cleanup debug print lines" },

  -- Trev-J
  ["j"] = { make_req("trevj")("format_at_cursor()"), "Reverse J" },
}

-- 〉

-- Second comma 〈

vim.cmd([[ command! BufOnly silent! execute "%bd|e#|bd#" ]])

local second_comma = {
  name = "Misc",

  ["e"] = { cmd("edit"), "Run command `:edit!`" },
  ["s"] = { cmd("lua _mdx_remerge_my_luasnip_snippets()"), "Reload my LuaSnip snippets" },
  ["o"] = { cmd("BufOnly"), "Close other buffers" },

  ["w"] = {
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

  ["z"] = { cmd("NeoZoomToggle"), "Zoom window" },
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
  m = trouble,
  l = lsp,
  r = refactoring,

  [","] = second_comma,
}

-- 〉

-- Leader: space - common functions 〈

local space = {
  name = "The space key mappings",

  r = { cmd("Telescope oldfiles"), "File History" },
  g = { cmd("Git"), "Fugitive" },
  d = { cmd("DiffviewOpen"), "Diff view" },
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

  ["af"] = { cmd("Neoformat"), "Neoformat" },
  ["ef"] = { "m`gg=G``", "Format (=) entire file" },

  g = neogen,
  s = swap,
}

--〉

-- vim.cmd([[PackerLoad which-key.nvim legendary.nvim]])
vim.cmd([[PackerLoad which-key.nvim]])
local wk = require("which-key")

-- Normal mode keymaps
wk.register {
  ["t"] = telescope,
  ["<Space>"] = space,
  [","] = comma,
  ["\\"] = backslash,
}

-- Refactoring 〈

local function refactor(c)
  make_req("refactoring")(('refactor("%s")'):format(c))
end

refactoring = {
  name = "Refactoring",

  ["r"] = { make_req("refactoring")("select_refactor()"), "Refactor selection" },

  ["p"] = { make_req("refactoring")("debug.print_var({})"), "Print variable" },
}

local cmds = {
  e = "Extract Function",
  f = "Extract Function To File",
  v = "Extract Variable",
  i = "Inline Variable",
}

for key, s in pairs(cmds) do
  refactoring[key] = { refactor(s), s }
end

-- 〉

-- Visual mode keymaps
wk.register({
  r = refactoring,
}, { mode = "v" })

-- 〉
