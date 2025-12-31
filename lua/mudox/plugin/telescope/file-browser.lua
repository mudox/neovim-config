local function keymaps()
  local a = require("telescope").extensions.file_browser.actions
  -- stylua: ignore
  return {
    i = {
      ["<C-,>n"] = a.create,
      ["<C-,>d"] = a.remove,
      ["<C-,>r"] = a.rename,
      ["<C-,>c"] = a.copy,
      ["<C-,>m"] = a.move,
      ["<C-,>o"] = a.open,

      ["<C-/>"]  = a.toggle_browser,
    },
  }
end

local function opts()
  return {
    theme = "ivy",

    collapse_dir = true,
    depth = false,

    git_status = false,
    dir_icon = I.folder.closed:sub(1, -2),

    prompt_path = true,

    mappings = keymaps(),
  }
end

local function config()
  local t = require("telescope")
  t.setup {
    extensions = { file_browser = opts() },
  }
  t.load_extension("file_browser")
end

local function r(o)
  return require("telescope").extensions.file_browser.file_browser(o)
end

local function open_cwd()
  r {
    files = false, -- start in folder mode
  }
end

local function open_buffer()
  r {
    path = vim.fn.expand("%:p:h"),
    select_buffer = true,
  }
end

-- stylua: ignore
local keys = {
  { K.p"t\\",  open_buffer, desc = "[tfb] open buffer path" },

  { K.p"oB",   open_buffer, desc = "[tfb] open buffer path" },
  { K.p"ob",   open_cwd,    desc = "[tfb] open $cwd"        },
}

return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "telescope.nvim", "plenary.nvim" },
  keys = keys,
  config = config,
}
