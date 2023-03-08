url = "tpope/vim-capslock"

event = "InsertEnter"

function setup()
  require("mudox.keymap").iplug("<C-l>", "CapsLockToggle")
end
