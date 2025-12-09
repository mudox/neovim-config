local opts = {
  -- stylua: ignore
  -- icons       = {
  --   chmodx    = "󰒃 ",
  --   copyFile  = "󱉥 ",
  --   copyPath  = "󰅍 ",
  --   duplicate = " ",
  --   file      = "󰈔 ",
  --   move      = "󰪹 ",
  --   new       = "󰝒 ",
  --   nextFile  = "󰖽 ",
  --   prevFile  = "󰖿 ",
  --   rename    = "󰑕 ",
  --   trash     = "󰩹 ",
  -- },
}

-- stylua: ignore
local keys = {
  { "<Bs>", "trashFile",             "trash"         },
  { "C",    "createNew",             "create"        },
  { "c",    "createNewFileInFolder", "create in ..." },
  { "d",    "duplidateFile",         "duplicate"     },
  { "m",    "moveAndRenameFile",     "move & rename" },
  { "M",    "moveToFolderInCwd",     "move to ..."   },
  { "r",    "renameFile",            "rename"        },
  { "x",    "chmodx",                "chmod +x"      },
}
K.lazy_keys(keys, {
  key_prefix = K.p("f"),
  main_cmd = "Genghis",
  desc_prefix = "genghis",
})

return {
  "chrisgrieser/nvim-genghis",
  keys = keys,
  opts = opts,
}
