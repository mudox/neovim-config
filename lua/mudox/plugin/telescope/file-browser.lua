local function mappings()
  local a = require("telescope").extensions.file_browser.actions
  return {
    i = {
      ["<C-,>"] = a.toggle_browser,
      ["<M-/>"] = a.toggle_browser,
    },
  }
end

local function opts()
  return {
    theme = "ivy",

    collapse_dir = true,

    git_status = false,
    dir_icon = require("mudox.ui.icon").folder.closed:sub(1, -2),

    prompt_path = true,

    mappings = mappings(),
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
  { "<leader>t\\", open_buffer, desc = "[TFB] Open buffer path" },
  { "<C-S-p>",     open_cwd,    desc = "[TFB] Open $CWD"        },

  { "<leader>f/",  open_cwd,    desc = "[TFB] Open $CWD"        },
  { "<leader>f.",  open_buffer, desc = "[TFB] Open buffer path" },
}

return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "telescope.nvim", "plenary.nvim" },
  keys = keys,
  config = config,

  -- branch = "mudox", -- add space padding for double width nerd symbols
  -- lock = true,
}
