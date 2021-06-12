install = [[
Plug 'https://github.com/junegunn/fzf.git', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim.git'
]]

function setup()
  g.fzf_buffers_jump = 1

  g.fzf_layout = {
    window = {width = 1, height = 0.4, yoffset = 1, border = 'horizontal'},
  }

  ncmd('<Space>r', 'History')
  ncmd('<Space>z', 'Files')
end
