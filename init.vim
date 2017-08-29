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

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:dein_repo = 'https://github.com/Shougo/dein.vim.git'
let g:dein_dir = '~/.config/nvim/dein/repos/github.com/Shougo/dein.vim'

if empty(glob(g:dein_dir))
  exec 'silent !mkdir -p '.g:dein_dir
  exec '!git clone '.g:dein_repo.' '.g:dein_dir
endif
exec 'set runtimepath^='.g:dein_dir

call dein#begin(expand('~/.config/nvim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('ervandew/supertab')
call dein#add('Shougo/deoplete.nvim')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('benmills/vimux')
call dein#add('tpope/vim-dispatch')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-commentary')
call dein#add('w0rp/ale') " lint engine
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('sheerun/vim-polyglot')
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
call dein#add('ternjs/tern_for_vim', {'build': 'npm install -g tern', 'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('carlitux/deoplete-ternjs', {'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('othree/jspc.vim', {'on_ft': ['javascript', 'javascript.jsx']})
call dein#add('Raimondi/delimitMate')

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
let mapleader=","
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

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<CR>
noremap <leader>w :bd<CR>
noremap <leader>tn :tabnew<CR>

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
let g:ctrlp_custom_ignore = {
\ 'dir':  '\.git$\|public$|log\|tmp$\|node_modules$\|bower_components$\|hooks$\|plugins$\|platforms$\|_build$',
\ 'file': '\.so$\|\.dat$|\.DS_Store$|\.lock$'
\ }

" Airline config
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_theme='one'
call airline#parts#define_function('ALE', 'ALEGetStatusLine')
call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
let g:airline_section_error = airline#section#create_right(['ALE'])
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Theming
" colorscheme gruvbox
" set background=dark
" let g:gruvbox_contrast='hard'
colorscheme one
set background=dark
let g:one_allow_italics = 1

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

" disable poliglot langs
let g:polyglot_disabled = [
\ 'applescript',
\ 'ansible',
\ 'arduino',
\ 'c++11',
\ 'c/c++',
\ 'clojure',
\ 'cryptol',
\ 'crystal',
\ 'cql',
\ 'cucumber',
\ 'dart',
\ 'elm',
\ 'emberscript',
\ 'emblem',
\ 'fish',
\ 'glsl',
\ 'go',
\ 'groovy',
\ 'handlebars',
\ 'haskell',
\ 'haxe',
\ 'jst',
\ 'julia',
\ 'kotlin',
\ 'latex',
\ 'livescript',
\ 'lua',
\ 'mako',
\ 'nginx',
\ 'nim',
\ 'nix',
\ 'objc',
\ 'ocaml',
\ 'octave',
\ 'opencl',
\ 'perl',
\ 'pgsql',
\ 'plantuml',
\ 'powershell',
\ 'protobuf',
\ 'pug',
\ 'puppet',
\ 'purescript',
\ 'qml',
\ 'r-lang',
\ 'raml',
\ 'ragel',
\ 'rust',
\ 'sbt',
\ 'scala',
\ 'slim',
\ 'solidity',
\ 'stylus',
\ 'systemd',
\ 'textile',
\ 'thrift',
\ 'tomdoc',
\ 'toml',
\ 'twig',
\ 'vala',
\ 'vbnet',
\ 'vcl',
\ 'vm',
\ 'xls',
\ 'yard',
\]

" enable deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['buffer', 'file', 'ultisnips', 'ternjs']
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:SuperTabClosePreviewOnPopupClose = 1

" enable supertab <tab> for everything but ultisnippets
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

" delete all buffers
nmap <silent> <leader>bD :BufOnly<CR>
" close preview
noremap <leader>pc :pclose<CR>

let g:ascii = [
\' ____  _                   _         ____               _       _',
\'|  _ \(_) ___ __ _ _ __ __| | ___   | __ )  ___ _ __ __| | ___ (_) ___',
\'| |_) | |/ __/ _` | `__/ _` |/ _ \  |  _ \ / _ \ `__/ _` |/ _ \| |/ _ \',
\'|  _ <| | (_| (_| | | | (_| | (_) | | |_) |  __/ | | (_| |  __/| | (_) |',
\'|_| \_\_|\___\__,_|_|  \__,_|\___/  |____/ \___|_|  \__,_|\___|/ |\___/',
\'                                                              |__/'
\]

let g:startify_custom_header = 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")'
