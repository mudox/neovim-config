local function opts()
  local symbols = vim.tbl_deep_extend("force", require("mudox.ui.icon").kind, {
    File = "󰈔 ",
    Folder = " ",
    Terminal = " ",
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
      path = {
        relative_to = function()
          -- always use global `cwd`
          return vim.fn.getcwd()
        end,
      },
      terminal = {
        -- see: https://github.com/Bekaboo/dropbar.nvim#terminal
        name = function(buf)
          local name = vim.api.nvim_buf_get_name(buf)
          -- the second result val is the terminal object
          require("toggleterm")
          local term = select(2, require("toggleterm.terminal").identify(name))
          if term then
            local s = term.display_name or term.name

            if s:match("#toggleterm#%d") then
              return "ToggleTerm #" .. s:sub(-1)
            end

            return s
          else
            return name
          end
        end,
      },
    },
    bar = {
      padding = { left = 0, right = 0 },
    },
    menu = {
      keymaps = {
        q = "<Cmd>close<Cr>",
      },
    },
  }
end

-- stylua: ignore
local keys = {
    { "<M-.>",   function() require("dropbar.api").pick() end,                desc = "[Dropbar] Open menu",      },
    -- { "<C-S-.>", function() require("dropbar.api").select_next_context() end, desc = "[Dropbar] Reveal context", },
}

return {
  "Bekaboo/dropbar.nvim",
  event = { "BufRead", "BufNewFile", "TermOpen" },
  keys = keys,
  opts = opts,
}
