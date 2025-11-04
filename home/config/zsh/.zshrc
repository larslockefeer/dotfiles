##### Fast, minimal Zsh #####

# ---------- PATH & Homebrew ----------
# Put Homebrew first (Apple Silicon default prefix)
export HOMEBREW_PREFIX="/opt/homebrew"
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"

# ---------- Options: sensible & speedy ----------
setopt prompt_subst           # allow prompt expansion
setopt autocd                 # `cd` by just typing dir
setopt interactivecomments    # allow comments at prompt
setopt extendedglob           # nicer globs
setopt hist_ignore_all_dups   # keep history clean
setopt inc_append_history     # write history as you go
setopt share_history          # share across sessions
unsetopt beep                 # no bell

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000

# ---------- Completion (native Zsh + Homebrew) ----------
autoload -U compinit
zmodload zsh/complist
# Add Homebrew completions (git, brew, many formulae)
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
# Speed: skip dump validity checks
compinit -C

# Make completion nicer
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' rehash true

# ---------- Prompt (Starship) ----------
eval "$(starship init zsh)"

# ---------- Plugins (no framework) ----------
# Autosuggestions
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"  # brew hint
# History substring search (bind to ↑/↓)
source "$HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Optional: accept autosuggestion with → (matches macOS Terminal/Ghostty behavior)
bindkey '^[[C' forward-word
# If you prefer right-arrow to accept suggestion:
# bindkey '^[[C' autosuggest-accept

# ---------- Television (fast fuzzy finder) ----------
# Examples:
#   tv files        # fuzzy-find files with preview
#   tv git          # fuzzy Git things (log, branches, etc.)
#   tv history      # fuzzy search your shell history
# See `tv --help` and https://github.com/alexpasmantier/television
# Quick keybindings:
# Ctrl-R -> tv history
function _tv_history() { tv zsh-history }
zle -N _tv_history
bindkey '^R' _tv_history

# Ctrl-P -> tv files
function _tv_files() { tv files }
zle -N _tv_files
bindkey '^P' _tv_files

# ---------- Aliases: minimal defaults ----------
alias ll='ls -lah'
alias gs='git status'
alias gl='git log --oneline --graph --decorate'
alias ..='cd ..'

# ---------- Language/tool version managers (lazy, optional) ----------
# Keep login fast: only load heavy managers when you use them.
# Uncomment the ones you actually need.

# --- nvm (lazy) ---
export NVM_DIR="$HOME/.nvm"
nvm() { unset -f nvm; [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"; nvm "$@"; }

# --- pyenv (light) ---
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv >/dev/null; then eval "$(pyenv init -)"; fi

# --- rbenv (Ruby) ---
if command -v rbenv >/dev/null; then eval "$(rbenv init - zsh)"; fi

# --- SDKMAN (Java) ---
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Thefuck
eval $(thefuck --alias)

# ---------- Custom: your local tweaks ----------
# Source additional zsh config files from ~/.zsh/
SCRIPT_PATH="$HOME/.dotfiles"
source "${SCRIPT_PATH}/home/config/zsh/aliases.zsh"
source "${SCRIPT_PATH}/home/config/zsh/history.zsh"
source "${SCRIPT_PATH}/home/config/zsh/path.zsh"
test -f "${SCRIPT_PATH}/home/config/zsh/secrets.zsh" && source "${SCRIPT_PATH}/home/config/zsh/secrets.zsh" || echo "Could not find secrets file. Make sure to copy it to ${SCRIPT_PATH}/home/config/zsh/secrets.zsh"

# Source per-machine overrides (keeps this file clean)
# [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
