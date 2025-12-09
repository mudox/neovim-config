return {
  "drop-stones/im-switch.nvim",
  dependencies = "plenary.nvim",
  event = "VeryLazy",
  opts = {
    macos = {
      enabled = true,
      default_im = "com.apple.keylayout.ABC",
    },

    -- no need to restore prev im
    save_im_state_events = {},
    restore_im_events = {},
  },
}
