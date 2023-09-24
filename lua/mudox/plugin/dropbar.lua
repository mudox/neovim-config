local function opts()
  local symbols = vim.tbl_deep_extend("force", require("mudox.ui").icons.kind, {
    File = "󰈔 ",
    Folder = "",
    Terminal = " ",
  })

  return {
    icons = {
      kinds = {
        symbols = symbols,
      },
      ui = {
        bar = {
          separator = "  ",
          extends = "…",
        },
      },
    },
    sources = {
      terminal = {
        -- see: https://github.com/Bekaboo/dropbar.nvim#terminal
        name = function(buf)
          local name = vim.api.nvim_buf_get_name(buf)
          -- the second result val is the terminal object
          require("toggleterm")
          local term = select(2, require("toggleterm.terminal").identify(name))
          if term then
            return term.display_name or term.name
          else
            return name
          end
        end,
      },
    },
  }
end

return {
  "Bekaboo/dropbar.nvim",
  event = { "BufRead", "BufNewFile", "TermOpen" },
  keys = {
    {
      "<M-.>",
      function()
        require("dropbar.api").pick()
      end,
      desc = "Enter Dropbar Pick Mode",
    },
  },
  opts = opts,
}
