#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Oh my ZSH
which zsh >/dev/null 2>&1 || (
  echo "Installing zsh";
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"
)

# Change default shell
echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s $(which zsh)

# Homebrew + dependencies
which brew >/dev/null 2>&1 || (
  echo "Installing Homebrew";
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
)

which thefuck >/dev/null 2>&1 || (
  echo "Installing thefuck";
  brew install thefuck
)

# Java 11
brew cask list | grep java 2>&1 || (
  echo "Installing Java";
  brew cask install java
)

# Maven
which mvn >/dev/null 2>&1 || (
  echo "Installing MVN";
  brew install maven
)

# Gradle
which gradle >/dev/null 2>&1 || (
  echo "Installing Gradle";
  brew install gradle
)

# Mongo
which mongo >/dev/null 2>&1 || (
  echo "Installing mongo";
  brew install mongo
)

# jq
which jq >/dev/null 2>&1 || (
  echo "Installing jq";
  brew install jq
)

# xmlstarlet
which xmlstarlet >/dev/null 2>&1 || (
  echo "Installing xmlstarlet";
  brew install xmlstarlet
)

# Android SDK Tools
which sdkmanager >/dev/null 2>&1 || (
  echo "Installing Android SDK tools"
  brew tap caskroom/cask
  brew cask install android-sdk
)

# RVM & Ruby 2.3.0
which rvm >/dev/null 2>&1 || (
  echo "Installing rvm";
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB;
  \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.0 --with-openssl-dir=$HOME/.rvm/usr;
)

# Bundler
which rvm >/dev/null 2>&1 || (
  echo "Installing bundler";
  gem install bundler;
)

# NVM
which nvm >/dev/null 2>&1 || (
  echo "Installing nvm";
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash;
)

# Yarn
which yarn >/dev/null 2>&1 || (
  echo "Installing yarn";
  brew install yarn
)
