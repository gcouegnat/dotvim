dotvim
======

What ?
------
My vim dotfiles

To install
----------
    git clone http://github.com/gcouegnat/vim.git ~/.vim
    mkdir -p ~/.vim/tmp/{backup,swap,undo}
    mkdir -p ~/.vim/bundle
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    ln -sf ~/.vim/vimrc ~/.vimrc
    vim +BundleInstall
