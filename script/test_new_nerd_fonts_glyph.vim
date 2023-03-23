" cmdhub: Test new nerd font

function s:make_block(title, code_points)  
  let lines = ['', a:title, '']
  let glyph_list = map(a:code_points, 'printf("    %s  %x", nr2char(v:val), v:val)')
  let glyph_line = join(glyph_list, '')
  let glyph_line = substitute(glyph_line, '.\{88}', "&::", 'g')
  call extend(lines, split(glyph_line, ':', 1))

  return lines + ['']
endfunction

function s:test()
  let ranges = {
        \  'Seti-UI + Custom': range(0xE5FA, 0xE62B),
        \  'Devicons': range(0XE700, 0XE7C5),
        \  'Font Awesome': range(0XF000, 0xF2E0),
        \  'Font Awesome Extension': range(0xE200, 0xE2A9),
        \  'Material Design': range(0xF500, 0xFD46),
        \  'Weather': range(0xE300, 0xE3EB),
        \  'Octicons': [0x2665, 0x26A1, 0xF27C] + range(0xF400, 0xF4A8),
        \  'Powerline Extra Symbols': [0xE0A3] + range(0xE0B4, 0xE0C8) + [0xE0CA] + range(0xE0CC, 0xE0D2) + [0xE0D4],
        \  'IEC Power': range(0x23FB, 0x23FE) + [0x2B58],
        \  'Font Logos (Formerly: Font Linux)': range(0xF300, 0xF313),
        \  'Pomicons': range(0xE000, 0xE00D),
        \  }

  tabnew '/tmp/nerd-fonts-glyphs.txt'
  set nowrap
  %delete _
  for [title, range] in items(ranges)
    call append(line('$'), s:make_block(title, range))
   
  endfor
  0delete _
endfunction

call s:test()
delfunction s:make_block
delfunction s:test
