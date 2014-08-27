vim
======

What ?
------
My vim dotfiles

How to install
--------------
    git clone https://github.com/gcouegnat/vim.git ~/.vim
    mkdir -p ~/.vim/tmp/{backup,swap,undo}
    mkdir -p ~/.vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    ln -sf ~/.vim/vimrc ~/.vimrc
    vim +BundleInstall +qall
