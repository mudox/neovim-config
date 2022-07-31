local wk = require("which-key")

return function(bufnr)
  local function cmd(c)
    return ("<Cmd>%s<Cr>"):format(c)
  end

  local function lua(c)
    return ("<Cmd>lua %s<Cr>"):format(c)
  end

  local goto_keymaps = {
    name = "Goto",

    r = { cmd("Lspsaga lsp_finder"), "Lspsaga: finder" },
    d = { lua("vim.lsp.buf.declaration()"), "Declaration" },
    D = { lua("vim.lsp.buf.definition()"), "Definition" },
    t = { lua("vim.lsp.buf.type_definition()"), "Type definition" },
    i = { lua("vim.lsp.buf.implementation()"), "Implementation" },
    R = { lua("vim.lsp.buf.references()"), "References" },

    -- gh = { lua("vim.lsp.buf.hover()"), "Quick help" },
    h = { cmd("Lspsaga hover_doc"), "Quick help" },
    -- gs = { lua("vim.lsp.buf.signature_help()"), "Signature help" },
    s = { cmd("Lspsaga signature_help"), "Lspsaga: signature" },

    l = { cmd("Lspsaga show_line_diagnostics"), "Lspsaga: line diagnostics" },
    L = { lua("vim.diagnostic.open_float()"), "Line diagnostics" },
  }

  wk.register(goto_keymaps, { buffer = bufnr, prefix = "g" })

  local refactor_keymaps = {
    name = "LSP Refactor",

    rn = { lua("vim.lsp.buf.rename()"), "Rename" },
    rN = { cmd("Lspsage rename"), "Lspsaga: rename" },
    ir = { cmd("IncRename"), "Inc rename", silent = false },

    ca = { cmd("Lspsaga code_action"), "Lspsaga: code actions" },
    cA = { lua("vim.lsp.buf.code_action()"), "Code actions" },

    fm = {
      function()
        require("mudox.lsp.formatting").sync()
      end,
      "Lspsaga: code actions",
    },
  }

  wk.register(refactor_keymaps, { buffer = bufnr, prefix = "\\" })

  wk.register {
    ["]d"] = { cmd("Lspsaga diagnostic_jump_next"), "Lspsaga: next diagnostic" },
    ["[d"] = { cmd("Lspsaga diagnostic_jump_next"), "Lspsaga: previous diagnostic" },
  }
end
