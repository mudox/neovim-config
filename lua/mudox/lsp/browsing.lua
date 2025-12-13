local function hover()
  vim.lsp.buf.hover {
    border = { " " },
  }
end

-- stylua: ignore start
K.nmap("gx",     vim.lsp.buf.declaration,             { desc = "[lsp] goto declaration"         })

-- Telescope
K.nmap("gd",     K.c"Telescope lsp_definitions",      { desc = "[lsp] goto definitions"         })
K.nmap("gy",     K.c"Telescope lsp_type_definitions", { desc = "[lsp] goto type definitions"    })
K.nmap("gm",     K.c"Telescope lsp_implementations",  { desc = "[lsp] goto implementations"     })
K.nmap("gr",     K.c"Telescope lsp_references",       { desc = "[lsp] goto references"          })
K.ndel("gra")
K.ndel("gri")
K.ndel("grn")
K.ndel("grr")
K.ndel("grt")

-- Glance
K.nmap("g<Space>d",     K.c"Glance definitions",            { desc = "[glance] goto definitions"      })
K.nmap("g<Space>y",     K.c"Glance type_definitions",       { desc = "[glance] goto type definitions" })
K.nmap("g<Space>m",     K.c"Glance implementations",        { desc = "[glance] goto implementations"  })
K.nmap("g<Space>r",     K.c"Glance references",             { desc = "[glance] goto references"       })

-- in favor of hover.nvim
K.nnop("K")
K.nmap("gk",     hover,                               { desc = "[lsp] hover"                    })

K.nmap("gK",     vim.lsp.buf.signature_help,          { desc = "[lsp] signature help"           })
K.imap("<C-k>k", vim.lsp.buf.signature_help,          { desc = "[lsp] signature Help"           })
-- stylua: ignore end
