return {
  "hat0uma/csvview.nvim",
  cmd = "CsvViewToggle",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    view = { display_mode = "border" },
    -- stylua: ignore
    keymaps = {
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },

      jump_next_field_end = { "L", mode = { "n", "v" }, nowait = true },
      jump_prev_field_end = { "H", mode = { "n", "v" }, nowait = true },
      jump_next_row       = { "J", mode = { "n", "v" }, nowait = true },
      jump_prev_row       = { "K", mode = { "n", "v" }, nowait = true },
    },
  },
}
