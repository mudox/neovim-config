local opts = {
  -- stylua: ignore
  icons       = {
    chmodx    = "󰒃 ",
    copyFile  = "󱉥 ",
    copyPath  = "󰅍 ",
    duplicate = " ",
    file      = "󰈔 ",
    move      = "󰪹 ",
    new       = "󰝒 ",
    nextFile  = "󰖽 ",
    prevFile  = "󰖿 ",
    rename    = "󰑕 ",
    trash     = "󰩹 ",
  },
}

-- stylua: ignore
local keys = {
  -- new file
  { "C", "createNew",              "create"                       },
  { "c", "createNewFileInFolder",  "create in ..."                },
  { "c", "moveSelectionToNewFile", "move to new file", mode = "x" },
  { "d", "duplidateFile",          "duplicate"                    },

  -- move
  { "m", "moveAndRenameFile", "move & rename" },
  { "M", "moveToFolderInCwd", "move to ..."   },

  -- copy to clipboard
  { "yn", "copyFilename",              "copy filename"                },
  { "yp", "copyFilepath",              "copy absolute filepath"       },
  { "yP", "copyRelativePath",          "copy relative filepath"       },
  { "yd", "copyDirectoryPath",         "copy absolute directory path" },
  { "yD", "copyRelativeDirectoryPath", "copy relative directory path" },
  { "yY", "copyFileItself",            "system copy file"             },
  { "yy", "<Cmd>0,$y<Cr> + ✓",         "copy file content"            },

  -- misc
  { "r",    "renameFile",           "rename"           },
  { "x",    "chmodx",               "chmod +x"         },
  { "<Bs>", "trashFile",            "trash"            },
  { "v",    "showInSystemExplorer", "reveal in finder" },
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
