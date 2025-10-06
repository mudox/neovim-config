local state = require("telescope.actions.state")

local function inspect(prompt_bufnr)
  local entry = state.get_selected_entry()
  vim.print(entry)
end

local function open_in_main(prompt_bufnr)
  local entry = state.get_selected_entry()
  if entry.path then
    X.layout.main:open(entry.path)
  else
    print("`entry.path` is nil")
    require("telescope.actions").close(prompt_bufnr)
  end
end

local function open_in_secondary(prompt_bufnr)
  local entry = state.get_selected_entry()
  if entry.path then
    X.layout.secondary:open(entry.path)
  else
    print("`entry.path` is nil")
    require("telescope.actions").close(prompt_bufnr)
  end
end

local function flash(prompt_bufnr)
  require("flash").jump {
    pattern = "^",
    label = { before = false, after = true, rainbow = { enabled = true } },
    highlight = { matches = false },
    search = {
      mode = "search",
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
        end,
      },
    },
    action = function(match)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      picker:set_selection(match.pos[1] - 1)
    end,
  }
end

return require("telescope.actions.mt").transform_mod {
  inspect = inspect,

  open_in_main = open_in_main,
  open_in_secondary = open_in_secondary,

  flash = flash,
}
