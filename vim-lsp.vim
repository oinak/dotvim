
" LSP based Autocompletion ----------------------------------------------------
" Signs
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode


let g:lsp_auto_enable = 1
let g:lsp_signs_enabled = 1         " enable diagnostic signs / we use ALE for now
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
" let g:lsp_signs_error = {'text': '✖'}
" let g:lsp_signs_warning = {'text': '~'}
" let g:lsp_signs_hint = {'text': '?'}
" let g:lsp_signs_information = {'text': '!!'}
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/.config/nvim/vim-lsp.log')

if executable('solargraph')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Gemfile'))},
        \ 'whitelist': ['ruby', 'eruby'],
        \ })
endif

nnoremap gd :LspDefinition<CR>
"------------------------------------------------------------------------------
" ASYNCOMPLETE
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'prabirshrestha/asyncomplete.vim'

" let g:asyncomplete_auto_popup = 1

" " Force refresh autocompletion
" imap <c-space> <Plug>(asyncomplete_force_refresh)


"------------------------------------------------------------------------------
