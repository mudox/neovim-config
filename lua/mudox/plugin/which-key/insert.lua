local function end_with(c, nl)
  nl = nl == nil and true
  return function()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_get_current_line()
    local newline = line:gsub("%s+$", "")
    if newline:sub(-1) ~= c then
      newline = newline .. c
    end
    if nl then
      local indent = line:match("^%s+") or ""
      vim.api.nvim_buf_set_lines(0, row - 1, row, false, { newline, indent })
      vim.api.nvim_win_set_cursor(0, { row + 1, indent:len() })
    else
      vim.api.nvim_buf_set_lines(0, row - 1, row, false, { newline })
      vim.api.nvim_win_set_cursor(0, { row, newline:len() })
    end
  end
end

-- stylua: ignore
local function p(k) return K.leader.i_primary .. k end

-- stylua: ignore
return {
  mode = "i",

  { "<C-k>", group = "insert leader" },

  { p"<C-;>",  "<C-k>",              desc = "insert digraph"  },

  { "<M-j>",   "<C-o>o",             desc = "new line below"  },
  { "<M-k>",   "<C-o>O",             desc = "new line above"  },

  { "<M-;>",   end_with(";", false), desc = "end with ;"      },
  { "<M-,>",   end_with(",", false), desc = "end with ,"      },
}
