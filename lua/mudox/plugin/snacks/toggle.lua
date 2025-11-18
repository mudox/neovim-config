local quickfix = {
  get = function()
    for _, win in pairs(vim.fn.getwininfo()) do
      if win["quickfix"] == 1 then
        return true
      end
    end
    return false
  end,
  set = function(s)
    if s then
      vim.cmd.copen()
    else
      vim.cmd.cclose()
    end
  end,
}

local diagnostic = {
  get = function()
    return require("tiny-inline-diagnostic.diagnostic").user_toggle_state
  end,
  set = function(s)
    require("tiny-inline-diagnostic")[s and "enable" or "disable"]()
    pcall(vim.diagnostic[s and "enabled" or "disable"])
  end,
}

-- stylua: ignore
local function _init()
  -- for parameter `key`
  -- + use lowercase for commonly used ones
  -- + use uppercase for less commonly used ones
  -- + use <C-X> for less rarely used ones
  local function k(key) return K.leader.toggle .. key end

  local t = Snacks.toggle
  local o = t.option

  o("spell",    { name = "Spelling"         }):map(k"s")
  o("wrap",     { name = "Wrap"             }):map(k"w")
  o("list",     { name = "List Mode"        }):map(k"<C-l>")
  o("hlsearch", { name = "Highlight Search" }):map(k"h")

  -- lsp virtual lines
  t.new({
    id = "lsp_virtual_lines",
    name = "LSP Virtual Lines",
    get = function() return vim.lsp.config.virtual_lines end,
    set = function(state) vim.lsp.config { virtual_lines = state } end,
  }):map(k"L")

  -- treesitter & lsp
  t.treesitter():map(k"T")
  -- t.diagnostics():map(k"d")
  t.inlay_hints():map(k"H")

  -- line numbers
  t.line_number():map(k"n")
  o("relativenumber", { name = "Relative Number" }):map(k"N")

  -- conceal level
  local opts = { name = "Conceal", off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
  o("conceallevel", opts):map(k"C")

  -- gitsigns
  t.new({
    id = "gitsigns",
    name = "GitSigns",
    get = function() return require("gitsigns.config").config.signcolumn end,
    set = function() require("gitsigns").toggle_signs() end,
  }):map(k"g")

  -- highlight-colors
  t.new({
    id = "highlight_colors",
    name = "Highlight Colors",
    get = function()
      local id  = vim.api.nvim_get_namespaces()["nvim-highlight-colors"]
      return id and #vim.api.nvim_buf_get_extmarks(0, id, 0, -1, {}) > 0
    end,
    set = function() require("nvim-highlight-colors").toggle() end,
  }):map(k"c")

  -- indent-blank-line
  -- t.new({
  --   id = "indent_blank_line",
  --   name = "Indent Blank Line",
  --   get = function() return require("ibl.config").get_config(-1).enabled end,
  --   set = function() vim.cmd.IBLToggle() end,
  -- }):map(k"i")

  -- conform locally
  t.new({
    id = "conform_locally",
    name = "Conform Locally",
    get = function() return not vim.b.disable_autoformat end,
    set = function() vim.b.disable_autoformat = not vim.b.disable_autoformat end,
  }):map(k"f")

  -- conform globally
  t.new({
    id = "conform_globally",
    name = "Conform Globally",
    get = function() return not vim.g.disable_autoformat end,
    set = function() vim.g.disable_autoformat = not vim.g.disable_autoformat end,
  }):map(k"F")

  -- quickfix window
  -- TODO: move under <leader>w
  t.new({
    id = "quickfix",
    name = "Quickfix",
    get = quickfix.get,
    set = quickfix.set,
  }):map(k"q")

  -- diagnostic
  -- vim.diagnostic + tiny-inline-diagnostic
  t.new({
    id = "diagnostic",
    name = "Diagnostic",
    get = diagnostic.get,
    set = diagnostic.set,
  }):map(k"d")

  -- profiler
  t.profiler():map(k"p")
  -- profiler highlights
  t.profiler_highlights():map(k"P")
end

return {
  opts = {
    which_key = true,
    notify = function(state, opts)
      print(("%s <- %s"):format(state and "on" or "off", opts.name))
    end,
    -- stylua: ignore
    wk_desc = {
      enabled  = "󰝥  ",
      disabled = "󰝦  ",
    },
  },
  init = function()
    On.very_lazy(_init)
  end,
}
