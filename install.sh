mkdir ~/.vim
mkdir ~/.vim/undodir
mkdir ~/.vim/swapdir
mkdir ~/.vim/backupdir
mkdir ~/.nvm
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
