if &compatible
  set nocompatible
endif
set encoding=utf8
set nowrap

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
call dein#add('benmills/vimux')
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
call dein#add('tpope/vim-dispatch')
call dein#add('eugen0329/vim-esearch')
call dein#add('morhetz/gruvbox') " theme
call dein#add('rakr/vim-one') " theme
call dein#add('roxma/vim-tmux-clipboard')
call dein#add('tpope/vim-obsession')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')
call dein#add('sbdchd/neoformat')
call dein#add('vim-scripts/BufOnly.vim') " delete all buffers but the current
call dein#add('ryanoasis/vim-devicons')


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
set tabstop=2
let mapleader=","
set autowrite
set ruler
set wildmenu
set wildmode=list:longest,full
set foldmethod=syntax
set foldlevel=9
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
noremap <leader>t :tabnew<CR>

noremap <leader>gb :Gblame<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gd :Gdiff<CR>
noremap <leader>gl :Glog<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gp :Git push<CR>

" Vimux mapping
" map <Leader>tj :call VimuxRunCommand("clear; npm test")<CR>
" map <Leader>rr :call VimuxRunCommand('clear; rspec ' . bufname('%'))<CR>

" Vim-dispatch -> to be replaced by asyncrun.vim when Vim 8
map <Leader>rr :Dispatch clear; rspec %<CR>
map <Leader>tr :Dispatch clear; npm test %<CR>

" NERDTree config
map <Leader>b :NERDTreeToggle<CR>
map <Leader>fnt :NERDTreeFind<CR>

" ctrlp config
let g:ctrlp_custom_ignore = {
\ 'dir':  '\.git$\|public$|log\|tmp$\|node_modules$\|bower_components$\|hooks$\|plugins$\|resources$\|platforms$\|_build$',
\ 'file': '\.so$\|\.dat$|\.DS_Store$'
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
\ 'swift',
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
set completeopt=longest,menuone,preview

" enable supertab <tab> for everything but ultisnippets
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" prettier formatting tool
autocmd FileType javascript set formatprg=prettier-eslint\ --stdin
autocmd BufWritePre *.js Neoformat
let g:neoformat_only_msg_on_error = 1
let g:neoformat_try_formatprg = 1

" ale config
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_sign_column_always = 1
" lint only on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0


" OSX stupid backspace fix
set backspace=indent,eol,start

