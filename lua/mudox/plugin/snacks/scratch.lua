local opts = {
  ft = function()
    if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
      return vim.bo.filetype
    end
    return "lua"
  end,
}

return {
  opts = opts,
  -- stylua: ignore
  keys = {
    { K.p"e=", function() Snacks.scratch() end,          desc = "Scratch buffer"          },
    { K.p"s=", function() Snacks.scratch.select() end,   desc = "Select scratch buffer"   },
  },
}
