#!/bin/zsh

# Exit immediately if a command exits with a non-zero status
set -e

# Configuration
# Casks
# Consider: android-sdk
casks=(iterm2 visual-studio-code alfred slack intellij-idea phoenix karabiner-elements spotify microsoft-powerpoint microsoft-word microsoft-excel obsidian flux whatsapp zoom skim)
# Formulae
# Consider: tmux
formulae=(spaceship zplug gnupg gnupg2 thefuck jabba maven gradle jq xmlstarlet nvm yarn mongodb-community@5.0 gh espanso pyenv gh)

confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure?} [y/n]" response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

install_cask () {
  if brew info $1 | grep -q "Not installed"; then
    confirm "Would you like to install $1 now?" && brew install --cask $1
  else
    echo "Skipping $1 because it is already installed";
  fi
}

install_formula () {
  if brew info $1 | grep -q "Not installed"; then
    confirm "Would you like to install $1 now?" && brew install $1
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
brew tap federico-terzi/espanso

# Install casks
for i in $casks
do
  install_cask $i
done

# Install formulae
for i in $formulae
do
  install_formula $i
done

# Post-install phoenix things
test -L ~/.phoenix.js || ln -s ~/.dotfiles/config/phoenix/phoenix.js ~/.phoenix.js

# Post-install karabiner things
test -L ~/.config/karabiner || ln -s ~/.dotfiles/config/karabiner ~/.config/karabiner

# Post-install java things
test -L ~/.m2/settings.xml || ln -s ~/.dotfiles/m2/settings.xml ~/.m2/settings.xml

# Post-install espanso things
test -L /Users/larslockefeer/Library/Preferences/espanso || ln -s ~/.dotfiles/config/espanso /Users/larslockefeer/Library/Preferences/espanso

# Install fonts
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
