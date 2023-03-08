local nplug = require("mudox.keymap").nplug

-- HACK: avoid `,` keymap conflicting with `which-key`
-- By default, `Lightspeed_,_ft` will be mapped to comma `,`, which conflicts
-- with which-key's mapping.
-- Here defines a placeholder mappings, so that `Lightspeed` will not add
-- defualt mapping for `Lightspeed_,_ft`.
nplug("<Plug>Mudox", "Lightspeed_,_ft")
