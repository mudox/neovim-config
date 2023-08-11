local M = {}

-- stylua: ignore start

M.ctrl_i                          = " "

M.ctrl_slash                      = " "
M.ctrl_shift_slash                = " "

M.ctrl_shift_left_square_bracket  = "󰜱 "
M.ctrl_shift_right_square_bracket = "󰜴 "

M.ctrl_shift_h                    = "󰶺 "
M.ctrl_shift_l                    = "󰶻 "
M.ctrl_shift_k                    = "󰶼 "
M.ctrl_shift_j                    = "󰶹 "

-- stylua: ignore end

for k, v in pairs(M) do
  M[k] = v:gsub("%s+", "")
end

return M
