#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

install_cask () {
  if brew info $1 | grep -q "Not installed"; then
    echo "Installing $1"
    brew install --cask $1
  else
    echo "Skipping $1 because it is already installed";
  fi
}

install_formula () {
  if brew info $1 | grep -q "Not installed"; then
    echo "Installing $1"
    brew install $1
  else
    echo "Skipping $1 because it is already installed";
  fi
}

# Oh my ZSH
which zsh >/dev/null 2>&1 || (
  echo "Installing zsh";
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Change default shell
  echo "Changing the default shell to zsh";
  echo "$(which zsh)" | sudo tee -a /etc/shells
  chsh -s $(which zsh)
)

# Homebrew + dependencies
which brew >/dev/null 2>&1 || (
  echo "Installing Homebrew";
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
)

# Special taps
brew tap mongodb/brew

# Consider: android-sdk
casks="iterm2 visual-studio-code alfred slack intellij-idea phoenix karabiner-elements spotify"
for i in $casks
do
  install_cask $i
done

# Consider: tmux
formulae="spaceship zplug gnupg gnupg2 thefuck jabba maven gradle jq xmlstarlet nvm yarn mongodb-community@5.0"
for i in $formulae
do
  install_formula $i
done

# Post-install nvm things
mkdir -p ~/.nvm
nvm install node



# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

# RVM & Ruby 2.3.0
#which rvm >/dev/null 2>&1 || (
#  echo "Installing rvm";
#  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB;
#  \curl -sSL https://get.rvm.io | bash -s stable;
#  rvm install 2.3.0 --with-openssl-dir=`brew --prefix openssl`;
#)

# Bundler
#which rvm >/dev/null 2>&1 || (
#  echo "Installing bundler";
#  gem install bundler;
#)
