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
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on         " Turn on file type detection.

" }}}

" Bundle management {{{

" can't get with git protocol through firewall at work
let g:vundle_default_git_proto = 'http'
Bundle 'gmarik/vundle'

"Bundle 'Raimondi/delimitMate'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'fugitive.vim'
"Bundle 'git.zip'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/badwolf'
"Bundle 'skwp/vim-powerline'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'vim-scripts/ack.vim'
Bundle 'wgibbs/vim-irblack'
Bundle 'Tabular'
Bundle 'klen/python-mode'
" }}}

" Basic options {{{

set encoding=utf-8
lang en_US.UTF-8
set showcmd
set showmode
set backspace=indent,eol,start
set hidden
set cursorline
set wildmenu
set ignorecase
set smartcase
set number
set ruler
set incsearch
set hlsearch
set laststatus=2
set history=1000
set undofile
set undoreload=10000
set wrap
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
set wrap
set textwidth=80
set formatoptions=qrn1
"set colorcolumn=+1

" }}}

" Backups {{{

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile

" }}}

" Leader {{{

let mapleader = ","
let maplocalleader = ";;"

" }}}

" Colorscheme {{{

syntax on
set t_Co=256
set background=dark
colorscheme badwolf

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" Abbreviations {{{

iabbrev gc@ Guillaume Couégnat <guillaume.couegnat@gmail.com>
iabbrev lcts@ Guillaume Couégnat <couegnat@lcts.u-bordeaux1.fr>

" }}}

" GUI {{{

if has('gui_running')

    set guioptions=egmrt
    set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

    set background=dark
    colorscheme twilight

    if has('gui_macvim')
        set guifont=DejaVuSansMono:h14
        "set guifont=Inconsolata:h16
        set transparency=5
    endif
endif

" }}}

" Mapping {{{

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" some more stuff
nnoremap <leader>v :e! ~/.vim/vimrc<cr>
noremap <leader><space> :nohlsearch<CR><CR>

" }}}

" Searching and movement {{{

nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

noremap <silent> <leader><space> :noh<cr>

runtime macros/matchit.vim

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

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
" }}}

" Filetype specific {{{

" Vim {{{
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
augroup end
" }}}

" SCons {{{
autocmd bufnewfile,bufread SCons* setfiletype python
" }}}

" }}}

" Plugin settings {{{

" NERDTree {{{
map <leader>n :NERDTreeToggle<cr>
" }}}

" Tagbar {{{{
map <leader>t :TagbarToggle<cr>
" }}}

" Ctrp-P {{{
let g:ctrlp_working_path_mode = 2
" }}}

" Powerline {{{
if has('gui_macvim')
    let g:Powerline_symbols='fancy'
else
    let g:Powerline_symbols = 'compatible'
endif
let g:Powerline_cache_enabled = 0
" }}}

" OmniCppComplete {{{
set ofu=syntaxcomplete#Complete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_SelectFirstItem= 1
" }}}

" SuperTab {{{

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1

" }}}

" Python-mode {{{
let g:pymode_doc = 0
let g:pymode_run = 0
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_folding = 0
let g:pymode_utils = 0
let g:pymode_utils_whitespaces = 0
let g:pymode_syntax = 0
let g:pymode_options_indent = 0
let g:pymode_options_other = 0
" }}}

" }}}

set tags+=~/.vim/ctags/codapp.ctags






