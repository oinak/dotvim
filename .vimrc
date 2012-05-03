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

" Red color for trailing spaces in insert mode
if has("autocmd")
  highlight ExtraWhitespace guibg=#330000 ctermbg=52
  au ColorScheme * highlight ExtraWhitespace guibg=#330000 ctermbg=52
  au BufEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhiteSpace /\s\+$/
endif

" strip trailing whitespace
function! StripWhitespace()
    exec ':%s/ \+$//gc'
endfunction
map <leader>s :call StripWhitespace()<CR>

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


" Edit .vimrc configuration file
let mapleader=","
noremap <Leader>v :e $MYVIMRC<CR>

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

" Find files quickly by regex of their paths
map <S-A-o> <ESC>:FufFile<CR>
imap <S-A-o> <ESC>:FufFile<CR>
nmap <leader>o <ESC>:FufFile<CR>

" Red background beyond column 80
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

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
"SyntasticEnable 'ruby'
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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

" IMPORTANT: Uncomment one of the following lines to force
" using 256 colors (or 88 colors) if your terminal supports it,
" but does not automatically use 256 colors by default.
set t_Co=256
" "set t_Co=88
if (&t_Co == 256 || &t_Co == 88) && !has('gui_running') && filereadable(expand("$HOME/.vim/bundle/guicolorscheme/plugin/guicolorscheme.vim"))
  " Use the guicolorscheme plugin to makes 256-color or 88-color
  " terminal use GUI colors rather than cterm colors.
  runtime! plugin/guicolorscheme.vim
  GuiColorScheme fer-railscasts
else
  " For 8-color 16-color terminals or for gvim, just use the
  " regular :colorscheme command.
  colorscheme fer-railscasts
endif

" Leader shortcuts
nnoremap <leader>a :Ack

