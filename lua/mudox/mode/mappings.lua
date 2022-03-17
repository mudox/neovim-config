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

-- Overide builtin mappings 〈

-- sensible `n, N`
nmap("n", '"Nn"[v:searchforward]', { expr = true })
nmap("N", '"Nn"[v:searchforward]', { expr = true })

-- quick save file
ncmd("<C-s>", "write")
icmd("<C-s>", "write")

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
nmap("<M-k>", "q")
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

-- Which-key 〈

vim.cmd([[PackerLoad which-key.nvim]])
local wk = require("which-key")

local function cmd(c)
  return ("<Cmd>%s<Cr>"):format(c)
end

local function req(c)
  return ([[<Cmd>lua require("telescope").%s<Cr>]]):format(c)
end

-- Telescope 〈

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

local dap = {
  name = "DAP",

  ["<Space>"] = { req("require('dap').run_last()"), "Re-run last debug session" },

  ["b"] = { req("toggle_breakpoint()"), "Toggle breakpoint" },
  ["c"] = { req("set_breakpoint(vim.fn.input('Breakpoint condition: '))"), "Add conditional breakpoint" },
  ["p"] = { req("set_breakpoint(nil, nil, vim.fn.input('Log point message: '))"), "Add log point" },

  [":"] = { req("repl.open()"), "Open repl" },
}

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

-- Aerial 〈

local aerial = {
  name = "Aerial",

  ["<Space>"] = { cmd("AerialToggle"), "Toggle aerial window" },
  ["a"] = { cmd("AerialOpen"), "Open aerial window" },
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

local comma = {
  name = "Plugin prefix",

  a = aerial,
  d = dap,
  p = packer,
  t = telescope,
  x = trouble,
}

wk.register {
  [","] = comma,
}

-- 〉
