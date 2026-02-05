-- vim: fml& fdn& fdm=marker fmr=〈,〉

--- `-` prefix for plugin toggles
--- `--` prefix for nvim toggles

-- stylua: ignore
local function register_toggles()
  local function k(key) return K.leader.toggle .. key end
  local t = Snacks.toggle
  local o = t.option

  o("spell",    { name = "spelling"         }):map(k"-s")
  o("wrap",     { name = "wrap"             }):map(k"-w")
  o("list",     { name = "list mode"        }):map(k"-l")
  o("hlsearch", { name = "highlight search" }):map(k"-h")

  t.treesitter():map(k"-t")
  t.inlay_hints():map(k"-H")

  -- conceal level
  local opts = { name = "conceal", off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
  o("conceallevel", opts):map(k"-c")

  -- line number 〈

  o("relativenumber", { name = "relative number" }):map(k"-r")
  t.new({
    id = "number",
    name = "number",
    get = function()
      return vim.wo.number or vim.wo.relativenumber
    end,
    set = function(b)
      if b then
        vim.wo.number = true
      else
        vim.wo.number = false
        vim.wo.relativenumber = false
      end
    end,
  }):map(k"-n")

  -- line number 〉

  -- snacks profile 〈

  -- profiler
  t.profiler():map(k"p")
  -- profiler highlights
  t.profiler_highlights():map(k"<C-p>")

  -- profile 〉

  -- lsp virtual lines 〈

  t.new({
    id = "lsp_virtual_lines",
    name = "lsp virtual lines",
    get = function() return vim.lsp.config.virtual_lines end,
    set = function(b) vim.lsp.config { virtual_lines = b } end,
  }):map(k"-L")

  -- lsp virtual lines 〉

  -- gitsigns 〈

  t.new({
    id = "gitsigns",
    name = "gitsigns",
    get = function()
      if package.loaded["gitsigns"] then
        return require("gitsigns.config").config.signcolumn
      else
        return false
      end
    end,
    set = function() require("gitsigns").toggle_signs() end,
  }):map(k"g")

  -- gitsigns 〉

  -- color highlighting 〈

  -- lsp document colors
  t.new({
    id = "lsp_document_colors",
    name = "lsp document colors",
    get = function()
      return vim.lsp.document_color.is_enabled()
    end,
    set = function(b) vim.lsp.document_color.enable(b, 0, { style = " " }) end,
  }):map(k"-C")

  -- nvim-highlight-colors
  t.new({
    id = "highlight_colors",
    name = "highlight colors",
    get = function()
      local id  = vim.api.nvim_get_namespaces()["nvim-highlight-colors"]
      return id and #vim.api.nvim_buf_get_extmarks(0, id, 0, -1, {}) > 0
    end,
    set = function() require("nvim-highlight-colors").toggle() end,
  }):map(k"c")

  -- color highlighting 〉

  -- conform 〈

  -- local
  t.new({
    id = "conform_locally",
    name = "conform locally",
    get = function() return not vim.b.disable_autoformat end,
    set = function() vim.b.disable_autoformat = not vim.b.disable_autoformat end,
  }):map(k"f")

  -- global
  t.new({
    id = "conform_globally",
    name = "conform globally",
    get = function() return not vim.g.disable_autoformat end,
    set = function() vim.g.disable_autoformat = not vim.g.disable_autoformat end,
  }):map(k"F")

  -- conform 〉

  -- disgnostics 〈

  t.new {
    id = "mdx.diagnostics",
    name = "diagnostics",
    get = vim.diagnostic.is_enabled,
    set = function(b)
      vim.diagnostic.enable(b)
      if package.loaded["tiny-inline-diagnostic"] then
        require("tiny-inline-diagnostic")[b and "enable" or "disable"]()
      end
    end
  }:map(k"d")

  t.new({
    id = "tiny_inline_diagnostic",
    name = "tiny inline diagnostic",
    get = function()
      if package.loaded["tiny-inline-diagnostic"] then
        return require("tiny-inline-diagnostic.state").user_toggle_state
      else
        return false
      end
    end,
    set = function(b)
      if package.loaded["tiny-inline-diagnostic"] then
        require("tiny-inline-diagnostic")[b and "enable" or "disable"]()
      else
        print("tiny-inline-diagnostic is not loaded yet")
      end
    end
  }):map(k"D")

  -- disgnostics 〉

  -- indent guidelines 〈

  t.new({
    id = "blink_indent_buffer",
    name = "indent guidelines (buffer)",
    get = function()
      if package.loaded["blink.indent"] then
        return require("blink.indent").is_enabled({ bufnr = 0 })
      else
        return false
      end
    end,
    set = function(b) require("blink.indent").enable(b, { bufnr = 0 }) end,
  }):map(k"i")

  -- indent guidelines 〉

  -- illuminate 〈

  t.new({
    id = "illuminate",
    name = "illuminate (global)",
    get = function()
      if package.loaded["illuminate"] then
        return not require("illuminate.engine").is_paused()
      else
        return false
      end
    end,
    set = function(b)
      if b then
        vim.cmd.IlluminateResume()
      else
        vim.cmd.IlluminatePause()
      end
    end,
  }):map(k"r")

  -- illuminate 〉

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
  -- stylua: ignore
  init = function() On.VeryLazy(register_toggles) end,
}
