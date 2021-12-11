let names = airline#util#themes('')
let total = len(names)

let errors = []
let nr = 0
for name in names
  echon "\r" . nr . '/' . (total - nr - 1) . ' ' . name

  try

    execute 'AirlineTheme ' . name

    Tmuxline airline
    execute 'TmuxlineSnapshot! ~/.tmux/tmuxline-files/' . name

    Tmuxline airline_insert
    execute 'TmuxlineSnapshot! ~/.tmux/tmuxline-files/' . name . '-insert'

    Tmuxline airline_visual
    execute 'TmuxlineSnapshot! ~/.tmux/tmuxline-files/' . name . '-visual'
    
  catch
    call add(errors, name)
    continue

  finally
    let nr += 1

  endtry

endfor
