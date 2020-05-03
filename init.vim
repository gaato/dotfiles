" setting
set fenc=utf-8
set encoding=utf-8
set autoread
set hidden
set showcmd

set title
set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set whichwrap=b,s,h,l,<,>,[,],~
syntax enable
set backspace=indent,eol,start
set ambiwidth=double

set display=lastline
set mouse=a

set expandtab
set tabstop=4
set shiftwidth=4
set list
set listchars=tab:^\ ,trail:~

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

nnoremap t j
nnoremap c k
nnoremap n l
nnoremap j c
nnoremap k t
nnoremap l n

inoremap <C-j> <Esc>
inoremap <C-h> <Left>
inoremap <C-t> <Down>
inoremap <C-c> <Up>
inoremap <C-n> <Right>

call plug#begin()
Plug 'easymotion/vim-easymotion'
Plug 'cohama/lexima.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alaviss/nim.nvim'
call plug#end()

map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

map <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

let g:EasyMotion_do_mappnig = 0

nmap <silent> <space><space> :<C-u>CocList<cr>
nmap <silent> <space>h <C-u>call CocAction('doHover')<cr>
nmap <silent> <space>rn <Plug>(coc-rename)

"auto reload .vimrc
augroup surce-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END


" auto comment off
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END


" 編集箇所のカーソルを記憶
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif
