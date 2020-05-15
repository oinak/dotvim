" == INDEX == (use '*' to navigate)
"
" 1.- GENERAL_SETTINGS
" 2.- PLUGIN_SETUP
"   2.1 AIRLINE
"   2.2 INDENT_GUIDES
"   2.3 GITGUTTER
"   2.4 SYNTASTIC
"   2.5 FZF
"   2.6 SOLARIZED
"   2.7 RANGER
"   2.8 SPLIT_JOIN
"   2.9 TAG_ALONG
" 3.- LEADER_KEY
" 4.- FILES_FINDING
" 5.- TAG_NAVIGATION
" 6.- AUTOCOMPLETION
" 7.- COLORS
" 8.- TEXT_SELECTION
" MISCELANEA

"==============================================================GENERAL_SETTINGS

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
set ruler        " show a ruler at the bottom of the page
"set rulerformat=%55(%{strftime('%a\ %e\/%b\ %H:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set number
" set relativenumber
set nowrap
set hidden
set vb t_vb=
set ts=2 sts=2 sw=2 expandtab
set backspace=indent,eol,start "" allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l
set antialias
set dir=~/tmp/ " swap file outside of project grepers reach

if has("gui_macvim")
  set macthinstrokes
endif

" disable annoying ruby tooltips from vim-ruby
if !has('nvim')
  set balloonexpr=
  set noballooneval
endif

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

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

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd FocusLost * silent! wa
endif

" Disable useless GUI Toolbar
if has("gui_running")
  " set guioptions-=T
  " set guioptions-=m
  set guioptions=aiA
endif

"--------------------------------------------------------------------------TERM
if &term =~ '^xterm'
  " solid underscore
  let &t_SI .= "\<Esc>[6 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
if !has('nvim')
  set ttymouse=xterm2 "Enable mouse in terminal
endif

colorscheme oinak

" ================================================================ PLUGIN_SETUP
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" GIT - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Plug 'tpope/vim-fugitive'        " Git integration
Plug 'airblade/vim-gitgutter'    " Git markings on the gutter

" SOURCE CODE MANIPULATION - - - - - - - - - - - - - - - - - - - - - - - - - -
Plug 'vim-ruby/vim-ruby'         " Ruby support
Plug 'tpope/vim-rails'           " Rails support
Plug 'vim-syntastic/syntastic'   " Linters integration

Plug 'kana/vim-textobj-user'     " requirement of vim-textobj-ruby
Plug 'rhysd/vim-textobj-ruby'    " make vim understand ruby blocks as motions

Plug 'AndrewRadev/splitjoin.vim' " Split/Join ruby hashes, arglists, etc
Plug 'AndrewRadev/tagalong.vim'  " Change closing html-ish tags automatically

Plug 'ervandew/supertab'         " Completion operated by Tab
Plug 'tpope/vim-commentary'      " Commenting shortcuts gc

" FILE/DIRECTORY OPERATIONS - - - - - - - - - - - - - - - - - - - - - - - - -
Plug 'jlanzarotta/bufexplorer'   " Buffer explorer
Plug 'kien/ctrlp.vim'            " fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FZF Binary
Plug 'junegunn/fzf.vim'          " FZF Vim integration

Plug 'rbgrouleff/bclose.vim'     " Ranger dependency on neovim
Plug 'francoiscabrol/ranger.vim' " Terminal file manager

" VIUSAL AIDS - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Plug 'bling/vim-airline'         " Airline ruler enhancements
Plug 'nathanaelkane/vim-indent-guides'

"" COLORSCHEME PLUGINS - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()

"-----------------------------------------------------------------------AIRLINE
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
"------------------------------------------------------------------------------

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
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" let g:gitgutter_sign_column_always = 1
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" --------------------------------------------------------------------SYNTASTIC
" Sytastic plugin options
let g:syntastic_auto_loc_list = 0
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

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

" install with:
" npm install -g eslint
" npm install -g babel-eslint
" npm install -g eslint-plugin-react
" npm install -g syntastic-react
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

imap <F4> <ESC>:SyntasticToggleMode<CR>i
nmap <F4> <ESC>:SyntasticToggleMode<CR>
map <F4> <ESC>:SyntasticToggleMode<CR>

function! RubocopAutocorrect()
  execute "!rubocop -a " . bufname("%")
  call SyntasticCheck()
endfunction

map <silent> <Leader>cop :call RubocopAutocorrect()<cr>

function! EslintAutocorrect()
  execute "!eslint --fix " . bufname("%")
  call SyntasticCheck()
endfunction

map <silent> <Leader>esl :call EslintAutocorrect()<cr>

"---------------------------------------------------------------------------FZF
" --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
" --color info:150,prompt:110,spinner:150,pointer:167,marker:174

" Tell Ag not to color results
" let g:ackprg = 'ag --nogroup --nocolor --column'

" Default options are --nogroup --column --color
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path "0;36" --color-match "0;33"', fzf#vim#with_preview(), <bang>0)

" --------------------------------------------------------------------SOLARIZED
" let g:solarized_contrast="high"    "default value is normal
" let g:solarized_visibility="high"    "default value is normal
" let g:solarized_hitrail=1    "default value is 0
syntax enable
set background=dark
" colorscheme solarized

" -----------------------------------------------------------------------RANGER
let g:ranger_replace_netrw = 0 " open ranger when vim open a directory
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
let g:ranger_map_keys = 1 " maps <Leader>f to open ranger

" -------------------------------------------------------------------SPLIT_JOIN
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>
" For the record, my personal preference is to avoid mnemonics in this case and
" go for an approach that makes more sense to my fingers instead:

nmap ss :SplitjoinSplit<cr>
nmap sj :SplitjoinJoin<cr>

" ================================================================== LEADER_KEY
" Required by many others:
let mapleader=","

noremap <Leader>b :BufExplorer<CR>
noremap <Leader>B :Buffers<CR>

" Edit .vimrc configuration file
noremap <Leader>r :e $MYVIMRC<CR>

" map <silent> <Leader>cop :call RubocopAutocorrect()<cr>
" map <silent> <Leader>esl :call EslintAutocorrect()<cr>

" =============================================================== FILES_FINDING
set path+=**                      " Search down into subfolders
set wildignore+=*/.bundle/*       " exclude Bundler (ruby dependencies)
set wildignore+=*/node_modules/*  " exclude node_modules (npm dependencies)
set wildignore+=*/.git/*          " exclude git database
set wildmenu                      " Display all matching entries when we tab complete

noremap <F6> :BufExplorer<CR>
noremap <S-F6> :Buffers<CR>
nmap <F7> <Esc>:bp<CR>
nmap <F8> <Esc>:bn<CR>

"" CtrlP Fuzzy Filename Search-------------------------------------------------
noremap <C-p> <ESC>:CtrlPMixed<CR>
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|packs|RESOURCE|.bundle)$',
  \ }
"let g:ctrlp_working_path_mode = '0'
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 'r'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" ===============================================================TAG_NAVIGATION
let g:rails_ctags_arguments = '--languages=ruby --exclude=.git --exclude=log --exclude=tmp $(bundle list --paths |grep -e "returnly\|properties\|image_server")'

" <F3> " Goto definition (ctags)
imap <F3> <ESC>g]
nmap <F3> <ESC>g]
imap <S-F3> <ESC>_*
nmap <S-F3> <ESC>_*

" ============================================================== AUTOCOMPLETION
"" To config preview window:
" set complete-=.,w,b,u,t,i
" set completeopt+=preview
" set completeopt+=menuone

"" Managed by SuperTab plugin:
" let g:SuperTabMappingForward = "<tab>"
" let g:SuperTabMappingBackward = "<s-tab>"
" let g:SuperTabDefaultCompletionType = "<c-n>"
" let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Change the behavior of the <Enter> key when the popup menu is visible.
" In that case the Enter key will simply select the highlighted menu item,
" " just as <C-Y> does
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" =======================================================================COLORS
" Red color for trailing spaces in insert mode
if has("autocmd")
  highlight ExtraWhitespace guibg=#331111 ctermbg=52
  au ColorScheme * highlight ExtraWhitespace guibg=#330000 ctermbg=52
  au BufEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhiteSpace /\s\+$/
endif

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

" hi Search guibg=#66aadd guifg=Black cterm=none gui=none
" hi IncSearch guibg=#66dddd guifg=Black cterm=none gui=none

" <F12> " Invisible characters and colors
nmap <F12> :set list!<CR>
vmap <F12> <ESC>:set list!<CR>gv
imap <F12> <ESC>:set list!<CR>i

hi NonText guifg=#bbbbbb

" ============================================================== TEXT_SELECTION
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

" ================================================================== MISCELANEA
" automatically close the quick fix window when leaving a file
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Avoid accidentally enter Ex mode
nnoremap Q <nop>

" hi Search guibg=#66aadd guifg=Black cterm=none gui=none
" hi IncSearch guibg=#66dddd guifg=Black cterm=none gui=none
"------------------------------------------------------------------------------
