" Ricardo Berdejo's nvim config file
" Use this for global / shared configs and use
" embear/vim-localvimrc to load local configs
"
" Enjoy

if &compatible
  set nocompatible
endif
set mouse=a
set encoding=utf8

if has('nvim') || has('termguicolors')
  set termguicolors
endif

let g:dein_repo = 'https://github.com/Shougo/dein.vim.git'
let g:dein_dir = '~/.config/nvim/dein/repos/github.com/Shougo/dein.vim'

if empty(glob(g:dein_dir))
  exec 'silent !mkdir -p '.g:dein_dir
  exec '!git clone '.g:dein_repo.' '.g:dein_dir
endif
exec 'set runtimepath^='.g:dein_dir

call dein#begin(expand('~/.config/nvim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('haya14busa/dein-command.vim')
call dein#add('ervandew/supertab')
call dein#add('roxma/nvim-completion-manager')
call dein#add('roxma/nvim-cm-tern', {'lazy': 1, 'on_ft': ['javascript', 'javascript.jsx'], 'build': 'npm install'})
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('tacahiroy/ctrlp-funky')
call dein#add('scrooloose/nerdtree')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('christoomey/vim-tmux-runner')
call dein#add('lambdalisue/gina.vim') "git manager
call dein#add('tpope/vim-commentary')
call dein#add('w0rp/ale') " lint engine
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-surround')
call dein#add('mattn/emmet-vim')
call dein#add('ntpeters/vim-better-whitespace')
call dein#add('eugen0329/vim-esearch')
call dein#add('roxma/vim-tmux-clipboard')
call dein#add('tpope/vim-obsession')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')
call dein#add('vim-scripts/BufOnly.vim') " delete all buffers but the current
call dein#add('ryanoasis/vim-devicons')
call dein#add('janko-m/vim-test')
call dein#add('embear/vim-localvimrc')
call dein#add('mhinz/vim-startify')
call dein#add('Yggdroot/indentLine')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('jiangmiao/auto-pairs')
call dein#add('luochen1990/rainbow')
"javascript config
call dein#add('pangloss/vim-javascript', {'lazy': 1, 'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('ternjs/tern_for_vim', {'lazy': 1, 'build': 'npm install -g tern', 'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('othree/jspc.vim', {'lazy': 1, 'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('othree/javascript-libraries-syntax.vim', {'lazy': 1, 'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('mxw/vim-jsx', {'lazy': 1, 'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('HerringtonDarkholme/yats.vim')

call dein#add('othree/html5.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('taohexxx/lightline-buffer')
call dein#add('gu-fan/lastbuf.vim')
call dein#add('rakr/vim-one') " theme
call dein#add('challenger-deep-theme/vim') " theme
call dein#add('sjl/gundo.vim') "show undo history as a three

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

set rnu
set noerrorbells
set novisualbell
set expandtab
set tabstop=2
set shiftwidth=2
let mapleader="\<Space>"
set autowrite
set ruler
set wildmenu
set wildmode=list:longest,full
set foldmethod=manual
set clipboard+=unnamedplus
augroup vimrc
  autocmd!
  autocmd GuiEnter * set columns=90 lines=70 number
augroup END
set scrolloff=5
set splitbelow
set splitright
set nobackup
set noswapfile
set wrap
set linebreak
set nolist
set completeopt=longest,menuone,preview
set hid

"JS cofig
let g:used_javascript_libs = 'underscore,react,lodash'
"ternjs config
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
"JSX support
let g:jsx_ext_required = 0

"Testing helpers
let test#strategy = "vtr"
let g:test#preserve_screen = 1
let g:test#runner_commands = ['Jest']

"Git
noremap <leader>gb :Gina blame<CR>
noremap <leader>gs :Gina status<CR>
noremap <leader>gd :Gina diff<CR>
noremap <leader>gl :Gina log<CR>
noremap <leader>gc :Gina commit<CR>
noremap <leader>gp :Gina push<CR>

" NERDTree config
map <Leader>b :NERDTreeToggle<CR>
map <Leader>fnt :NERDTreeFind<CR>
let NERDTreeShowLineNumbers=1

" ctrlp config
" let g:ctrlp_map = '<leader>p'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_dotfiles = 0
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_custom_ignore = {
\ 'dir':  '\.git$\|public$|log\|tmp$\|node_modules$\|bower_components$\|hooks$\|plugins$\|platforms$\|_build$',
\ 'file': '\.so$\|\.dat$|\.DS_Store$|\.lock$|\.snap$'
\ }
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <leader>fu :CtrlPFunky<CR>

" Theming
colorscheme challenger_deep


" Trim whitespace on save: vim-better-whitespace
autocmd BufWritePre * StripWhitespace

" esearch config
let g:esearch = {
\ 'adapter':    'ag',
\ 'backend':    'nvim',
\ 'out':        'win',
\ 'batch_size': 1000,
\ 'use':        ['word_under_cursor', 'hlsearch', 'clipboard'],
\}

" enable supertab <tab> for everything but ultisnippets
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ale config
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_sign_column_always = 1
" lint only on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)
" Jump to errors
nmap <silent> <leader>pe <Plug>(ale_previous_wrap)
nmap <silent> <leader>ne <Plug>(ale_next_wrap)

" OSX stupid backspace fix
set backspace=indent,eol,start

" load local configuraction files
let g:localvimrc_file_directory_only=1 " load only from current dir
let g:localvimrc_persistent=1 " save only the load answers if Y/N uppercase

" change colors for matching parenthesis
let g:rainbow_active = 1

let g:ultisnips_javascript = {
\ 'keyword-spacing': 'always',
\ 'semi': 'never',
\ 'space-before-function-paren': 'always',
\ }

" nerdtree + startify
autocmd VimEnter *
\   if !argc()
\ |   Startify
\ |   NERDTree
\ |   wincmd w
\ | endif

" indent guides
let g:indentLine_char = '¦'
let g:indentLine_enabled = 1
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'startify']
nmap <silent> <leader>ti :IndentLinesToggle<CR>

"Lightline
set noshowmode "hide edit mode
let g:lightline = {
\ 'colorscheme': 'challenger_deep',
\ 'separator': { 'left': '', 'right': '' },
\ 'active': {
\   'left': [['mode', 'paste'], ['gitbranch', 'filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'tabline': {
\   'left': [ [ 'bufferinfo' ],
\             [ 'separator' ],
\             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
\   'right': [ [ 'close' ], ],
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK',
\   'buffercurrent': 'lightline#buffer#buffercurrent',
\   'bufferbefore': 'lightline#buffer#bufferbefore',
\   'bufferafter': 'lightline#buffer#bufferafter',
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'buffercurrent': 'tabsel',
\   'bufferbefore': 'raw',
\   'bufferafter': 'raw',
\ },
\ 'component_function': {
\   'gitbranch': 'gina#component#repo#branch',
\   'bufferinfo': 'lightline#buffer#bufferinfo',
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call lightline#update()

set hidden " allow buffer switching without saving
set showtabline=2 " always show tabline

" lightline-buffer
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20
let g:lightline_buffer_enable_devicons = 1

nnoremap <Leader>[ :bprev<CR>
nnoremap <Leader>] :bnext<CR>
nnoremap <Leader>db :bd<CR>
nnoremap <Leader>cb :bufdo bwipeout<CR>

"remove hightlights
" nnoremap <Leader>rh :noh<CR>
nnoremap <esc> <esc>:noh<return><esc>


" reopen last closed buffer
let g:lastbuf_level=2 "since I'm closing buffers with db

" Map window prefix to ommit W
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"gundo
noremap <leader>tu :GundoToggle<CR>
let g:gundo_prefer_python3 = 1

"multicursors
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<leader>n'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

let g:ascii = [
\' ____  _                   _         ____               _       _',
\'|  _ \(_) ___ __ _ _ __ __| | ___   | __ )  ___ _ __ __| | ___ (_) ___',
\'| |_) | |/ __/ _` | `__/ _` |/ _ \  |  _ \ / _ \ `__/ _` |/ _ \| |/ _ \',
\'|  _ <| | (_| (_| | | | (_| | (_) | | |_) |  __/ | | (_| |  __/| | (_) |',
\'|_| \_\_|\___\__,_|_|  \__,_|\___/  |____/ \___|_|  \__,_|\___|/ |\___/',
\'                                                              |__/'
\]

let g:startify_custom_header = 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")'
