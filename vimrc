".vimrc
"
" Author: Guillaume Couégnat <guillaume.couegnat@gmail.com>
"
" Heavily inspired by Steve Losh's vim config
" http://bitbucket.org/sjl/dotfiles/src/tip/vim/
"

" Premable {{{
filetype off
set nocompatible
" }}}

" Basic options {{{
set encoding=utf-8
"lang en_US.UTF-8
set showcmd
set showmode
set backspace=indent,eol,start
set hidden
set cursorline
set wildmenu
set ignorecase
set smartcase
set nonumber
set ruler
set incsearch
set hlsearch
set laststatus=2
set history=1000
set undofile
set undoreload=10000
set scrolloff=3
set title
set visualbell
set nolist
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set showbreak=↪
set shell=/bin/bash
set autoread
set autowrite
set completeopt=longest,menuone,preview
au FocusLost * :silent! wall
" }}}

" Bundle management {{{
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" vundle
Bundle 'gmarik/vundle'
let g:vundle_default_git_proto = 'http'

" colors
Bundle 'altercation/vim-colors-solarized'
Bundle 'sjl/badwolf'

" misc
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'

Bundle 'bling/vim-airline'

"Bundle 'Shougo/vimproc.vim'
"Bundle 'Shougo/vimshell.vim'

Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'msanders/snipmate.vim'
"Bundle 'davidhalter/jedi-vim'
"Bundle 'mattn/emmet-vim'

Bundle 'tshirtman/vim-cython'
Bundle 'tpope/vim-vinegar'

Bundle "sdanielf/vim-stdtabs"
Bundle "ntpeters/vim-better-whitespace"
"Bundle 'matze/vim-tex-fold'
" }}}

" Wildmenu completion {{{
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn
set wildignore+=*.o,*.obj,*.a
set wildignore+=*.sw?
set wildignore+=*.DS_Store
" }}}

" Tabs, spaces, wrapping {{{
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set nowrap
set textwidth=80
set formatoptions=qrn1
" }}}

" Backups {{{
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile
" }}}

" Leader key {{{
let mapleader = ","
let maplocalleader = ";;"
" }}}

" Colorscheme {{{
syntax enable
"set t_co=256
"let g:solarized_termtrans=1
set background=dark
colorscheme badwolf
" }}}

" Abbreviations {{{
iabbrev ccopy Copyright 2014, Guillaume Couégnat
" }}}

" GUI {{{
if has('gui_running')
    set guioptions=egmrt
    set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
    set background=dark
    colorscheme solarized
    if has('gui_macvim')
        set transparency=2
        set guifont=Inconsolata\ XL:h12
        set linespace=1
    endif
endif
" }}}

" Mapping {{{
" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z
" some more stuff
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
noremap <leader><space> :nohlsearch<CR><CR>
" Alignment
nnoremap <leader>a= :Tabular /=<CR>
nnoremap <leader>cd :cd %:h<cr>

" }}}

" Searching and movement {{{
nnoremap / /\v
vnoremap / /\v
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
noremap <silent> <leader><space> :noh<cr>

"map <Left>  :echo "no!"<cr>
"map <Right> :echo "no!"<cr>
"map <Up>    :echo "no!"<cr>
"map <Down>  :echo "no!"<cr>

noremap j gj
noremap k gk
noremap gj j
noremap gk k

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" }}}

" Folding {{{

set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za

" from Steve Losh
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 4 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '.' . repeat("-",fillcharcount) . foldedlinecount . '.' . ' '
endfunction " }}}

set foldtext=MyFoldText()
" }}}

" Filetype specific {{{
filetype plugin indent on         " Turn on file type detection.

" C++ {{{
au BufNewFile,BufRead,BufEnter *.cpp,*.c++,*.C,*.hpp,*.tpp set omnifunc=omni#cpp#complete#Main
au BufNewFile,BufRead,BufEnter *.cpp,*.c++,*.C,*.hpp,*.tpp set filetype=cpp
" }}}

" Vim {{{
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    augroup end
" }}}

" SCons {{{
autocmd bufnewfile,bufread SCons* set filetype=python
" }}}

" Ninja {{{
autocmd bufnewfile,bufread *.ninja set filetype=ninja
" }}}

" Octave {{{
augroup filetypedetect
    au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup end

if has("autocmd") && exists("+omnifunc")
    autocmd Filetype octave
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif
" }}}

" Markdown {{{
autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown
" }}}

" Gnuplot {{{
autocmd BufNewFile,BufRead *.gp,*.gnuplot set filetype=gnuplot
" }}}

" Gmsh {{{
autocmd BufNewFile,BufRead *.geo set filetype=gmsh
" }}}

" LaTeX {{{
autocmd BufNewFile,BufRead *.tex set filetype=tex
"autocmd BufNewFile,BufRead *.tex colors eclipse
" }}}

"}}}

" Plugin settings {{{

" NERDTree {{{
noremap <leader>n :NERDTreeToggle<cr>
" }}}

" airline {{{
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" }}}

" tagbar {{{
nnoremap <leader>t :TagbarToggle<CR>
let g:tagbar_iconchars = ['+', '-']
" }}}

" CtrlP {{{
nnoremap <C-t> :CtrlPTag<CR>
" }}}


" }}}
