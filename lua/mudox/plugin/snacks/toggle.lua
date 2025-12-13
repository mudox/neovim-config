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

-- stylua: ignore
local function _init()
  -- for parameter `key`
  -- + use lowercase for commonly used ones
  -- + use uppercase for less commonly used ones
  -- + use <C-X> for less rarely used ones
  local function k(key) return K.leader.toggle .. key end

  local t = Snacks.toggle
  local o = t.option

  o("spell",    { name = "spelling"         }):map(k"s")
  o("wrap",     { name = "wrap"             }):map(k"w")
  o("list",     { name = "list mode"        }):map(k"<C-l>")
  o("hlsearch", { name = "highlight search" }):map(k"h")

  -- lsp virtual lines
  t.new({
    id = "lsp_virtual_lines",
    name = "lsp virtual lines",
    get = function() return vim.lsp.config.virtual_lines end,
    set = function(state) vim.lsp.config { virtual_lines = state } end,
  }):map(k"L")

  t.treesitter():map(k"T")
  t.diagnostics():map(k"d")
  t.inlay_hints():map(k"H")

  -- line numbers
  o("number", { name = "line number" }):map(k"n")
  o("relativenumber", { name = "relative number" }):map(k"N")

  -- conceal level
  local opts = { name = "conceal", off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
  o("conceallevel", opts):map(k"<C-c>")

  -- gitsigns
  t.new({
    id = "gitsigns",
    name = "gitsigns",
    get = function() return require("gitsigns.config").config.signcolumn end,
    set = function() require("gitsigns").toggle_signs() end,
  }):map(k"g")

  -- lsp document colors
  t.new({
    id = "lsp_document_colors",
    name = "lsp document colors",
    get = function()
      return vim.lsp.document_color.is_enabled()
    end,
    set = function(b) vim.lsp.document_color.enable(b, 0, { style = " " }) end,
  }):map(k"c")

  -- nvim-highlight-colors
  t.new({
    id = "highlight_colors",
    name = "highlight colors",
    get = function()
      local id  = vim.api.nvim_get_namespaces()["nvim-highlight-colors"]
      return id and #vim.api.nvim_buf_get_extmarks(0, id, 0, -1, {}) > 0
    end,
    set = function() require("nvim-highlight-colors").toggle() end,
  }):map(k"C")

  -- conform locally
  t.new({
    id = "conform_locally",
    name = "conform locally",
    get = function() return not vim.b.disable_autoformat end,
    set = function() vim.b.disable_autoformat = not vim.b.disable_autoformat end,
  }):map(k"f")

  -- conform globally
  t.new({
    id = "conform_globally",
    name = "conform globally",
    get = function() return not vim.g.disable_autoformat end,
    set = function() vim.g.disable_autoformat = not vim.g.disable_autoformat end,
  }):map(k"F")

  -- quickfix window
  -- TODO: move under <leader>w
  t.new({
    id = "quickfix",
    name = "quickfix",
    get = quickfix.get,
    set = quickfix.set,
  }):map(k"q")

  -- diagnostic
  local diagnostic = {
    get = function()
      return require("tiny-inline-diagnostic.state").user_toggle_state
    end,
    set = function(s)
      require("tiny-inline-diagnostic")[s and "enable" or "disable"]()
      -- pcall(vim.diagnostic[s and "enabled" or "disable"])
    end,
  }
  t.new({
    id = "tiny inline diagnostic",
    name = "inline diagnostic",
    get = diagnostic.get,
    set = diagnostic.set,
  }):map(k"D")

  -- snacks profiler
  t.profiler():map(k"p")
  -- snacks profiler highlights
  t.profiler_highlights():map(k"<C-p>")

  -- blink.indent
  -- t.new({
  --   id = "blink_indent",
  --   name = "indent guidelines",
  --   get = function() return require("blink.indent").is_enabled({ bufnr = 0 }) end,
  --   set = function(b) require("blink.indent").enable(b, { bufnr = 0 }) end,
  -- }):map(k"i")

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
    On.VeryLazy(_init)
  end,
}
