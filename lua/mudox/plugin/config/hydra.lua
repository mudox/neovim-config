-- vim: fdm=marker fmr=〈,〉

local Hydra = require("hydra")
local load = require("packer").loader

local hint, heads

-- Side Scroll 〈

Hydra {
  name = "Side scroll",
  mode = "n",
  body = "z",
  heads = {
    { "h", "5zh" },
    { "l", "5zl", { desc = "←/→" } },
    { "H", "zH" },
    { "L", "zL", { desc = "half screen ←/→" } },
  },
}

-- 〉

-- GitSigns 〈

load("gitsigns.nvim")
local gitsigns = require("gitsigns")

hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo stage hunk   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Fugitive           _q_: exit
]]

heads = {
  {
    "J",
    function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gitsigns.next_hunk()
      end)
      return "<Ignore>"
    end,
    { expr = true },
  },
  {
    "K",
    function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gitsigns.prev_hunk()
      end)
      return "<Ignore>"
    end,
    { expr = true },
  },
  { "s", ":Gitsigns stage_hunk<CR>", { silent = true } },
  { "u", gitsigns.undo_stage_hunk },
  { "S", gitsigns.stage_buffer },
  { "p", gitsigns.preview_hunk },
  { "d", gitsigns.toggle_deleted, { nowait = true } },
  { "b", gitsigns.blame_line },
  {
    "B",
    function()
      gitsigns.blame_line { full = true }
    end,
  },
  { "/", gitsigns.show, { exit = true } }, -- show the base of the file
  { "<Enter>", "<Cmd>Git<CR>", { exit = true } },
  { "q", nil, { exit = true, nowait = true } },
}

Hydra {
  hint = hint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      position = "bottom",
      border = "rounded",
    },
    on_enter = function()
      vim.bo.modifiable = false
      gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
    end,
    on_exit = function()
      gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_deleted(false)
      vim.cmd("echo") -- clear the echo area
    end,
  },
  mode = { "n", "x" },
  body = ",,g",
  heads = heads,
}

-- 〉

-- Window & Buffer 〈

load("winshift.nvim")

hint = [[
 ^^^^^^     Move     ^^^^^^   ^^     Split         ^^^^    Size
 ^^^^^^--------------^^^^^^   ^^---------------    ^^^^------------- 
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    _s_: horizontally    _+_ _-_: height
 _h_ ^ ^ _l_   _H_ ^ ^ _L_    _v_: vertically      _>_ _<_: width
 ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^    _x_: close           ^ _=_ ^: equalize
 focus^^^^^^   window^^^^^^
      _b_: choose buffer   ^ ^ ^ ^  _<Esc>_ _q_: exit
]]

heads = {
  -- Move focus
  { "h", "<C-w>h" },
  { "j", "<C-w>j" },
  { "k", "<C-w>k" },
  { "l", "<C-w>l" },
  -- Move window
  { "H", "<Cmd>WinShift left<CR>" },
  { "J", "<Cmd>WinShift down<CR>" },
  { "K", "<Cmd>WinShift up<CR>" },
  { "L", "<Cmd>WinShift right<CR>" },
  -- Split
  { "s", "<C-w>s" },
  { "v", "<C-w>v" },
  { "x", "<Cmd>try | close | catch | endtry<CR>", { desc = "close window" } },
  -- Size
  { "+", "<C-w>+", { desc = "increase height" } },
  { "-", "<C-w>-", { desc = "decrease height" } },
  { ">", "2<C-w>>", { desc = "increase width" } },
  { "<", "2<C-w><", { desc = "decrease width" } },
  { "=", "<C-w>=", { desc = "equalize" } },
  --
  { "b", "<Cmd>ReachOpen buffers<CR>", { exit = true, desc = "choose buffer" } },
  { "<Esc>", nil, { exit = true } },
  { "q", nil, { exit = true } },
}

Hydra {
  hint = hint,
  config = {
    -- timeout = 4000,
    hint = {
      border = "rounded",
    },
  },
  mode = "n",
  body = "<C-w>",
  heads = heads,
}

-- 〉
