local opts = {
  ignore_case = true,

  exit_after_idle_msecs = {
    labeled = nil,
    unlabeled = 3000, -- for t/f modes
  },

  force_beacons_into_match_width = false,
  match_only_the_start_of_same_char_seqs = true,

  repeat_ft_with_target_char = true,

  special_keys = {
    next_match_group = "<space>",
    prev_match_group = "<tab>",
  },
}

require("lightspeed").setup(opts)
