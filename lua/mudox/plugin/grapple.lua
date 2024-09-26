-- stylua: ignore
local keys = {
  { "<leader>eg", "<cmd>Grapple toggle<cr>",          desc = "[Grapple] Toggle" },
  { "M",          "<cmd>Grapple toggle_tags<cr>",     desc = "[Grapple] Open window" },
  { "<C-S-l>",    "<cmd>Grapple cycle_tags next<cr>", desc = "[Grapple] Next" },
  { "<C-S-h>",    "<cmd>Grapple cycle_tags prev<cr>", desc = "[Grapple] Previous" },
}

return {
  "cbochs/grapple.nvim",
  dependencies = "nvim-web-devicons",
  cmd = "Grapple",
  keys = keys,
  cond = false, -- testing harpoon2
}
