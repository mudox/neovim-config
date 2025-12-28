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
  { "C", "createNewFile",          "create"                       },
  { "c", "createNewFileInFolder",  "create in ..."                },
  { "c", "moveSelectionToNewFile", "move to new file", mode = "x" },
  { "d", "duplidateFile",          "duplicate"                    },

  -- move
  { "m", "moveAndRenameFile", "move & rename" },
  { "M", "moveToFolderInCwd", "move to ..."   },

  -- copy to clipboard
  { "yn", "copyFilename",              "filename"                 },
  { "yp", "copyFilepath",              "absolute filepath"        },
  { "yP", "copyRelativePath",          "relative filepath"        },
  { "yd", "copyDirectoryPath",         "absolute directory path"  },
  { "yD", "copyRelativeDirectoryPath", "relative directory path"  },
  { "yY", "copyFileItself",            "file content (clipboard)" }, -- error
  { "yy", "<Cmd>0,$y +<Cr> ✓",         "file content (register)"  },

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
