" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/mudox/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/mudox/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/mudox/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/mudox/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/mudox/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["clever-f.vim"] = {
    keys = { { "", "f" }, { "", "F" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/clever-f.vim"
  },
  ["coc.nvim"] = {
    config = { "\27LJ\2\nb\0\0\6\0\6\0\n6\0\0\0009\0\1\0'\2\2\0\18\4\2\0009\2\3\0026\5\4\0009\5\5\5B\2\3\0A\0\0\1K\0\1\0\14luaplugin\fstdpath\vformat\22source %s/coc.vim\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/coc.nvim"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["jsonc.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/jsonc.vim"
  },
  ["moonscript-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/moonscript-vim"
  },
  nerdcommenter = {
    config = { "\27LJ\2\nl\0\0\2\0\5\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0)\1\1\0=\1\3\0)\1\0\0=\1\4\0K\0\1\0\23NERDDefaultNesting\20NERDSpaceDelims\28NERDBlockComIgnoreEmpty\6g\bvim\0" },
    keys = { { "n", ",c<Space>" }, { "v", ",c<Space>" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/nerdcommenter"
  },
  ["nvim-base16.lua"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/nvim-base16.lua"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n�\t\0\0\a\0+\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0004\4\0\0=\4\a\3=\3\b\0025\3\t\0005\4\n\0=\4\v\3=\3\f\0025\3\r\0005\4\14\0=\4\a\3=\3\15\0025\3\20\0005\4\16\0005\5\17\0005\6\18\0=\6\19\5=\5\v\4=\4\21\0035\4\22\0005\5\23\0=\5\24\0045\5\25\0=\5\26\4=\4\27\0035\4\28\0005\5\29\0=\5\30\0045\5\31\0=\5 \0045\5!\0=\5\"\0045\5#\0=\5$\4=\4%\0035\4&\0005\5'\0=\5(\4=\4)\3=\3*\2B\0\2\1K\0\1\0\16textobjects\16lsp_interop\25peek_definition_code\1\0\2\adf\20@function.outer\adF\17@class.outer\1\0\1\venable\2\tmove\22goto_previous_end\1\0\2\a[]\17@class.outer\a[M\20@function.outer\24goto_previous_start\1\0\2\a[m\20@function.outer\a[[\17@class.outer\18goto_next_end\1\0\2\a][\17@class.outer\a]M\20@function.outer\20goto_next_start\1\0\2\a]m\20@function.outer\a]]\17@class.outer\1\0\2\venable\2\14set_jumps\2\tswap\18swap_previous\1\0\1\15<leader>sp\21@parameter.inner\14swap_next\1\0\1\15<leader>sn\21@parameter.inner\1\0\1\venable\2\vselect\1\0\0\aiF\1\0\4\tjava#(method_declaration) @function\vpython$(function_definition) @function\bcpp$(function_definition) @function\6c$(function_definition) @function\1\0\4\aac\17@class.outer\aic\17@class.inner\aaf\20@function.outer\aif\20@function.inner\1\0\1\venable\2\vindent\1\3\0\0\vpython\trust\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\19init_selection\ayv\22scope_incremental\6s\21node_incremental\6v\21node_decremental\6V\1\0\1\venable\2\14highlight\fdisable\1\0\1\venable\2\19ignore_install\1\2\0\0\fhaskell\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["startuptime.vim"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/startuptime.vim"
  },
  ["swift.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/swift.vim"
  },
  ["switch.vim"] = {
    config = { "\27LJ\2\n2\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\6-\19switch_mapping\6g\bvim\0" },
    keys = { { "", "-" } },
    loaded = false,
    needs_bufread = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/switch.vim"
  },
  ["targets.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/targets.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n�\a\0\0\t\0&\0`6\0\0\0'\2\1\0B\0\2\0029\1\2\0'\2\3\0\18\3\1\0\18\5\2\0\18\6\2\0&\5\6\5'\6\4\0B\3\3\1\18\3\1\0'\5\5\0'\6\6\0B\3\3\1\18\3\1\0\18\5\2\0'\6\a\0&\5\6\5'\6\b\0B\3\3\1\18\3\1\0\18\5\2\0'\6\t\0&\5\6\5'\6\6\0B\3\3\1\18\3\1\0\18\5\2\0'\6\n\0&\5\6\5'\6\v\0B\3\3\1\18\3\1\0\18\5\2\0'\6\f\0&\5\6\5'\6\r\0B\3\3\1\18\3\1\0\18\5\2\0'\6\14\0&\5\6\5'\6\15\0B\3\3\1\18\3\1\0\18\5\2\0'\6\16\0&\5\6\5'\6\17\0B\3\3\1\18\3\1\0\18\5\2\0'\6\18\0&\5\6\5'\6\19\0B\3\3\1\18\3\1\0\18\5\2\0'\6\20\0&\5\6\5'\6\21\0B\3\3\1\18\3\1\0\18\5\2\0'\6\22\0&\5\6\5'\6\23\0B\3\3\1\18\3\1\0\18\5\2\0'\6\24\0&\5\6\5'\6\25\0B\3\3\0016\3\0\0'\5\26\0B\3\2\0029\3\27\0035\5#\0005\6\29\0005\a\28\0=\a\30\0065\a \0005\b\31\0=\b!\a=\a\"\6=\6$\5B\3\2\0016\3\0\0'\5\26\0B\3\2\0029\3%\3'\5!\0B\3\2\1K\0\1\0\19load_extension\rdefaults\1\0\0\15extensions\bfzf\1\0\0\1\0\4\14case_mode\15smart_case\25override_file_sorter\2\28override_generic_sorter\1\nfuzzy\2\16borderchars\1\0\0\1\t\0\0\b─\b│\b─\b│\b╭\b╮\b╯\b╰\nsetup\14telescope\26Telescope vim_options\6o\31Telescope lsp_code_actions\6.(Telescope lsp_workspace_diagnostics\6D'Telescope lsp_document_diagnostics\6d\24Telescope live_grep\6G\26Telescope grep_string\6g\27Telescope file_browser\6/\24Telescope git_files\6F\6f\23Telescope oldfiles\6r\25Telescope find_files\n<C-p>\22Telescope builtin\n<C-t>\tncmd\vkeymap\frequire\0" },
    keys = { { "", "<C-p>" }, { "", "<C-t><C-t>" }, { "", "<C-t>r" }, { "", "<C-t>f" }, { "", "<C-t>F" }, { "", "<C-t>/" }, { "", "<C-t>g" }, { "", "<C-t>g" }, { "", "<C-t>G" }, { "", "<C-t>d" }, { "", "<C-t>D" }, { "", "<C-t>." }, { "", "<C-t>o" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-endwise"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-endwise"
  },
  ["vim-qpen"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/vim-qpen"
  },
  ["vim-sandwich"] = {
    config = { "\27LJ\2\nJ\0\0\4\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0B\1\2\0019\1\4\0'\3\3\0B\1\2\1K\0\1\0\txnop\6s\tnnop\vkeymap\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-sandwich"
  },
  ["vim-textobj-comment"] = {
    config = { "\27LJ\2\nI\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0,textobj_comment_no_default_key_mappings\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-textobj-comment"
  },
  ["vim-textobj-entire"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-textobj-entire"
  },
  ["vim-textobj-function"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-textobj-function"
  },
  ["vim-textobj-indent"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-textobj-indent"
  },
  ["vim-textobj-syntax"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-textobj-syntax"
  },
  ["vim-textobj-user"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-textobj-user"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-toml"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-toml"
  },
  ["vim-unimpaired"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-unimpaired"
  },
  ["vim-visual-multi"] = {
    keys = { { "n", "<C-n>" }, { "i", "<C-n>" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/vim-visual-multi"
  },
  ["zen-mode.nvim"] = {
    commands = { "ZenMode" },
    config = { "\27LJ\2\n\v\0\1\1\0\0\0\1K\0\1\0\v\0\0\1\0\0\0\1K\0\1\0�\3\1\0\5\0\21\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\5\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\3=\3\16\0023\3\17\0=\3\18\0023\3\19\0=\3\20\2B\0\2\1K\0\1\0\ron_close\0\fon_open\0\fplugins\nkitty\1\0\2\fenabled\2\tfont\a+4\ttmux\1\0\1\fenabled\2\rgitsigns\1\0\1\fenabled\1\1\0\0\1\0\3\fshowcmd\1\nruler\1\fenabled\2\vwindow\1\0\0\foptions\1\0\a\19relativenumber\1\17cursorcolumn\1\vnumber\1\tlist\1\15foldcolumn\0060\15signcolumn\ano\15cursorline\1\1\0\3\nwidth\3N\rbackdrop\3\1\vheight\3\1\vtoggle\rzen-mode\frequire�\1\1\0\5\0\b\0\0146\0\0\0'\2\1\0B\0\2\0023\1\3\0=\1\2\0006\0\0\0'\2\4\0B\0\2\0029\0\5\0\18\1\0\0'\3\6\0'\4\a\0B\1\3\1K\0\1\0*lua require(\"zen-mode\").mudoxToggle()\b,zm\tncmd\vkeymap\0\16mudoxToggle\rzen-mode\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mudox/.local/share/nvim/site/pack/packer/opt/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
vim.cmd [[command! -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'startuptime.vim'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file ZenMode lua require("packer.load")({'zen-mode.nvim'}, { cmd = "ZenMode", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> f <cmd>lua require("packer.load")({'clever-f.vim'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> ,c<Space> <cmd>lua require("packer.load")({'nerdcommenter'}, { keys = ",c<lt>Space>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> F <cmd>lua require("packer.load")({'clever-f.vim'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ,c<Space> <cmd>lua require("packer.load")({'nerdcommenter'}, { keys = ",c<lt>Space>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[inoremap <silent> <C-n> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>C-n>" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-n> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>C-n>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>F <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>/ <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>/", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>f <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-p> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-p>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>g <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>g", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> - <cmd>lua require("packer.load")({'switch.vim'}, { keys = "-", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>r <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>r", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t><C-t> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t><lt>C-t>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>g <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>g", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>G <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>G", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>d <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>d", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>. <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>.", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>D <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>D", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-t>o <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-t>o", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType vimscript ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vimscript" }, _G.packer_plugins)]]
vim.cmd [[au FileType swift ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "swift" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'vim-endwise'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'swift.vim', 'targets.vim', 'vim-sandwich', 'vim-textobj-comment', 'vim-textobj-entire', 'vim-textobj-indent', 'vim-textobj-syntax', 'coc.nvim', 'vim-textobj-user', 'vim-toml', 'vim-unimpaired', 'vim-textobj-function', 'moonscript-vim', 'jsonc.vim', 'nvim-treesitter'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
