local function opts()
  local symbols = vim.tbl_deep_extend("force", I.kind, {
    -- File = "󰈔 ",
    File = "󰈤 ",
    Folder = "",
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
    },
    bar = {
      padding = { left = 0, right = 0 },

      enable = function(buf, win, _)
        if
          not vim.api.nvim_buf_is_valid(buf)
          or not vim.api.nvim_win_is_valid(win)
          or vim.fn.win_gettype(win) ~= "" -- spacial window
          or vim.wo[win].winbar ~= "" -- winbar already set
          -- or vim.bo[buf].ft == "help"
        then
          return false
        end

        -- file size
        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
        if stat and stat.size > 1024 * 1024 then
          return false
        end

        return vim.bo[buf].ft == "markdown"
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
    { "<M-.>",      function() require("dropbar.api").pick() end, desc = "[Dropbar] Open menu", },
    { K.p"fb", function() require("dropbar.api").pick() end, desc = "[Dropbar] Open menu", },
}

return {
  "Bekaboo/dropbar.nvim",
  event = "VeryLazy",
  keys = keys,
  opts = opts,
}
