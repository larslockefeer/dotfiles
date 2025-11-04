#!/bin/zsh

# Exit immediately if a command exits with a non-zero status
set -e

# Configuration
# Casks
# Consider: android-sdk
casks=(warp visual-studio-code alfred slack intellij-idea-ce spotify microsoft-powerpoint microsoft-word microsoft-excel obsidian whatsapp zoom skim brave-browser raycast karabiner-elements phoenix charles netnewswire discord tableau appium-inspector android-studio)
# Formulae
# Consider: tmux
formulae=(zplug gnupg gnupg2 thefuck maven gradle jq xmlstarlet nvm yarn mongodb-community@5.0 gh pyenv gh python openjdk openjdk@11 openjdk@17 kubectl helm coreutils grep flux docker gitup golang libffi asciinema rbenv ruby-build int128/kubelogin/kubelogin derailed/k9s/k9s starship zsh-autosuggestions zsh-history-substring-search television bat fd)

confirm () {
    # TODO: fix this function
    # call with a prompt string or use a default
#    read -r -p "${1:-Are you sure?} [y/n]" response
 #   case "$response" in
  #      [yY][eE][sS]|[yY]) 
   #         true
    #        ;;
     #   *)
      #      false
       #     ;;
   # esac
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

# Post-install ghostty
test -L ~/.config/ghostty || ln -s ~/.dotfiles/config/ghostty ~/.config/ghostty

# Post-install starship things
test -L ~/.config/starship.toml || ln -s ~/.dotfiles/config/starship.toml ~/.config/starship.toml

# Post-install television things
test -L ~/.config/television || ln -s ~/.dotfiles/config/television ~/.config/television

# Post-install nvm things
test -d ~/.nvm || mkdir ~/.nvm

# Post-install phoenix things
test -L ~/.phoenix.js || ln -s ~/.dotfiles/config/phoenix/phoenix.js ~/.phoenix.js

# Post-install karabiner things
test -L ~/.config/karabiner || ln -s ~/.dotfiles/config/karabiner ~/.config/karabiner

# mvn
test -L ~/.m2/settings.xml || ln -s ~/.dotfiles/m2 ~/.m2
