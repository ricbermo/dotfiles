set nocompatible
set term=screen-256color
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle/plugins')

" let vundle manage vundle
Plugin 'VundleVim/Vundle.vim'

"list all plugins that you'd like to install here
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plugin 'scrooloose/nerdtree' " file drawer, open with :NERDTreeToggle
Plugin 'benmills/vimux'
Plugin 'tpope/vim-fugitive' " the ultimate git helper
Plugin 'tpope/vim-commentary' " comment/uncomment lines with gcc or gc in  visual mode
Plugin 'scrooloose/syntastic'
Plugin 'dracula/vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'pangloss/vim-javascript'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-dispatch'
Plugin 'rking/ag.vim'

call vundle#end()

" General VIM config
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
" Menu for autocomplete for a path
set wildmenu
set wildmode=list:longest,full
" Set columns, lines and line numbers
augroup vimrc
  autocmd!
  autocmd GuiEnter * set columns=120 lines=70 number
augroup END

" don't scroll off the edge of the page
set scrolloff=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Disable vim backups
set nobackup

" Disable swapfile
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
\ 'dir':  '\.git$\|public$|log\|tmp$\|node_modules$\|bower_components$\|hooks$\|plugins$\|resources$\|platforms$',
\ 'file': '\.so$\|\.dat$|\.DS_Store$'
\ }

" Airline config
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_theme='luna'

" Theming
syntax on
color molokai
let g:molokai_original = 1

" Syntastic config
set updatetime=250
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
" let s:eslint_path =system('PATH=$(npm bin):$PATH && which eslint')
" let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" Trim whitespace on save: vim-better-whitespace
autocmd BufWritePre * StripWhitespace
