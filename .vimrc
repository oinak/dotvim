" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

set ruler
set rulerformat=%55(%{strftime('%a\ %e\/%b\ %H:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set number
set nowrap

set hidden
set vb t_vb=
set ts=2 sts=2 sw=2 expandtab


"" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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
set showcmd      " Show (partial) command in status line.
set showmatch    " Show matching brackets.
set ignorecase   " Do case insensitive matching
set smartcase    " Do smart case matching
set incsearch    " Incremental search
"set autowrite   " Automatically save before commands like :next and :make
"set hidden      " Hide buffers when they are abandoned
"set mouse=a     " Enable mouse usage (all modes)

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("autocmd")
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=darkred
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhitespace /\s\+$/
endif

"Requisito para rubyblock:
runtime macros/matchiT.VIM

if $COLORTERM == 'gnome-terminal'
  set term=gnome-256color
  colorscheme railscasts
else
  colorscheme desert
endif

syntax enable
set background=dark
colorscheme railscasts
set guifont=Monaco\ 11 "Envy\ Code\ R\ 12  "Monospaced\ 10

" tab navigation like firefox
nmap <C-S-tab> :tabprevious<CR> " C-RePag por defecto
nmap <C-tab> :tabnext<CR>       " C-AvPag por defecto
map <C-S-tab> :tabprevious<CR>
map <C-tab> :tabnext<CR>
imap <C-S-tab> <Esc>:tabprevious<CR>i
imap <C-tab> <Esc>:tabnext<CR>i
nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:tabnew<CR>

" Region indent/outdent RubyMine style
nmap <S-A-Left> <<
nmap <S-A-Right> >>
vmap <S-A-Left> <gv
vmap <S-A-Right> >gv
vmap <S-Tab> <gv
vmap <Tab> >gv

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:→\ ,eol:⁋

"Invisible characters and colors
nmap <F12> :set list!<CR>
imap <F12> <ESC>:set list!<CR>
highlight NonText guifg=#bbbbbb
"highlight SpecialKey guifg=reverse 
"white guibg=lightgray

" Previous and Next Buffer
nmap <F7> <Esc>:bp<CR>
nmap <F8> <Esc>:bn<CR> 
map <F6> <Esc>:BufExplorer<CR>
imap <F6> <Esc>:BufExplorer<CR>


" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>

" Yes I have a weak soul, and bad habits, just bear with me
imap <C-s> <Esc>:w<CR>i
nmap <C-s> :w<CR>

"" Bubbling Text
" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" add Ctrl-V option for paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Shift arrows to select
imap <S-Down> <ESC>lvj
vmap <S-Down> j
nmap <S-Down> vj

imap <S-Up> <ESC>vk
vmap <S-Up> k
nmap <S-Up> vk

imap <S-Right> <ESC>vl
vmap <S-Right> l
nmap <S-Right> vl

imap <S-Left> <ESC>vh
vmap <S-Left> h
nmap <S-Left> vh

" Find files quickly by regex of their paths
map <S-A-o> <ESC>:FufFile<CR>
imap <S-A-o> <ESC>:FufFile<CR>
nmap <leader>o <ESC>:FufFile<CR>

" Red background beyond column 80
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" Color column 80 (compatible) Better after theme loading
if exists('+colorcolumn')
  set colorcolumn=80
  highlight ColorColumn guibg=#111111 cterm=NONE ctermbg=234
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Toggleable current line/column highlight
highlight CursorLine   cterm=NONE ctermbg=234 ctermfg=NONE guibg=#111111 guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=234 ctermfg=NONE guibg=#111111 guifg=NONE
nnoremap <c-f12> :set cursorline! cursorcolumn!<CR>
nnoremap <leader>h :set cursorline! cursorcolumn!<CR>

" Save as root
cmap w!! %!sudo tee > /dev/null %

