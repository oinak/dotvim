" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

set ruler
"set rulerformat=%55(%{strftime('%a\ %e\/%b\ %H:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set number
" set relativenumber
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

" Plugin loader (must be before filetype):
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()

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
set ttyfast
set mouse=a      " Enable mouse usage (all modes)

" disable annoying ruby tooltips from vim-ruby
set balloonexpr=
set noballooneval

" Rubyblock requirement:
runtime macros/matchit.vim

" ------------------------------------------------------------------ LEADER KEY
" Required by many others:
let mapleader=","

"" Leader shortcuts
nnoremap <leader>c <ESC>:w<CR>:!coffee %<CR>
"* nnoremap <leader>f <Esc>:BufExplorer<CR>
" evaluar en nodejs
nnoremap <leader>j <ESC>:w<CR>:!node %<CR>

" remove ^M carriage returns
nnoremap <leader>m <ESC>:%s/<C-v><C-m>//g<CR>
"* noremap <Leader>r :e $MYVIMRC<CR>
" remove trailing whitespace
nnoremap <leader>s <ESC>:%s/\s\+$//g<CR>
"* nnoremap <leader>+ :set cursorline! cursorcolumn!<CR>

" auto-indent whole file
nnoremap <leader>< <ESC>ggVG=

" toggle all folds under cursor
nnoremap <leader>z <ESC>zA

" ---------------------------------------------------------- META CONFIGURATION
" Edit .vimrc configuration file
noremap <Leader>r :e $MYVIMRC<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd FocusLost * silent! wa
endif

" -----------------------------------------------------------------------COLORS
" Red color for trailing spaces in insert mode
if has("autocmd")
  highlight ExtraWhitespace guibg=#331111 ctermbg=52
  au ColorScheme * highlight ExtraWhitespace guibg=#330000 ctermbg=52
  au BufEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhiteSpace /\s\+$/
endif

"if $COLORTERM == 'gnome-terminal'
if has("gui_running")
  " dealt with inside .gvimrc
else
  set term=gnome-256color
endif

" Ok, I have it everywhere
colorscheme railscasts

" Red background beyond column 80
highlight OverLength ctermbg=red ctermfg=white guibg=#331111
match OverLength /\%81v.\+/

" Color column 80 (compatible) Better after theme loading
if exists('+colorcolumn')
  set colorcolumn=80
  if exists("*matchadd")
     augroup colorColumn
        au!
        au VimEnter,WinEnter * call matchadd('ColorColumn', '\%81v.\+', 100)
     augroup END
  endif
  highlight ColorColumn guibg=#331111 cterm=NONE ctermbg=234
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Toggleable current line/column highlight
highlight CursorLine   cterm=NONE ctermbg=234 ctermfg=NONE guibg=#222222 guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=234 ctermfg=NONE guibg=#222222 guifg=NONE
nnoremap <c-f12> :set cursorline! cursorcolumn!<CR>
nnoremap <leader>+ :set cursorline! cursorcolumn!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▹\ ,eol:⁋

hi Search guibg=#dd6666 guifg=Black cterm=none gui=none

" --------------------------------------------------TEXT SELECTION AND MOVEMENT
"" Region indent/outdent
vmap <S-Tab> <gv
vmap <Tab> >gv

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

"----------------------------------------------------------------FUNCTIONS KEYS
" <F2> " File explorer
" Quick Open file explorer
nmap <F2> :e.<CR>
imap <F2> <ESC>:e.<CR>
" Open file explorer on curren file's folder
nmap <S-F2> :Ex<CR>
imap <S-F2> <ESC>:Ex<CR>

" <F3> " Goto definition (ctags)
imap <F3> <ESC>g]
nmap <F3> <ESC>g]
imap <S-F3> <ESC>_*
nmap <S-F3> <ESC>_*

" <F4> " Syntastic toggle
imap <F4> <ESC>:SyntasticToggleMode<CR>i
nmap <F4> <ESC>:SyntasticToggleMode<CR>
map <F4> <ESC>:SyntasticToggleMode<CR>

" <F5> " Reload file
nnoremap <F5> <ESC>:e! %<CR>
imap <F5> <ESC><F5>i

" <F6> " Open Bufexplorer:
map <F6> <Esc>:BufExplorer<CR>
imap <F6> <Esc>:BufExplorer<CR>
" Alternate keymapping:
nnoremap <leader>f <Esc>:BufExplorer<CR>

" <F7> " Previous and Next Buffer
nmap <F7> <Esc>:bp<CR>
nmap <F8> <Esc>:bn<CR>

" <F9> " Tag list (show/hide)
nmap <F9> :TlistToggle<CR>
imap <F9> <ESC>:TlistToggle<CR>
map <F9> :TlistToggle<CR>

" <F10> " Indent Guides (show/hide)
nmap <F10> <ESC>:IndentGuidesToggle<CR>
vmap <F10> <ESC>:IndentGuidesToggle<CR>gv
imap <F10> <ESC>:IndentGuidesToggle<CR>i

" Discard other splits as FullScreen
nmap <F11> <ESC><C-w>o<CR>
vmap <F11> <ESC><C-w>o<CR>gv
imap <F11> <ESC><C-w>o<CR>i

" <F12> " Invisible characters and colors
nmap <F12> :set list!<CR>
vmap <F12> <ESC>:set list!<CR>gv
imap <F12> <ESC>:set list!<CR>i
highlight NonText guifg=#bbbbbb

" ------------------------------------------------------------------OPEN / SAVE

" Yes I have a weak soul, and bad habits, just bear with me
" remember to add 'stty -ixon -ixoff' to the shell rc file
imap <C-s> <Esc>:w<CR>i
nmap <C-s> :w<CR>

" Save as root
cmap w!! %!sudo tee > /dev/null %

"" CtrlP Fuzzy Filename Search
noremap <C-p> <ESC>:CtrlPMixed<CR>
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|packs|RESOURCE)$',
  \ }
"let g:ctrlp_working_path_mode = '0'
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 'r'


" ------------------------------------------------------------------STATUS_LINE
" Fancy status line
autocmd BufEnter *
                       \ if exists("b:rails_root") |
                       \   let g:base_dir = b:rails_root |
                       \ endif |
" statusline setup
set statusline=%f       "tail of the filename

" Git on the statusline
set statusline+=%{GitBranchInfoString()}
let g:git_branch_status_head_current=1   " This will show just the current head
                                         " branch name
let g:git_branch_status_text=" "         " This will show 'text' before the
                                         " branches. If not set ' Git ' (with a
                                         " trailing left space) will be
                                         " displayed.
let g:git_branch_status_nogit=""         " The message when there is no Git
                                         " repository on the current dir
let g:git_branch_status_around="()"      " Characters to put around the branch
                                         " strings. Need to be a pair or
                                         " characters, the first will be on the
                                         " beginning of the branch string and
                                         " the last on the end.
let g:git_branch_status_ignore_remotes=1 " Ignore the remote branches. If you
                                         " don't want information about them,
                                         " this can make things works faster
set statusline+=%=                     " Left/right separator
set statusline+=%c,                    " Cursor column
set statusline+=%l/%L                  " Cursor line/total lines
set statusline+=\ %P                   " Percent through file
set laststatus=2

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" ----------------------------------------------------------------------TOOLBAR
" Disable useless GUI Toolbar
if has("gui_running")
  " set guioptions-=T
  " set guioptions-=m
  set guioptions=aiA
endif

" --------------------------------------------------------------------SYNTASTIC
" Sytastic plugin options
let g:syntastic_auto_loc_list = 1
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
" let g:syntastic_ruby_checkers = ['mri']

" If enabled, syntastic will do syntax checks when buffers are first loaded as
" well as on saving
let g:syntastic_check_on_open=0

" If enabled, syntastic will error message associated with the current line to
" the command window. If multiple errors are found, the first will be used.
let g:syntastic_echo_current_error=1

" Use this option to tell syntastic whether to use the |:sign| interface to
" mark syntax errors:
let g:syntastic_enable_signs=1

" Use this option to control what the syntastic |:sign| text contains. Several
" error symobls can be customized:
let g:syntastic_error_symbol = '!!'
let g:syntastic_style_error_symbol = 's!'
let g:syntastic_warning_symbol = '!?'
let g:syntastic_style_warning_symbol = 's?'

" Use this option to tell syntastic whether to display error messages in
" balloons when the mouse is hovered over erroneous lines:
let g:syntastic_enable_balloons = 1

" Use this option to tell syntastic whether to use syntax highlighting to mark
" errors (where possible). Highlighting can be turned off with 0
let g:syntastic_enable_highlighting = 1

" Enable this option if you want the cursor to jump to the first detected error
" when saving or opening a file:
let g:syntastic_auto_jump = 0
let g:syntastic_always_populate_loc_list=0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_coffee_checkers = ['coffeelint']


ab refrences references
ab calse clase
ab fisrt first
ab fmc Fernando Martínez de la Cueva
ab funtcion function


runtime plugins/spellfile.vim
" setlocal spell spelllang=es

"-----------------------------------------------------------SEARCH / GREP / ACK
" Use Ag as Ack
" let g:ackprg = 'ag --nogroup --nocolor --column'

" Read about ag from https://github.com/ggreer/the_silver_searcher
" Install from http://swiftsignal.com/packages/
let g:agprg="/usr/local/bin/ag --column"

" swap file outside of project grepers reach
:set dir=~/tmp/

"-----------------------------------------------------------------INDENT_GUIDES
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 4
" let g:indent_guides_start_level = 2

hi IndentGuidesOdd  guibg=#000000 ctermbg=black
hi IndentGuidesEven guibg=#222222 ctermbg=234

"---------------------------------------------------------------------GITGUTTER
" Config for https://github.com/airblade/vim-gitgutter
highlight SignColumn      guifg=#ffffff guibg=#000000 ctermbg=16  ctermfg=100
highlight GitGutterAdd    guifg=#66aa66 guibg=#000000 ctermfg=71  ctermbg=16
highlight GitGutterChange guifg=#6666aa guibg=#000000 ctermfg=100 ctermbg=16
highlight GitGutterDelete guifg=#aa6666 guibg=#000000 ctermfg=52  ctermbg=16

let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
" let g:gitgutter_sign_column_always = 1
set signcolumn=yes

let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

"-------------------------------------------------------------------ZEAL_SEARCH
:nnoremap gz :!zeal --query "<cword>"&<CR><CR>

"---------------------------------------------------------------------FILETYPES
" javascript
autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab
augroup filetype javascript syntax=javascript
au BufEnter *.js set ai sw=2 ts=2 sta et fo=croql

" coffee-script
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" php (okn)
autocmd FileType php set tabstop=4|set shiftwidth=4|set expandtab
au BufEnter *.php set ai sw=4 ts=4 sta et fo=croql

" jbuilder
au BufEnter *.jbuilder set ft=ruby

"--------------------------------------------------------------------------TERM
if &term =~ '^xterm'
  " solid underscore
  let &t_SI .= "\<Esc>[4 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2 "Enable mouse in terminal

"-----------------------------------------------------------------------AIRLINE
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0

"----------------------------------------------------------------GUIFONT_RESIZE
function! EnlargeFont()
    let l:font=split( &guifont )
    let l:font[-1] = l:font[-1] + 1
    let &guifont=join( l:font, ' ' )
endfunction

function! ShrinkFont()
    let l:font=split( &guifont )
    if l:font[-1] > 2
        let l:font[-1] = l:font[-1] - 1
        let &guifont=join( l:font, ' ' )
    endif
endfunction

"set guifont=Monospace\ 10
imap <C-kPlus>  <ESC>:call EnlargeFont()<CR>i
nmap <C-kPlus>  :call EnlargeFont()<CR>

imap <C-kMinus> <ESC>:call ShrinkFont()<CR>i
nmap <C-kMinus> :call ShrinkFont()<CR>

nnoremap <leader><Up> :call EnlargeFont()<CR>
nnoremap <leader><Down> :call ShrinkFont()<CR>

"-------------------------------------------------------------------MISCAELANEA
" automatically close the quick fix window when leaving a file
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Avoid accidentally enter Ex mode
nnoremap Q <nop>
"------------------------------------------------------------------------------
let g:rails_ctags_arguments = '--languages=ruby --exclude=.git --exclude=log --exclude=tmp $(bundle list --paths)'

" Search down into subfolders
set path+=**

" Display all matching entries when we tab complete
set wildmenu

" Tabular
if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: :Tabularize /:\zs/l0l1<CR>
  vmap <Leader>t: :Tabularize /:\zs/l0l1<CR>
endif

" block comment
" vmap <Leader>c :norm ^i# <ESC>
" vmap <Leader>C :norm ^xx<ESC>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType javascript       let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,c :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,u :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Golang integration
set autowrite

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

