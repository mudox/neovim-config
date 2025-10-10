return {
  "folke/sidekick.nvim",
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = "zellij",
        enabled = true,
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").focus()
      end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
    {
      K.p"aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
      mode = { "n", "v" },
    },
    {
      K.p"as",
      function()
        require("sidekick.cli").select()
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
      end,
      desc = "Sidekick Select CLI",
      mode = { "n", "v" },
    },
    {
      K.p"ac",
      function()
        require("sidekick.cli").toggle { name = "claude", focus = true }
      end,
      desc = "Sidekick Claude Toggle",
      mode = { "n", "v" },
    },
    {
      K.p"ag",
      function()
        require("sidekick.cli").toggle { name = "grok", focus = true }
      end,
      desc = "Sidekick Grok Toggle",
      mode = { "n", "v" },
    },
    {
      K.p"ap",
      function()
        require("sidekick.cli").prompt()
      end,
      desc = "Sidekick Ask Prompt",
      mode = { "n", "v" },
    },
  },
  cond = false,
}
