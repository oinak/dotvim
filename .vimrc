" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

set number

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"Requisito para rubyblock:
runtime macros/matchit.vim

" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
let g:solarized_italic=0    "default value is 1
let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal
syntax enable
set background=dark
colorscheme solarized
set guifont=Monospace\ 10
" ------------------------------------------------------------------

" The following items are available options, but do not need to be
" included in your .vimrc as they are currently set to their defaults.

" let g:solarized_termtrans=0
" let g:solarized_degrade=0
" let g:solarized_bold=1
" let g:solarized_underline=1
" let g:solarized_termcolors=16
" let g:solarized_diffmode="normal"
" let g:solarized_hitrail=0
" let g:solarized_menu=1

" tab navigation like firefox
:nmap <C-S-tab> :tabprevious<CR> " C-RePag por defecto
:nmap <C-tab> :tabnext<CR>       " C-AvPag por defecto
:map <C-S-tab> :tabprevious<CR>
:map <C-tab> :tabnext<CR>
:imap <C-S-tab> <Esc>:tabprevious<CR>i
:imap <C-tab> <Esc>:tabnext<CR>i
:nmap <C-t> :tabnew<CR>
:imap <C-t> <Esc>:tabnew<CR>

" Indentación de regiones seleccionadas al estilo RubyMine
nmap <S-A-Left> <<
nmap <S-A-Right> >>
vmap <S-A-Left> <gv
vmap <S-A-Right> >gv

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:→\ ,eol:⁋

"Invisible characters and colors
nmap <F12> :set list!<CR>
imap <F12> :set list!<CR>
highlight NonText guifg=#bbbbbb
"highlight SpecialKey guifg=reverse 
"white guibg=lightgray

" Buffer siguiente y anterior
nmap <F7> <Esc>:bp<CR>
nmap <F8> <Esc>:bn<CR> 

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>

"" Texto burbujeante
" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

