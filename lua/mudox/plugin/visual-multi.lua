local function init()
  vim.g.VM_mouse_mappings = 1

  local _k = "<leader>z"
  local function k(s)
    return _k .. s
  end
  vim.g.VM_leader = _k

  -- stylua: ignore
  vim.g.VM_maps = {
    ["Select All"]         = k"*",
    ["Add Cursor At Pos"]  = k"+",
    ["Reselect Last"]      = k".",

    ["Visual All"]         = k"*",
    ["Visual Add"]         = k"+",
    ["Visual Cursors"]     = "<Bar>",
    -- ["Visual Find"]        = k"f",
    -- ["Visual Subtract"]    = k"s",
    -- ["Visual Reduce"]      = k"r",

    -- experiment!!!
    -- ["Undo"]               = "u",
    -- ["Redo"]               = "<C-r>",

    ["Select Cursor Down"] = "<S-Down>",
    ["Select Cursor Up"]   = "<S-Up>",

    ["Switch Mode"]        = "<Space>",
    ["Toggle Mappings"]    = "<C-Space>",
  }
end

local config = function()
  vim.cmd.VMTheme("neon")

  On.user("visual_multi_start", function()
    require("illuminate").pause_buf()
    require("lualine").hide { unhide = false, place = { "statusline" } }
    vim.o.hlsearch = false
  end)

  On.user("visual_multi_exit", function()
    require("illuminate").resume_buf()
    require("lualine").hide { unhide = true, place = { "statusline" } }
  end)
end

return {
  "mg979/vim-visual-multi",
  -- dir = "~/Git/neovim-plugins/vim-visual-multi", -- HACK: switch mode key `m`
  event = "BufEnter",
  init = init,
  config = config,
}
