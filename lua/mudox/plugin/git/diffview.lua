local function opts()
  local i = require("mudox.ui.icon")
  local a = require("diffview.actions")

  local view = {
    default = { winbar_info = true },
    merge_tool = { winbar_info = true },
    file_history = { winbar_info = true },
  }

    -- stylua: ignore
  local keymaps = {
    view = {
      ["<tab>"] = false,
      ["<S-Tab>"] = false,
      { "n", "<C-n>", a.select_next_entry, { desc = "Open the diff for the next file" } },
      { "n", "<C-p>", a.select_prev_entry, { desc = "Open the diff for the previous file" } },
    },
    file_panel = {
          ["<tab>"] = false,
          ["<S-Tab>"] = false,
          { "n", "<C-n>", a.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<C-p>", a.select_prev_entry, { desc = "Open the diff for the previous file" } },
        },
    file_history_panel = {
      ["<tab>"] = false,
      ["<S-Tab>"] = false,
      { "n", "<C-n>", a.select_next_entry, { desc = "Open the diff for the next file" } },
      { "n", "<C-p>", a.select_prev_entry, { desc = "Open the diff for the previous file" } },
    },
  }

  return {
    enhanced_diff_hl = true,

    icons = {
      folder_closed = "",
      folder_open = "",
    },

    signs = {
      fold_closed = i.chevron.right,
      fold_open = i.chevron.down,
    },

    view = view,

    keymaps = keymaps,
  }
end

local tabman_id = "Diff"
-- stylua: ignore
local keys = {
  { "<Tab>d", function() X.tabman.open(tabman_id, "DiffviewOpen") end,     desc = "[Diffview] Open",     },
  { "<Tab>D", function() X.tabman.recreate(tabman_id, "DiffviewOpen") end, desc = "[Diffview] Recreate", },
}

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewLog" },
  keys = keys,
  opts = opts,
}
