local function opts()
  local symbols = vim.tbl_deep_extend("force", I.kind, {
    File = "󰈔 ",
    Folder = "",
    Terminal = " ",
  })

  return {
    icons = {
      kinds = {
        symbols = symbols,
      },
      ui = {
        bar = {
          separator = " " .. I.chevron.right .. " ",
          extends = "…",
        },
      },
    },
    sources = {
      -- path = {
      --   relative_to = function()
      --     -- always use global `cwd`
      --     return vim.fn.getcwd()
      --   end,
      -- },
      path = {
        relative_to = function(buf, win)
          -- Show full path in oil or fugitive buffers
          local bufname = vim.api.nvim_buf_get_name(buf)
          if vim.startswith(bufname, "oil://") or vim.startswith(bufname, "fugitive://") then
            local root = bufname:gsub("^%S+://", "", 1)
            while root and root ~= vim.fs.dirname(root) do
              root = vim.fs.dirname(root)
            end
            return root
          end

          local ok, cwd = pcall(vim.fn.getcwd, win)
          return ok and cwd or vim.fn.getcwd()
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

      enable = function(buf, win, _)
        if
          not vim.api.nvim_buf_is_valid(buf)
          or not vim.api.nvim_win_is_valid(win)
          or vim.fn.win_gettype(win) ~= ""
          or vim.wo[win].winbar ~= ""
          or vim.bo[buf].ft == "help"
        then
          return false
        end

        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
        if stat and stat.size > 1024 * 1024 then
          return false
        end

        return vim.bo[buf].bt == "terminal"
          or vim.bo[buf].ft == "markdown"
          or pcall(vim.treesitter.get_parser, buf)
          or not vim.tbl_isempty(vim.lsp.get_clients {
            bufnr = buf,
            method = "textDocument/documentSymbol",
          })
      end,
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
    -- { "<M-.>",      function() require("dropbar.api").pick() end, desc = "[Dropbar] Open menu", },
    { "<leader>fb", function() require("dropbar.api").pick() end, desc = "[Dropbar] Open menu", },
}

return {
  "Bekaboo/dropbar.nvim",
  event = "VeryLazy",
  keys = keys,
  opts = opts,
}
