if &compatible
  set nocompatible
endif

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

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
call dein#add('neomake/neomake')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('sheerun/vim-polyglot')
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-surround')
call dein#add('mattn/emmet-vim')
call dein#add('ntpeters/vim-better-whitespace')
call dein#add('tpope/vim-dispatch')
call dein#add('eugen0329/vim-esearch')
call dein#add('morhetz/gruvbox')
call dein#add('roxma/vim-tmux-clipboard')
call dein#add('tpope/vim-obsession')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')


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
" set mouse=a
augroup vimrc
  autocmd!
  autocmd GuiEnter * set columns=120 lines=70 number
augroup END
set scrolloff=5
set splitbelow
set splitright
set nobackup
set noswapfile

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
noremap <leader>w :tabclose<CR>
noremap <leader>t :tabnew<CR>

" Git Support
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
let g:airline_theme='luna'

" Theming
set termguicolors
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast='hard'

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

" neomake
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning

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
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
