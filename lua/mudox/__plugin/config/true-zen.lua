local function update_kitty_listen_on()
  local id = io.popen("fd -ts -d1 -1 kitty /tmp"):read()
  if nil == id then
    return
  end
  vim.cmd(("let $KITTY_LISTEN_ON = 'unix:%s'"):format(id))
end

local opts = {
  modes = {
    ataraxis = {
      minimum_writing_area = { -- minimum size of main window
        width = 120,
        height = 44,
      },
      padding = { -- padding windows
        left = 1000,
        right = 1000,
        top = 2,
        bottom = 2,
      },
      -- ISSUE: Neovim rendering crashed after `kitt set_font_size`
      -- callbacks = {
      --   open_pre = function()
      --     update_kitty_listen_on()
      --   end,
      --   open_close = function()
      --     update_kitty_listen_on()
      --   end,
      -- },
    },
  },
  integrations = {
    -- hide tmux status bar in (minimalist, ataraxis)
    tmux = true,
    -- increment font size in Kitty. Note: you must set `allow_remote_control
    -- socket-only` and `listen_on unix:/tmp/kitty` in your personal config
    -- (ataraxis)
    kitty = {
      enabled = false,
      font = "+3",
    },
    -- enable twilight (ataraxis)
    twilight = true,
    -- hide nvim-lualine (ataraxis)
    lualine = true,
  },
}

require("true-zen").setup(opts)
