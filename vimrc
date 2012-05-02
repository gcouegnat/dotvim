set nocompatible                  " Must come first because it changes other options.
filetype off

"silent! call pathogen#runtime_append_all_bundles()
"silent! call pathogen#helptags()

let g:vundle_default_git_proto = 'http'
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'git.zip'
Bundle 'fugitive.vim'

Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/OmniCppComplete'    

Bundle 'vim-scripts/ack.vim'
Bundle 'ervandew/supertab'
Bundle 'skwp/vim-powerline'

"Bundle 'Command-T' 
Bundle 'kien/ctrlp.vim'
"Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/snipmate.vim'
"Bundle 'shougo/neocomplcache'
Bundle 'majutsushi/tagbar'

"Bundle 'AutoClose'
Bundle 'tpope/vim-surround'

"{{{ Colors
Bundle 'altercation/vim-colors-solarized'
Bundle 'sjl/badwolf'
Bundle 'vim-scripts/Lucius'
"Bundle 'vim-scripts/freya'
"Bundle 'nanotech/jellybeans.vim'
Bundle 'wgibbs/vim-irblack'
"Bundle 'gregsexton/Atom'
"}}}

filetype plugin indent on         " Turn on file type detection.
syntax enable                     " Turn on syntax highlighting.

runtime macros/matchit.vim        " Load the matchit plugin.
language en_US

set t_Co=256

set showcmd                       " Display incomplete commands.
set showmode                    " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

" UNCOMMENT TO USE
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

"set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P


" --- Color theme ---
"let g:lucius_style = "light"
"colorscheme lucius
"colorscheme badwolf
set background=dark
colorscheme solarized

if has('gui_running')
    "set guifont=Menlo:h14
    set guifont=Menlo\ for\ Powerline:h12
    let g:Powerline_symbols='fancy'
    set guioptions=egmrt
    "let g:lucius_style = 'dark'
    "colorscheme lucius
    set background=light
    colorscheme solarized
endif

let mapleader = ","

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Uncomment to use Jamis Buck's file opening plugin
"map <Leader>t :FuzzyFinderTextMate<Enter>

" Controversial...swap colon and semicjolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
autocmd BufNewFile,BufRead *_spec.rb compiler rspec
autocmd bufnewfile,bufread SCons* setfiletype python

map <leader>n :NERDTreeToggle<cr>
" map <leader>b :TlistToggle<cr>
map <leader>v :e! ~/.vim/vimrc<cr>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
map <leader>t :TagbarToggle<cr>

autocmd BufWritePost vimrc source ~/.vim/vimrc

nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>


"nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
"nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>q gqip
nnoremap <leader>w <C-w>v<C-w>l

"set ofu=syntaxcomplete#Complete
"set completeopt=longest,menuone

"let g:neocomplcache_enable_at_startup = 1
"set tags+=~/.vim/ctags/coda.ctags
set tags+=~/.vim/ctags/codapp.ctags

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
set ofu=syntaxcomplete#Complete

set wildignore+=*.o,*.a,./doc/**
