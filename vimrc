" Guillaume Couégnat <guillaume.couegnat@gmail.com>

set nocompatible
filetype off

" # Leader key {{{
let mapleader = ","
let maplocalleader = ";;"
" }}}
" # Plugins {{{
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'gmarik/vundle'
" ## Colorscheme {{{
Plugin 'altercation/vim-colors-solarized'
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'
Plugin 'croaker/mustang-vim'
Plugin 'reedes/vim-colors-pencil'
Plugin 'nanotech/jellybeans.vim'
Plugin 'noahfrederick/vim-hemisu'
" }}}
" ## General usage {{{
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-endwise'
Plugin 'Yggdroot/indentLine'
Plugin 'itchyny/lightline.vim'
" }}}
" ## Syntax {{{
Plugin 'tshirtman/vim-cython'
Plugin 'sheerun/vim-polyglot'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'plasticboy/vim-markdown'
"Plugin 'vim-pandoc/vim-pandoc'
"Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'lervag/vimtex'
" Plugin 'scrooloose/syntastic'
" }}}
call vundle#end()
filetype plugin indent on
" }}}
" # Basic options {{{
set autoread
set autowrite
set backspace=indent,eol,start
set completeopt=longest,menuone,preview
set cursorline
set encoding=utf-8
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set nolist
set number
set numberwidth=4
set relativenumber
set ruler
set scrolloff=3
set shell=/bin/bash
set showbreak=↪
set showcmd
set showmode
set smartcase
set title
set undofile
set undoreload=1000
set visualbell
au FocusLost * :silent! wall

set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn
set wildignore+=*.o,*.obj,*.a
set wildignore+=*.sw?
set wildignore+=*.DS_Store

set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set nowrap
set textwidth=80
set formatoptions=qrn1

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set backup                        " enable backups
set noswapfile

"}}}
" # Colorscheme & GUI {{{
set t_co=256
syntax enable
set background=dark
colorscheme hemisu

if has('gui_running')
    set guioptions=egmrt
    set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
    if has('gui_macvim')
        set guifont=Inconsolata:h14
    endif
endif
"}}}
" # More options {{{
" Mapping {{{
" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z
" some more stuff
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
noremap <leader><space> :nohlsearch<CR><CR>
nnoremap <leader>cd :cd %:h<cr>
" Swap background
" http://tilvim.com/2013/07/31/swapping-bg.html
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nnoremap <leader>o :CtrlP<CR>
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
"}}}
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
"}}}
" Folding {{{
set foldlevelstart=1
nnoremap <Space> za
vnoremap <Space> za
" from Steve Losh
function! MyFoldText()
    let line = getline(v:foldstart)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')
    let line = strpart(line, 0, windowwidth - 4 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '.' . repeat("-",fillcharcount) . foldedlinecount . '.' . ' '
endfunction
set foldtext=MyFoldText()
"}}}
" }}}
" # Filetype specific {{{
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
" Markdown {{{
autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown
autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown
augroup ft_markdown
    au!
    au FileType markdown setlocal linespace=2
augroup end
" }}}
" Gnuplot {{{
autocmd BufNewFile,BufRead *.gp,*.gnuplot set filetype=gnuplot
" }}}
" Gmsh {{{
autocmd BufNewFile,BufRead *.geo set filetype=gmsh
" }}}
" LaTeX {{{
autocmd BufNewFile,BufRead *.tex set filetype=tex
" }}}
"}}}
" # Plugins settings {{{
" ## Tagbar {{{
nnoremap <leader>t :TagbarToggle<CR>
let g:tagbar_iconchars = ['+', '-']
" }}}
" indentLine {{{ 
let g:indentLine_enabled = 1
let g:indentLine_showFirstIndentLevel = 1
" }}}
" }}}
