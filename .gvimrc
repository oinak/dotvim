if has("gui_running")
  " set guifont=InputMono-ExtraLight\ 11
  " set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 11
  " set guifont=Ubuntu\ Mono\ 14
  " set guifont=UbuntuMono-Regular:h18
  " set guifont=Terminus\ 10
  " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
  " set guifont=Terminess\ Powerline\ 10
  " set guifont=Menlo\ Regular:h13
  " set guifont=Monaco:h13
  " set guifont=Fira\ Code:h18
  " set guifont=IBM\ Plex\ Mono\ weight=453\ 10
  if has('nvim')
    " Neovim specific commands
  else
    " Standard vim specific commands
    if has("gui_macvim")
      set nomacligatures
      set antialias
      " set guifont=UbuntuMono-Regular:h18
      " set guifont=IBMPlexMono-Light:h17
      " set guifont=Iosevka-Light:h20
      " set guifont=IBMPlexMono-Light:h18
      set guifont=FiraCode-Light:h17
    else
      set guifont=Ubuntu\ Mono\ 12
    endif
  endif
  set mousemodel=popup
endif

