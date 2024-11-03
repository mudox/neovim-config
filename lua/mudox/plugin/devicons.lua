local function opts()
  local i = I.filetype

  local ret = {}

  -- stylua: ignore
  ret.override_by_filename = {
    [".gitattributes"] = { icon = i.git    },
    [".gitignore"]     = { icon = i.git    },
    ["justfile"]       = { icon = i.config },
    ["LICENSE"]        = { icon = i.key    },
    ["Makefile"]       = { icon = i.build  },
  }

  -- stylua: ignore
  ret.override_by_extension = {
    csv = {
      icon = i.table,
    },
    md = {
      icon  = i.markdown,
      color = "#ffffff",
    },
    java = {
      icon  = i.java,
      color = "#d60200",
    },
    class = {
      name  = "JavaCompiledFile",
      icon  = i.compiled,
      color = "#666666",
    },
    norg = {
      name  = "Neorg",
      icon  = i.neorg,
      color = "#18b63a",
    },
    bak = {
      name  = "BackupFile",
      icon  = i.backup,
      color = "#666666",
    },
    m = {
      name  = "ObjectiveCSourceFile",
      icon  = i.apple,
      color = "#d17cff",
    },
  }

  return ret
end

return {
  "kyazdani42/nvim-web-devicons",
  dependencies = "yamatsum/nvim-nonicons",
  opts = opts,
  config = function(_, o)
    require("nvim-web-devicons").setup(o)
    -- require("nvim-nonicons").setup {}
  end,
}
