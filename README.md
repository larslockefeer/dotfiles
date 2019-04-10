# Usage

# Clone this repository in your home repository
# `mv dotfiles .dotfiles && cd dotfiles`
# `./make.sh`

This will sync all dotfiles in this repository.

# Contents

## Vim and NeoVim

I use Vim and NeoVim interchangeably, in an attemt to find out what works best. As a plugin manager, I use the excellent vim-plug to manage plugins for both of them.

Installation of NeoVim and vim-plug:

```
brew install neovim/neovim/neovim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Plugins

* Goyo for focused writing
* vim-markdown for Markdown support
* vim-sensible for sensible defaults
* nerdtree for file system navigation
* tagbar for source code navigation (depends on ctags, and a ~/.ctags file for some languages)
* gist-vim for Gist integration
* vim-ruby for Ruby support
* yats for Typescript support

See http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/ for the approach taken. This is very much a work in progress.
