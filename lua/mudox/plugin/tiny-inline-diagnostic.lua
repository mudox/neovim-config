return {
  "rachartier/tiny-inline-diagnostic.nvim",
  lazy = false,
  priority = 800,
  opts = {
    signs = {
      diag = I.diagnostic.sign,
    },

    options = {
      throttle = 100,

      virt_texts = {
        priority = 5000,
      },
      show_source = {
        enabled = true,
        if_many = false,
      },
      set_arrow_to_diag_color = true,

      show_all_diags_on_cursorline = true,
      multilines = false,

      overflow = {
        mode = "wrap",
        padding = 1,
      },
    },

    disabled_ft = { "lazy" },
  },
}
