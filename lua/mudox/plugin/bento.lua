return {
  "serhez/bento.nvim",
  opts = {
    main_keymap = V.key.bento,
    map_last_accessed = true,
    main_keymap_icon = "@",
    lock_char = "󰐃",
    max_open_buffers = 20,

    ui = {
      floating = {
        -- minimal_menu = "dashed",
        max_rendered_buffers = 10,
      },
    },
  },
  keys = { V.key.bento },
}
