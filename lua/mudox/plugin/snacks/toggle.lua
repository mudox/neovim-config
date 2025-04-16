-- stylua: ignore
return function()
  -- for parameter `key`
  -- + use lowercase for commonly used ones
  -- + use uppercase for less commonly used ones
  -- + use <C-X> for less rarely used ones
  local function k(key) return C.key.toggle .. key end

  local t = Snacks.toggle
  local o = t.option

  o("spell",    { name = "Spelling"         }):map(k"s")
  o("wrap",     { name = "Wrap"             }):map(k"w")
  o("list",     { name = "List Mode"        }):map(k"<C-l>")
  o("hlsearch", { name = "Highlight Search" }):map(k"h")

  -- treesitter & lsp
  t.treesitter():map(k"T")
  t.diagnostics():map(k"d")
  t.inlay_hints():map(k"H")

  -- line numbers
  t.line_number():map(k"n")
  o("relativenumber", { name = "Relative Number" }):map(k"N")

  -- conceal level
  local opts = { name = "Conceal", off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
  o("conceallevel", opts):map(k"c")

  -- lsp virtual lines
  t.new({
    id = "lsp_virtual_lines",
    name = "LSP Virtual Lines",
    get = function() return vim.lsp.config.virtual_lines end,
    set = function(state) vim.lsp.config { virtual_lines = state } end,
  }):map(k"L")

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
  t.new({
    id = "indent_blank_line",
    name = "Indent Blank Line",
    get = function() return require("ibl.config").get_config(-1).enabled end,
    set = function() vim.cmd.IBLToggle() end,
  }):map(k"i")

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
end
