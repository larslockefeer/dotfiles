
# Oh my ZSH
which zsh >/dev/null 2>&1 || (
  echo "Installing zsh";
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
)

# Homebrew + dependencies
which brew >/dev/null 2>&1 || (
  echo "Installing Homebrew";
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
)

which thefuck >/dev/null 2>&1 || (
  echo "Installing thefuck";
  brew install thefuck
)

which nvim >/dev/null 2>&1 || (
  echo "Installing neovim";
  brew install neovim
)

# RVM & Ruby 2.3.0
which rvm >/dev/null 2>&1 || (
  echo "Installing rvm";
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB;
  \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.0;
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
