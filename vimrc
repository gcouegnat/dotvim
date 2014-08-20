" Guillaume Couégnat <guillaume.couegnat@gmail.com>

" Basic options {{{
filetype off
set nocompatible
set encoding=utf-8
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
set undoreload=1000
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
" Leader key {{{
let mapleader = ","
let maplocalleader = ";;"
" }}}
" Plugins {{{
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Plugin 'gmarik/vundle'
let g:vundle_default_git_proto = 'http'
    " Colors {{{
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'sjl/badwolf'
    Plugin 'tomasr/molokai'
    Plugin 'chriskempson/base16-vim'
    "}}}
    " Misc {{{
    Plugin 'kien/ctrlp.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'majutsushi/tagbar'
    Plugin 'godlygeek/tabular'
    Plugin 'bling/vim-airline'
    Plugin 'paranoida/vim-airlineish'
    Plugin 'ervandew/supertab'
    Plugin 'msanders/snipmate.vim'
    Plugin 'terryma/vim-expand-region'
    "}}}
    " Languages {{{
    Plugin 'tshirtman/vim-cython'
    Plugin 'sheerun/vim-polyglot'
    " }}}
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
"
"}}}
" Backups {{{
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set backup                        " enable backups
set noswapfile
"
"}}}
" Colorscheme {{{
syntax enable
set t_co=256
"let g:solarized_termtrans=1
set background=light
colorscheme solarized
"
"}}}
" GUI {{{
if has('gui_running')
    set guioptions=egmrt
    set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
    set background=dark
    colorscheme molokai
    if has('gui_macvim')
        "set guifont=Inconsolata\ for\ Powerline:h14
        set guifont=InputMonoNarrow-Light:h12
        set linespace=2
    endif
endif
"
"}}}
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
" Swap background
" http://tilvim.com/2013/07/31/swapping-bg.html
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nnoremap <leader>o :CtrlP<CR>
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
"
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
"Folding {{{

set foldlevelstart=1
nnoremap <Space> za
vnoremap <Space> za

" from Steve Losh
function! MyFoldText() " {{{
    let line = getline(v:foldstart)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')
    let line = strpart(line, 0, windowwidth - 4 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '.' . repeat("-",fillcharcount) . foldedlinecount . '.' . ' '
endfunction " }}}
set foldtext=MyFoldText()
"
"}}}
"Filetype specific {{{
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
" Plugin settings {{{
    " NERDTree {{{
    noremap <leader>n :NERDTreeToggle<cr>
    " }}}
    " airline {{{

    if has('gui_macvim')
        let g:airline_theme = 'molokai'
    else
        let g:airline_theme = 'solarized'
    end
    let g:airline_powerline_fonts = 0
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    let g:airline_section_z=''
    " }}}
    " tagbar {{{
    nnoremap <leader>t :TagbarToggle<CR>
    let g:tagbar_iconchars = ['+', '-']
    " }}}
    " CtrlP {{{
    nnoremap <C-t> :CtrlPTag<CR>
    " }}}
" }}}
