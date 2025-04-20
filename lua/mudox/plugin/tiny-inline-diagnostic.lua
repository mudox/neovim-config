return {
  "rachartier/tiny-inline-diagnostic.nvim",
  lazy = false,
  priority = 800,
  opts = {
    signs = {
      -- diag = I.short_bar,
      diag = "•",
    },

    options = {
      virt_texts = {
        priority = 5000,
      },
      show_source = {
        enabled = true,
        if_many = false,
      },
      show_all_diags_on_cursorline = true,

      set_arrow_to_diag_color = true,

      multilines = {
        enabled = true,
        always_show = false,
      },
      overflow = {
        mode = "wrap",
        padding = 1,
      },
    },

    disabled_ft = { "lazy" },
  },
}
