local function init()
  vim.opt.runtimepath:append("~/.local/share/nvim/lazy/switch.vim")

  vim.g.switch_custom_definitions = {
    vim.fn["switch#NormalizedCaseWords"] { "on", "off" },
    vim.fn["switch#NormalizedCaseWords"] { "start", "end" },
  }
end

return {
  "AndrewRadev/switch.vim",
  init = init,
  keys = {
    { "-", "<Plug>(Switch)", remap = true, desc = "Switch" },
    { "+", "<Plug>(SwitchReverse)", remap = true, desc = "Switch Reverse" },
  },
}
