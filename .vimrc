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

nnoremap [ -
nnoremap { _
nnoremap ] =
nnoremap } +

nnoremap ' q
nnoremap " Q
nnoremap , w
nnoremap < W
nnoremap . e
nnoremap > E
nnoremap p r
nnoremap P R
nnoremap y t
nnoremap Y T
nnoremap f y
nnoremap F Y
nnoremap g u
nnoremap G U
nnoremap c i
nnoremap C I
nnoremap r o
nnoremap R O
nnoremap l p
nnoremap L P
nnoremap / [
nnoremap ? {
nnoremap = ]
nnoremap + }

nnoremap o s
nnoremap O S
nnoremap e d
nnoremap E D
nnoremap u f
nnoremap U F
nnoremap i g
nnoremap I G
nnoremap d h
nnoremap D H
nnoremap h j
nnoremap H J
nnoremap t k
nnoremap T K
nnoremap n l
nnoremap N L
nnoremap s ;
nnoremap S :
nnoremap - '
nnoremap _ "

nnoremap ; z
nnoremap : ZZ
nnoremap q x
nnoremap Q X
nnoremap j c
nnoremap J C
nnoremap k v
nnoremap K V
nnoremap x b
nnoremap X B
nnoremap b n
nnoremap B N
nnoremap w ,
nnoremap W <
nnoremap v .
nnoremap V >
nnoremap z /
nnoremap Z ?

" auto reload .vimrc
augroup source-vimrc
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
