local function init()
  local gid = vim.api.nvim_create_augroup("mdx_rest_mapping", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "http",
    group = gid,
    desc = "Add local rest.nvim keymaps for http filetype",
    callback = function(event)
      local nplug = require("mudox.util.keymap").nplug

      -- stylua: ignore start
      local keymaps = {
        {"<leader>rr",       "RestNvim",        "Send Current HTTP Request"},
        {"<leader>rp",       "RestNvimPreview", "Preview Request in cURL Form"},
        {"<leader>r<Space>", "RestNvimLast",    "Re-send Last HTTP Request"},
      }
      -- stylua: ignore end
      for _, k in ipairs(keymaps) do
        nplug(k[1], k[2], { desc = k[3] })
      end
    end,
  })
end

return {
  "rest-nvim/rest.nvim",
  ft = "http",
  init = init,
  opts = true,
}
