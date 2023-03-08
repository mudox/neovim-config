-- stylua: ignore start
local statusline = {
  watching       = { icon = " ", color = "#1abc9c" },
  running        = { icon = "⚙ ", color = "#e0af68" },
  device_running = { icon = " ", color = "#4a6edb" },
  success        = { icon = " ", color = "#1abc9c" },
  failure        = { icon = " ", color = "#db4b4b" },
  show_progress  = true,
}
-- stylua: ignore end

local simctl = {
  iOS = {
    "iPhone 13 Pro Max",
  },
}

local log_buffer = {
  --- Whether toggling the buffer should auto focus to it?
  focus = false,
  --- Split Log buffer height
  height = 20,
  --- Vsplit Log buffer width
  width = 75,
  --- Default log buffer direction: { "horizontal", "vertical" }
  default_direction = "horizontal",
}

local prefix = ",x"
local mappings = {
  --- Whether xbase mapping should be disabled.
  enable = true,
  --- Open build picker. showing targets and configuration.
  build_picker = prefix .. "b", --- set to 0 to disable
  --- Open run picker. showing targets, devices and configuration
  run_picker = prefix .. "r", --- set to 0 to disable
  --- Open watch picker. showing run or build, targets, devices and configuration
  watch_picker = prefix .. "w", --- set to 0 to disable
  --- A list of all the previous pickers
  all_picker = prefix .. "a", --- set to 0 to disable
  --- horizontal toggle log buffer
  toggle_split_log_buffer = prefix .. "j",
  --- vertical toggle log buffer
  toggle_vsplit_log_buffer = prefix .. "l",
}

local opts = {
  statusline = statusline,
  simctl = simctl,
  log_buffer = log_buffer,
  mappings = mappings,
}

require("xbase").setup(opts)
