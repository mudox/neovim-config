local opts = {
  ft = function()
    if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
      return vim.bo.filetype
    end
    return "lua"
  end,

  win_by_ft = {
    javascript = {
      keys = {
        source = {
          "<Cr>",
          function(self)
            local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
            print(name)
          end,
          desc = "Run buffer by node",
        },
      },
    },
  },
}

return {
  opts = opts,
  -- stylua: ignore
  keys = {
    { K.p"e=", function() Snacks.scratch() end,          desc = "Scratch buffer"          },
    { K.p"s=", function() Snacks.scratch.select() end,   desc = "Select scratch buffer"   },
  },
}
