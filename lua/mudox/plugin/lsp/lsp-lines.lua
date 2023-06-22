return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  keys = {
    {
      "gl",
      function()
        require("lsp_lines").toggle()
      end,
      desc = "Toggle LSP Lines",
    },
  },
  config = function()
    local m = require("lsp_lines")
    m.setup()
    m.toggle()
  end,
}
