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

if (has("termguicolors"))
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
call dein#add('scrooloose/nerdtree')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('benmills/vimux')
call dein#add('tpope/vim-dispatch')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-commentary')
call dein#add('w0rp/ale') " lint engine
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-surround')
call dein#add('mattn/emmet-vim')
call dein#add('ntpeters/vim-better-whitespace')
call dein#add('eugen0329/vim-esearch')
call dein#add('morhetz/gruvbox') " theme
call dein#add('rakr/vim-one') " theme
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
call dein#add('ternjs/tern_for_vim', {'lazy': 1, 'build': 'npm install -g tern', 'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('othree/jspc.vim', {'lazy': 1, 'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('jiangmiao/auto-pairs')
call dein#add('luochen1990/rainbow')
call dein#add('othree/javascript-libraries-syntax.vim')
call dein#add('othree/yajs.vim')
call dein#add('mxw/vim-jsx')
call dein#add('othree/html5.vim')
call dein#add('HerringtonDarkholme/yats.vim')
call dein#add('mhartington/oceanic-next') "theme
call dein#add('itchyny/lightline.vim')
call dein#add('taohex/lightline-buffer')
call dein#add('Rykka/lastbuf.vim')
call dein#add('dracula/vim') "theme

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

set termguicolors
set rnu
set noerrorbells
set novisualbell
set expandtab
set softtabstop=2
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

"git
noremap <leader>gb :Gblame<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gd :Gdiff<CR>
noremap <leader>gl :Glog<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gp :Git push<CR>

" NERDTree config
map <Leader>b :NERDTreeToggle<CR>
map <Leader>fnt :NERDTreeFind<CR>
let NERDTreeShowLineNumbers=1

" ctrlp config
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_use_caching = 0
let g:ctrlp_custom_ignore = {
\ 'dir':  '\.git$\|public$|log\|tmp$\|node_modules$\|bower_components$\|hooks$\|plugins$\|platforms$\|_build$',
\ 'file': '\.so$\|\.dat$|\.DS_Store$|\.lock$'
\ }
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <leader>f :CtrlPFunky<CR>

" Theming
syntax on
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" colorscheme OceanicNext
color dracula

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

"ternjs config
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
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

" OSX stupid backspace fix
set backspace=indent,eol,start

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

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

"JSX support
let g:jsx_ext_required = 0

"Lightline
let g:lightline = {
\ 'colorscheme': 'Dracula',
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
\   'gitbranch': 'LightlineFugitive',
\   'bufferinfo': 'lightline#buffer#bufferinfo',
\ },
\ }

function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

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

nnoremap <Leader>[ :bprev<CR>
nnoremap <Leader>] :bnext<CR>
nnoremap <Leader>db :bd<CR>


" reopen last closed buffer
let g:lastbuf_level=2 "since I'm closing buffers with db

" Map window prefix to ommit W
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

let g:ascii = [
\' ____  _                   _         ____               _       _',
\'|  _ \(_) ___ __ _ _ __ __| | ___   | __ )  ___ _ __ __| | ___ (_) ___',
\'| |_) | |/ __/ _` | `__/ _` |/ _ \  |  _ \ / _ \ `__/ _` |/ _ \| |/ _ \',
\'|  _ <| | (_| (_| | | | (_| | (_) | | |_) |  __/ | | (_| |  __/| | (_) |',
\'|_| \_\_|\___\__,_|_|  \__,_|\___/  |____/ \___|_|  \__,_|\___|/ |\___/',
\'                                                              |__/'
\]

let g:startify_custom_header = 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")'
