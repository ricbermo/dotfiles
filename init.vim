" Ricardo Berdejo's nvim config file
" Use this for global / shared configs and use
" Don't forget to copy the after folder in ~/.config/nvim/ to add more goodies.
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
call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})

call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('lambdalisue/fern.vim')
call dein#add('lambdalisue/nerdfont.vim')
call dein#add('lambdalisue/fern-renderer-nerdfont.vim')
call dein#add('antoinemadec/FixCursorHold.nvim')
call dein#add('lambdalisue/fern-git-status.vim')

call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-surround')
call dein#add('ntpeters/vim-better-whitespace')
call dein#add('roxma/vim-tmux-clipboard')
call dein#add('christoomey/vim-tmux-runner')
call dein#add('tpope/vim-obsession')
call dein#add('honza/vim-snippets')
call dein#add('vim-scripts/BufOnly.vim') " delete all buffers but the current
call dein#add('ryanoasis/vim-devicons')
call dein#add('janko-m/vim-test')
call dein#add('mhinz/vim-startify')
call dein#add('Yggdroot/indentLine')
call dein#add('jiangmiao/auto-pairs')
call dein#add('othree/html5.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('taohexxx/lightline-buffer')
call dein#add('gu-fan/lastbuf.vim')
call dein#add('eugen0329/vim-esearch')

"javascript config
call dein#add('pangloss/vim-javascript', {'lazy': 1, 'on_ft': ['javascript', 'javascript.jsx', 'javascriptreact']})
call dein#add('maxmellon/vim-jsx-pretty', {'lazy': 1, 'on_ft': ['javascript', 'javascript.jsx', 'javascriptreact']})
call dein#add('HerringtonDarkholme/yats.vim')

" Theming
call dein#add('ap/vim-css-color')
call dein#add('chuling/equinusocio-material.vim')

"Dart/Flutter
call dein#add('dart-lang/dart-vim-plugin', {'on_ft': ['dart']})

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
syntax on

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
set completeopt=noinsert,menuone,noselect
set hid
set cmdheight=2 " Better display for messages
set updatetime=300
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns
set hidden " allow buffer switching without saving
set showtabline=2 " always show tabline
set fillchars+=vert:│ " best vertsplit char

"Get correct comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

"JS cofig
let g:vim_jsx_pretty_colorful_config = 1

"Testing helpers
let test#strategy = "vtr"
let g:test#preserve_screen = 1
let g:test#runner_commands = ['Jest']

" Fern
let g:fern#renderer = "nerdfont"
let g:cursorhold_updatetime = 100
nnoremap <leader>b <cmd>Fern . -drawer -width=40 -toggle<cr>
nnoremap <leader>fnt <cmd>Fern . -drawer -width=40 -toggle -reveal=%<cr>

"Theming
set cursorline
set fillchars+=vert:│

let g:equinusocio_material_style = 'pure'
let g:equinusocio_material_bracket_improved = 1
" let g:equinusocio_material_less = 50
colorscheme equinusocio_material

hi CursorLine  cterm=NONE ctermbg=darkred ctermfg=white guibg=#263238 guifg=NONE
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=#9E9E9E guibg=NONE
hi CursorLineNr guifg=#F4511E
" change colors for matching parenthesis
" let g:rainbow_active = 1


"FZF Settings

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

nnoremap <c-p> :Files<cr>

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" Trim whitespace on save: vim-better-whitespace
autocmd BufWritePre * StripWhitespace

" OSX stupid backspace fix
set backspace=indent,eol,start

" Startify
autocmd VimEnter *
\   if !argc()
\ |   Startify
\ |   wincmd w
\ | endif

" indent guides
let g:indentLine_char = '¦'
let g:indentLine_enabled = 1
let g:indentLine_fileTypeExclude = ['help', 'startify']
nmap <silent> <leader>ti :IndentLinesToggle<CR>

"Lightline
set noshowmode "hide edit mode

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

function! LightlineGit()
  return get(g:, 'coc_git_status', '')
endfunction

let g:airline_theme = 'equinusocio_material'
let g:lightline = {
\ 'colorscheme': 'equinusocio_material',
\ 'separator': { 'left': '', 'right': '' },
\ 'active': {
\   'left': [['mode', 'paste'], ['gitbranch', 'filename', 'currentfunction', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'cocstatus']]
\ },
\ 'tabline': {
\   'left': [ [ 'bufferinfo' ],
\             [ 'separator' ],
\             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
\   'right': [ [ 'close' ], ],
\ },
\ 'component_expand': {
\   'buffercurrent': 'lightline#buffer#buffercurrent',
\   'bufferbefore': 'lightline#buffer#bufferbefore',
\   'bufferafter': 'lightline#buffer#bufferafter',
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'buffercurrent': 'tabsel',
\   'bufferbefore': 'raw',
\   'bufferafter': 'raw',
\ },
\ 'component_function': {
\   'gitbranch': 'LightlineGit',
\   'bufferinfo': 'lightline#buffer#bufferinfo',
\   'cocstatus': 'coc#status',
\   'currentfunction': 'CocCurrentFunction'
\ },
\ }

" autocmd User CocGitStatusChange {command}


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
nnoremap <silent> <esc> <esc>:noh<return><esc>

" reopen last closed buffer
let g:lastbuf_level=2 "since I'm closing buffers with db

" Map window prefix to ommit W
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Vim-Test Mappings
nmap <silent> <leader>s :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>

" toggle css colors
nnoremap <silent><leader>tc :call css_color#toggle()<CR>

"CoC Config
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()


inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <silent> <leader>fp :Prettier<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

let g:coc_status_error_sign='❌ '
let g:coc_status_warning_sign='⚠️  '

" Example: `<leader>aap` for current paragraph, <leader>aw for the current word
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:ascii = [
\' ____  _                   _         ____               _       _',
\'|  _ \(_) ___ __ _ _ __ __| | ___   | __ )  ___ _ __ __| | ___ (_) ___',
\'| |_) | |/ __/ _` | `__/ _` |/ _ \  |  _ \ / _ \ `__/ _` |/ _ \| |/ _ \',
\'|  _ <| | (_| (_| | | | (_| | (_) | | |_) |  __/ | | (_| |  __/| | (_) |',
\'|_| \_\_|\___\__,_|_|  \__,_|\___/  |____/ \___|_|  \__,_|\___|/ |\___/',
\'                                                              |__/'
\]

let g:startify_custom_header = 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")'
