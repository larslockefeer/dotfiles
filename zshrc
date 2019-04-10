# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

theme="robbyrussell"

# Uncomment the following line to change 
# export UPDATE_ZSH_DAYS=13   # How often to auto-update (in days).
ENABLE_CORRECTION="true"      # Command auto-correction.

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

SCRIPT_PATH="$HOME/.dotfiles"
source $ZSH/oh-my-zsh.sh
source "${SCRIPT_PATH}/z/z.sh"
source "${SCRIPT_PATH}/zsh/aliases.zsh"
source "${SCRIPT_PATH}/zsh/environment.zsh"
source "${SCRIPT_PATH}/zsh/functions.zsh"
source "${SCRIPT_PATH}/zsh/history.zsh"
source "${SCRIPT_PATH}/zsh/path.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# This sets up automatic node version switching (https://github.com/creationix/nvm#deeper-shell-integration)
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# The Fuck
eval $(thefuck --alias)

  # Set Spaceship ZSH as a prompt
  autoload -U promptinit; promptinit
  prompt spaceship
