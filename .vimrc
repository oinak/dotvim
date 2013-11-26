" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

set ruler
"set rulerformat=%55(%{strftime('%a\ %e\/%b\ %H:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set number
set nowrap

set hidden
set vb t_vb=
set ts=2 sts=2 sw=2 expandtab


"" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

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
set hlsearch     " Highlight search matches
set autowrite    " Automatically save before commands like :next and :make
set hidden       " Hide buffers when they are abandoned
set mouse=a      " Enable mouse usage (all modes)
set ttymouse=xterm2 "Enable mouse in terminal

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()

" Red color for trailing spaces in insert mode
if has("autocmd")
  highlight ExtraWhitespace guibg=#330000 ctermbg=52
  au ColorScheme * highlight ExtraWhitespace guibg=#330000 ctermbg=52
  au BufEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhiteSpace /\s\+$/
endif


"Requisito para rubyblock:
runtime macros/matchit.vim

"if $COLORTERM == 'gnome-terminal'
if has("gui_running")
  " dealt with inside .gvimrc
else
  set term=gnome-256color
endif

" Ok, I have it everywhere
colorscheme railscasts

" tab navigation like firefox
nmap <C-S-tab> :tabprevious<CR> " C-RePag por defecto
nmap <C-tab> :tabnext<CR>       " C-AvPag por defecto
map <C-S-tab> :tabprevious<CR>
map <C-tab> :tabnext<CR>
imap <C-S-tab> <Esc>:tabprevious<CR>i
imap <C-tab> <Esc>:tabnext<CR>i
"nmap <C-t> :tabnew<CR>
"imap <C-t> <Esc>:tabnew<CR>

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


" Edit .vimrc configuration file
let mapleader=","
noremap <Leader>r :e $MYVIMRC<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Yes I have a weak soul, and bad habits, just bear with me
" remember to add 'stty -ixon -ixoff' to the shell rc file
imap <C-s> <Esc>:w<CR>i
nmap <C-s> :w<CR>

"" Bubbling Text
" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
nmap <C-k> ddkP
nmap <C-j> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" Ctrl-C, Ctrl-V option for copy/paste
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

" Preferred leader for spanish keyboard
let mapleader = ","

" Red background beyond column 80
highlight OverLength ctermbg=red ctermfg=white guibg=#331111
match OverLength /\%111v.\+/

" Color column 80 (compatible) Better after theme loading
if exists('+colorcolumn')
  set colorcolumn=110
  highlight ColorColumn guibg=#331111 cterm=NONE ctermbg=234
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Toggleable current line/column highlight
highlight CursorLine   cterm=NONE ctermbg=234 ctermfg=NONE guibg=#222222 guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=234 ctermfg=NONE guibg=#222222 guifg=NONE
nnoremap <c-f12> :set cursorline! cursorcolumn!<CR>
nnoremap <leader>+ :set cursorline! cursorcolumn!<CR>

" Save as root
cmap w!! %!sudo tee > /dev/null %

" Fancy status line
autocmd BufEnter *
                       \ if exists("b:rails_root") |
                       \   let g:base_dir = b:rails_root |
                       \ endif |
"statusline setup
set statusline=%f       "tail of the filename

"Git
set statusline+=%{GitBranchInfoString()}
let g:git_branch_status_head_current=1   " This will show just the current head branch name 
let g:git_branch_status_text=" "         " This will show 'text' before the branches. If not set ' Git ' (with a trailing left space) will be displayed. 
let g:git_branch_status_nogit=""         " The message when there is no Git repository on the current dir 
let g:git_branch_status_around="()"      " Characters to put around the branch strings. Need to be a pair or characters, the first will be on the beginning of the branch string and the last on the end. 
let g:git_branch_status_ignore_remotes=1 " Ignore the remote branches. If you don't want information about them, this can make things works faster

"RVM
" set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2


" Disable useless GUI Toolbar
if has("gui_running")
  " set guioptions-=T
  " set guioptions-=m
  set guioptions=aiA
endif

" Sytastic plugin options
let g:syntastic_auto_loc_list=1
let g:syntastic_ruby_checkers=['mri']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" If enabled, syntastic will do syntax checks when buffers are first loaded as well as on saving
let g:syntastic_check_on_open=0

" If enabled, syntastic will error message associated with the current line to the command window. If multiple errors are found, the first will be used.
let g:syntastic_echo_current_error=1

" Use this option to tell syntastic whether to use the |:sign| interface to mark syntax errors:
let g:syntastic_enable_signs=1

" Use this option to control what the syntastic |:sign| text contains. Several error symobls can be customized:
let g:syntastic_error_symbol = '!!'
let g:syntastic_style_error_symbol = 's!'
let g:syntastic_warning_symbol = '!?'
let g:syntastic_style_warning_symbol = 's?'

" Use this option to tell syntastic whether to display error messages in balloons when the mouse is hovered over erroneous lines:
let g:syntastic_enable_balloons = 1

" Use this option to tell syntastic whether to use syntax highlighting to mark errors (where possible). Highlighting can be turned off with 0
let g:syntastic_enable_highlighting = 1

" Enable this option if you want the cursor to jump to the first detected error when saving or opening a file:
let g:syntastic_auto_jump = 1

let g:syntastic_always_populate_loc_list=1

" let g:syntastic_javascript_checkers = ['jshint']

" Config manual syntax checking
autocmd FileType javascript map <F4> <ESC>:!jssyntax.lua %<CR>
autocmd FileType ruby map <F4> :w<CR>:!ruby -c %<CR>

nmap <F9> :TlistToggle<CR>
imap <F9> <ESC>:TlistToggle<CR>
map <F9> :TlistToggle<CR>


nmap <F2> :e.<CR>
imap <F2> <ESC>:e.<CR>
nmap <S-F2> :Ex<CR>
imap <S-F2> <ESC>:Ex<CR>

ab refrences references
ab calse clase
ab fisrt first
ab fmc Fernando Martínez de la Cueva

colorscheme railscasts

"" Leader shortcuts
" evaluar en nodejs
nnoremap <leader>j <ESC>:w<CR>:!node %<CR>
" remove ^M carriage returns
nnoremap <leader>m <ESC>:%s/<C-v><C-m>//g<CR>
" remove trailing whitespace
nnoremap <leader>s <ESC>:%s/\s\+$//g<CR>
" manually reload file
nnoremap <F5> <ESC>:e! %<CR>


" Assisted alignment
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <leader>a> :Tabularize /=><cr>
  vmap <leader>a> :Tabularize /=><cr>
endif

runtime plugins/spellfile.vim
" setlocal spell spelllang=es

" <Leader>b - set breakpoint at current line
" <Leader>v - open/close window with variables. You can expand/collapse variables by 'o' in normal mode or left-mouse double-click
" <Leader>n - step over
" <Leader>s - step into
" <Leader>c - continue

" Use Ag as Ack
" let g:ackprg = 'ag --nogroup --nocolor --column'

" Read about ag from https://github.com/ggreer/the_silver_searcher
" Install from http://swiftsignal.com/packages/
let g:agprg="/usr/bin/ag -H --nocolor --nogroup --column"


let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=#000000 ctermbg=black
hi IndentGuidesEven guibg=#101010 ctermbg=darkgrey
nmap <F10> <ESC>:IndentGuidesToggle<CR>
vmap <F10> <ESC>:IndentGuidesToggle<CR>
imap <F10> <ESC>:IndentGuidesToggle<CR>


" jscomplete-vim is the modern complement Vim plugin for JavaScript guys.
" Using as omnifunc
" autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS

" ctags config
:set tags=./tags,/home/avature/.tags;

autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab
au BufEnter *.js set ai sw=4 ts=4 sta et fo=croql

nmap <F8> :TagbarToggle<CR>

hi Search guibg=#ffff00 guifg=Black cterm=none gui=none

" swap file outside of project grepers reach
:set dir=~/tmp

" discard other splits as FullScreen
nmap <F11> <ESC><C-w>o<CR>
vmap <F11> <ESC><C-w>o<CR>
imap <F11> <ESC><C-w>o<CR>

noremap <C-p> <ESC>:CtrlPMixed<CR>
