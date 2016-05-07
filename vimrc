" Guillaume Couégnat <guillaume.couegnat@gmail.com>

" Preamble {{{
set nocompatible
filetype off
let mapleader = ","
" }}}
" General options {{{
set autoread
set autowrite
set backspace=indent,eol,start
set completeopt=menu
set cursorline
set encoding=utf-8
set laststatus=2
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮
set modeline
set nonumber
" set relativenumber
set scrolloff=3
set visualbell
set undodir=~/.vim/tmp/undo//     " undo files
set nobackup
set noswapfile
set splitright
set splitbelow
" Searching
set hlsearch
set ignorecase
set incsearch
set showmatch
set smartcase
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=.hg,.git,.svn
set wildignore+=*.o,*.obj,*.a
set wildignore+=*.sw?
set wildignore+=*.DS_Store
" Text formating, tabs, etc.
set expandtab
set formatoptions=qrn1
set nowrap
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=80
"}}}
" Plugins {{{
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-sensible'
Plugin 'nanotech/jellybeans.vim'
Plugin 'sjl/badwolf'
Plugin 'chriskempson/base16-vim'
" Plugin 'itchyny/lightline.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'matze/vim-tex-fold'
Plugin 'tpope/vim-commentary'
Plugin 'SirVer/ultisnips.git'
Plugin 'honza/vim-snippets'
Plugin 'Shougo/neocomplete'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
" Plugin 'Yggdroot/indentLine'
Plugin 'junegunn/goyo.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'plasticboy/vim-markdown'
" Plugin 'scrooloose/syntastic'
" Plugin 'hura/vim-asymptote'
call vundle#end()
filetype plugin indent on
"}}}
" Plugins settings {{{
" indentLine {{{
let g:indentLine_enabled = 1
let g:indentLine_showFirstIndentLevel = 1
" }}}
" lightline {{{
" let g:lightline = {
"             \ 'colorscheme': 'wombat',
"             \ 'component': {
"             \   'readonly': '%{&readonly?"✖":""}',
"             \ },
"             \ 'active': {
"             \   'right': [['lineinfo'], ['percent']],
"             \ },
"             \ }
"}}}
" neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_refresh_always = 1
" }}}
" tagbar {{{
nnoremap <leader>t :TagbarToggle<CR>
let g:tagbar_iconchars = ['+', '-']
" }}}
" ultisnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" }}}
"}}}
" Colorscheme & GUI {{{
set t_co=256
syntax enable

set background=dark
colorscheme base16-tomorrow

if has('gui_running')
    set guioptions=""
    set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
    set columns=132
    set lines=999
    if has('gui_macvim')
        " set guifont=Fira\ Mono:h12
        colorscheme base16-tomorrow
        set guifont=Source\ Code\ Pro\ Light:h13
    endif
endif
"}}}
" More options {{{
"   Mapping {{{
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
"   Searching and movement {{{
nnoremap / /\v
vnoremap / /\v
set gdefault
noremap <silent> <leader><space> :noh<cr>

noremap j gj
noremap k gk
noremap gj j
noremap gk k

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
"}}}
"   Folding {{{
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
" Filetype specific {{{
" C++ {{{
au BufNewFile,BufRead,BufEnter *.cpp,*.c++,*.C,*.hpp,*.tpp set filetype=cpp
au BufNewFile,BufRead,BufEnter *.cpp,*.c++,*.C,*.hpp,*.tpp set omnifunc=omni#cpp#complete#Main
" }}}
" Python {{{
augroup ft_python
    au!
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup end
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
" Markdown {{{
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
autocmd BufNewFile,BufRead,BufEnter *.tex set filetype=tex
autocmd BufNewFile,BufRead,BufEnter *.cls set filetype=tex
augroup ft_tex
    au!
    au Filetype tex setlocal conceallevel=0
augroup END
" }}}
"}}}
" Statusline {{{
if has('statusline')
    set statusline=
    set statusline+=[%n]\ %<
    set statusline+=%F
    set statusline+=\ %(%w%m%)
    set statusline+=%=
    set statusline+=%l:%c\ %y
endif
" }}}
