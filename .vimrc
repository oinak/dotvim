" == INDEX == (use '*' to navigate)
"
" 1.- GENERAL_SETTINGS
" 2.- LEADER_KEY
" 3.- PLUGIN_SETUP
"   3.1 AIRLINE
"   3.2 INDENT_GUIDES
"   3.3 GITGUTTER
"   3.4 SYNTASTIC
"   3.5 GOLANG
"   3.6 FZF
"   3.7 BUFEXPLORER
"   3.8 SOLARIZED
"   3.9 SPLIT_JOIN
"   3.10 TAG_ALONG
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
" set norelativenumber
set nowrap
set hidden
set vb t_vb=
set ts=2 sts=2 sw=2 expandtab
set backspace=indent,eol,start "" allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l
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

" ================================================================== LEADER_KEY
" Required by many others:
let mapleader=","

" Edit .vimrc configuration file
noremap <Leader>r :e $MYVIMRC<CR>

" ================================================================ PLUGIN_SETUP
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Snippets - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Plug 'SirVer/ultisnips' " conflitcs with pyhton2/3 installed
Plug 'honza/vim-snippets'
Plug 'vim-scripts/AutoComplPop'
Plug 'ervandew/supertab'         " Completion operated by Tab

" GIT - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Plug 'tpope/vim-fugitive'        " Git integration
Plug 'airblade/vim-gitgutter'    " Git markings on the gutter

" SOURCE CODE MANIPULATION - - - - - - - - - - - - - - - - - - - - - - - - - -
Plug 'vim-syntastic/syntastic'   " Linters integration
Plug 'kana/vim-textobj-user'     " requirement of vim-textobj-ruby
Plug 'rhysd/vim-textobj-ruby'    " make vim understand ruby blocks as motions
Plug 'AndrewRadev/splitjoin.vim' " Split/Join ruby hashes, arglists, etc
Plug 'AndrewRadev/tagalong.vim'  " Change closing html-ish tags automatically
Plug 'tpope/vim-commentary'      " Commenting shortcuts gc

" Languages
Plug 'vim-ruby/vim-ruby'         " Ruby support
Plug 'tpope/vim-rails'           " Rails support
Plug 'tpope/vim-bundler'
Plug 'othree/html5.vim'
Plug 'burnettk/vim-angular'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'fatih/vim-go'
Plug 'ludovicchabant/vim-gutentags' " auto manage ctags files

" FILE/DIRECTORY OPERATIONS - - - - - - - - - - - - - - - - - - - - - - - - -
Plug 'jlanzarotta/bufexplorer'   " Buffer explorer
Plug 'kien/ctrlp.vim'            " fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FZF Binary
Plug 'junegunn/fzf.vim'          " FZF Vim integration

" VIUSAL AIDS - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Plug 'bling/vim-airline'               " Airline ruler enhancements
Plug 'Yggdroot/indentLine'
Plug 'bignimbus/you-are-here.vim'      " name and navigate window splits

"" COLORSCHEME PLUGINS - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'cormacrelf/vim-colors-github'


" WIP (stuff in test)

Plug 'vim-test/vim-test' " run tests from vim

" make test commands execute using dispatch.vim
let test#strategy = "vimterminal"

" Initialize plugin system
call plug#end()

let g:rubycomplete_rails = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

"-----------------------------------------------------------------------AIRLINE
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
"------------------------------------------------------------------------------

"------------------------------------------------------------------INDENT_LINES
let g:indentLine_char = '│'

let g:indentLine_fileTypeExclude = ['json','markdown']

"-----------------------------------------------------------------INDENT_GUIDES

" Add a map of your choice.  I prefer to  use
" <leader>here.  My leader key is set to the
" backslash (\), so by typing \here in normal
" mode, I activate you-are-here.vim. When I
" am ready to close the popups, I use the same
" mapping.

nnoremap <silent> <leader>here :call you_are_here#Toggle()<CR>

" Optional: 

" If you want to add a different (shorter?) map
" to close the popups, that option is available.
" I personally prefer to use <ESC> but that's a bit
" intrusive so I don't endorse it :)
nnoremap <silent> <leader>bye :call you_are_here#Close()<CR>

" Most users wouldn't need to manually refresh you-are-here
" while it's open, but it's possible:
nnoremap <silent> <leader>upd :call you_are_here#Update()<CR>

let g:youarehere_padding=[0,1,0,0]

" <F1> " Invisible characters and colors
nmap <F1> :call you_are_here#Toggle()<CR>
vmap <F1> <ESC>:call you_are_here#Toggle()<CR>
imap <F1> <C-\><C-O>:call you_are_here#Toggle()<CR>
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
" let g:syntastic_ruby_rubocop_exe = 'bundle exec rubocop'

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

map <Leader>cop :call RubocopAutocorrect()<cr>

function! EslintAutocorrect()
  execute "!eslint --fix " . bufname("%")
  call SyntasticCheck()
endfunction

map <Leader>esl :call EslintAutocorrect()<cr>

"------------------------------------------------------------------------GOLANG
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
" au FileType go nmap <leader>gcov <Plug>(go-coverage)

"---------------------------------------------------------------------------FZF
" --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
" --color info:150,prompt:110,spinner:150,pointer:167,marker:174

" Tell Ag not to color results
" let g:ackprg = 'ag --nogroup --nocolor --column'

" Default options are --nogroup --column --color
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path "0;36" --color-match "0;33"', fzf#vim#with_preview(), <bang>0)

noremap <Leader>b :Buffers<CR>
noremap <Leader>f :Files<CR>
noremap <Leader>g :GFiles<CR>

" Lines in loaded buffers
noremap <Leader>zl :Lines<CR>
" Lines in the current buffer
noremap <Leader>zbl :BLines<CR>
" Tags in the project (ctags -R)
noremap <Leader>zt :Tags<CR>
" Tags in the current buffer
noremap <Leader>zbt :BTags<CR>

" Tags in the project for the word under cursor
noremap <Leader>t      :exe "Tags ". expand("<cword>")<CR>
noremap <Leader>a      :exe "Ag ". expand("<cword>")<CR>

" -------------------------------------------------------------------BUFEXPLORER
" I am testing to replace this with fzf :Buffers command, thus the uppercase
noremap <Leader>B :BufExplorer<CR>

" --------------------------------------------------------------------SOLARIZED

syntax enable

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif


let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal
" let g:solarized_hitrail=1    "default value is 0
" colorscheme thegoodluck
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
set background=dark
" colorscheme gruvbox
colorscheme oinak


" -------------------------------------------------------------------SPLIT_JOIN
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>
nmap sj :SplitjoinJoin<cr>
nmap ss :SplitjoinSplit<cr>

" ---------------------------------------------------------------------TAGALONG
" let g:tagalong_filetypes = ['html', 'xml', 'jsx', 'eruby', 'ejs', 'eco',
"                             'php', 'htmldjango', 'javascriptreact', 'typescriptreact']
" let g:tagalong_additional_filetypes = ['custom', 'another']

" =============================================================== FILES_FINDING
set path+=**                      " Search down into subfolders
set wildignore+=*/.bundle/*       " exclude Bundler (ruby dependencies)
set wildignore+=*/node_modules/*  " exclude node_modules (npm dependencies)
set wildignore+=*/.git/*          " exclude git database
set wildmenu                      " Display all matching entries when we tab complete

noremap <S-F6> :BufExplorer<CR>
noremap <F6> :Buffers<CR>
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
let g:rails_ctags_arguments = '--languages=ruby --exclude=.git --exclude=log --exclude=tmp . $(bundle list --paths |grep -e "returnly\|properties\|image_server")'

au FileType {rb} au BufWritePost <buffer> silent! Ctags
au! FileType css,scss setl iskeyword+=-

" <F3> " Goto definition (ctags)
imap <F3> <ESC>g]
nmap <F3> <ESC>g]
vmap <F3> v_g]
imap <S-F3> <ESC>_*
nmap <S-F3> <ESC>_*

" ============================================================== AUTOCOMPLETION
"" To config preview window:
" set complete-=.,w,b,u,t,i
set completeopt+=preview
set completeopt+=menuone

" Managed by UltiSnips  plugin:
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" AutoComplPop makes this redundant:
" Managed by SuperTab plugin:
" let g:SuperTabMappingForward = "<tab>"
" let g:SuperTabMappingBackward = "<s-tab>"
" let g:SuperTabDefaultCompletionType = "<c-p>"
" let g:SuperTabContextDefaultCompletionType = "<c-p>"

" Change the behavior of the <Enter> key when the popup menu is visible.
" In that case the Enter key will simply select the highlighted menu item,
" " just as <C-Y> does
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" using the previous to confirm AutoComplPop suggestions
" it is incompatible with tpope/endwise (both activate on <CR>)

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
vmap < <gv
vmap > >gv
vmap <S-Tab> <gv
vmap <Tab> >gv

"" Bubbling Text
" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
nmap <C-k> ddkP
nmap <C-j> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]=gv
vmap <C-Down> xp`[V`]=gv
vmap <C-k> xkP`[V`]=gv
vmap <C-j> xp`[V`]=gv

" Ctrl-C, Ctrl-V option for copy/paste
" vmap <C-c> "+yi
" vmap <C-x> "+c
" vmap <C-v> c<ESC>"+p
" imap <C-v> <ESC>"+pa

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
"
" VIMCONF
" https://twitter.com/codingCommander
"
function! Writer ()
  setlocal spell spelllang=en_us
  setlocal formatoptions=t1
  setlocal textwidth=80
  setlocal noautoindent
  setlocal shiftwidth=5
  setlocal tabstop=5
  setlocal expandtab
endfunction
com! WR call Writer()

