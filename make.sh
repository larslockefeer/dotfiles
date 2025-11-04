#!/bin/bash
############################
# make.sh
# This script sets up your dotfiles environment by:
#   1. Installing Homebrew packages (casks and formulae)
#   2. Creating symlinks from ~/.dotfiles/home/ to ~/
#   3. Pruning unlisted packages
#
# Usage:
#   ./make.sh                # Run all phases (deps, symlinks, prune)
#   ./make.sh --deps         # Only install/update dependencies
#   ./make.sh --symlinks     # Only create symlinks
#   ./make.sh --prune        # Only remove packages not in config (interactive)
#   ./make.sh --deps --prune # Install/update and then prune
############################

set -e  # Exit on error

########## Parse command line arguments
RUN_DEPS=false
RUN_SYMLINKS=false
RUN_PRUNE=false
NO_FLAGS=true

while [[ $# -gt 0 ]]; do
  case $1 in
    --deps)
      RUN_DEPS=true
      NO_FLAGS=false
      shift
      ;;
    --symlinks)
      RUN_SYMLINKS=true
      NO_FLAGS=false
      shift
      ;;
    --prune)
      RUN_PRUNE=true
      NO_FLAGS=false
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [options]"
      echo "Options:"
      echo "  --deps         Install/update dependencies (includes brew update & upgrade)"
      echo "  --symlinks     Create symlinks"
      echo "  --prune        Remove packages not in config (interactive)"
      echo "  --help, -h     Show this help message"
      echo ""
      echo "If no options are provided, all phases will run (deps, symlinks, prune)."
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help to see available options"
      exit 1
      ;;
  esac
done

# If no flags specified, run everything
if [[ "$NO_FLAGS" == true ]]; then
  RUN_DEPS=true
  RUN_SYMLINKS=true
  RUN_PRUNE=true
fi

########## Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dir=~/.dotfiles           # dotfiles directory
olddir=~/.dotfiles_old    # old dotfiles backup directory
homedir=$dir/home         # directory containing files to symlink to ~/

# Configuration files
casks_file="$SCRIPT_DIR/home/config/brew/casks.txt"
formulae_file="$SCRIPT_DIR/home/config/brew/formulae.txt"
##########

########## Helper Functions
# Read configuration files, filtering out comments, empty lines, and tap: lines
read_config() {
  local file=$1
  if [ ! -f "$file" ]; then
    echo "ERROR: Configuration file not found: $file"
    exit 1
  fi
  grep -v '^#' "$file" | grep -v '^[[:space:]]*$' | grep -v '^tap:'
}

# Extract tap: lines from configuration files
read_taps() {
  local file=$1
  if [ ! -f "$file" ]; then
    return
  fi
  grep '^tap:' "$file" | sed 's/^tap:[[:space:]]*//'
}

confirm() {
  local response
  read -r -p "${1:-Are you sure?} [y/n] " response
  case "$response" in
    [yY][eE][sS]|[yY])
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

install_cask() {
  if brew info "$1" 2>/dev/null | grep -q "Not installed"; then
    confirm "Would you like to install $1 now?" && brew install --cask "$1"
  else
    echo "Skipping $1 because it is already installed"
  fi
}

install_formula() {
  if brew info "$1" 2>/dev/null | grep -q "Not installed"; then
    confirm "Would you like to install $1 now?" && brew install "$1"
  else
    echo "Skipping $1 because it is already installed"
  fi
}

# Get list of packages that should be installed according to config
get_wanted_casks() {
  read_config "$casks_file"
}

get_wanted_formulae() {
  read_config "$formulae_file"
}

# Get list of actually installed packages
get_installed_casks() {
  brew list --cask 2>/dev/null || true
}

get_installed_formulae() {
  brew list --formula 2>/dev/null || true
}

# Check if a package is a dependency of any wanted packages
is_dependency_of_wanted() {
  local package=$1
  local wanted_formulae

  # Get all wanted formulae
  wanted_formulae=$(get_wanted_formulae)

  # Check if this package is used by any wanted formula
  for formula in $wanted_formulae; do
    if brew deps --installed "$formula" 2>/dev/null | grep -q "^${package}$"; then
      return 0  # Is a dependency
    fi
  done

  return 1  # Not a dependency
}
##########

# Phase 1: Install dependencies
if [[ "$RUN_DEPS" == true ]]; then
  echo "========================================="
  echo "Phase 1: Installing Dependencies"
  echo "========================================="

  # Install Homebrew if not already installed
  if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is already installed"
  fi

  # Update Homebrew
  echo ""
  echo "Updating Homebrew..."
  brew update

  # Upgrade existing packages
  echo ""
  echo "Upgrading existing packages..."
  brew upgrade

  # Add taps from config files
  echo ""
  echo "Adding Homebrew taps..."
  while IFS= read -r tap; do
    if [ -n "$tap" ]; then
      echo "  Tapping $tap..."
      brew tap "$tap" 2>/dev/null || true
    fi
  done < <(read_taps "$casks_file"; read_taps "$formulae_file")

  # Install casks
  echo ""
  echo "Installing casks..."
  while IFS= read -r cask; do
    if [ -n "$cask" ]; then
      install_cask "$cask"
    fi
  done < <(read_config "$casks_file")

  # Install formulae
  echo ""
  echo "Installing formulae..."
  while IFS= read -r formula; do
    if [ -n "$formula" ]; then
      install_formula "$formula"
    fi
  done < <(read_config "$formulae_file")

  # Post-install setup
  echo ""
  echo "Running post-install setup..."

  # Create nvm directory if it doesn't exist
  if [ ! -d ~/.nvm ]; then
    echo "  Creating ~/.nvm directory"
    mkdir -p ~/.nvm
  fi

  echo ""
  echo "Dependencies installation complete!"
fi

# Phase 2: Create symlinks
if [[ "$RUN_SYMLINKS" == true ]]; then
  echo ""
  echo "========================================="
  echo "Phase 2: Creating Symlinks"
  echo "========================================="

  # Ensure .config directory exists
  if [ ! -d ~/.config ]; then
    echo "Creating ~/.config directory"
    mkdir -p ~/.config
  fi

  # create dotfiles_old in homedir for backup
  echo "Creating $olddir for backup of any existing dotfiles in ~"
  rm -rf $olddir
  mkdir -p $olddir
  echo "...done"

  # Auto-discover and symlink everything in home/ to ~/ with dot prefix
  echo ""
  echo "Discovering files in $homedir"
  if [ -d "$homedir" ]; then
    for item in "$homedir"/*; do
      if [ -e "$item" ]; then
        filename=$(basename "$item")
        target=~/.$filename

        echo "Processing $filename"

        # Backup existing file/directory if it exists and is not already a symlink
        if [ -e "$target" ] && [ ! -L "$target" ]; then
          echo "  Backing up existing ~/.$filename to $olddir"
          mv "$target" "$olddir/" 2>/dev/null || true
        elif [ -L "$target" ]; then
          echo "  Removing old symlink ~/.$filename"
          unlink "$target"
        fi

        # Create symlink
        echo "  Creating symlink ~/.$filename -> $item"
        ln -s "$item" "$target"
      fi
    done
    echo ""
    echo "Symlinks created successfully!"
  else
    echo "ERROR: $homedir directory not found!"
    exit 1
  fi
fi

# Phase 3: Prune packages (remove unlisted)
if [[ "$RUN_PRUNE" == true ]]; then
  echo ""
  echo "========================================="
  echo "Phase 3: Pruning Packages"
  echo "========================================="

  if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Run with --deps first."
    exit 1
  fi

  echo "Checking for packages not in config files..."
  echo ""

  # Get wanted and installed packages
  wanted_casks=$(get_wanted_casks)
  wanted_formulae=$(get_wanted_formulae)
  installed_casks=$(get_installed_casks)
  installed_formulae=$(get_installed_formulae)

  removed_count=0

  # Check casks
  echo "Checking casks..."
  for cask in $installed_casks; do
    if ! echo "$wanted_casks" | grep -q "^${cask}$"; then
      echo ""
      echo "  Found unlisted cask: $cask"
      if confirm "    Remove $cask?"; then
        echo "    Uninstalling $cask..."
        brew uninstall --cask "$cask" 2>/dev/null || echo "    Failed to uninstall $cask"
        ((removed_count++))
      else
        echo "    Skipping $cask"
      fi
    fi
  done

  # Check formulae
  echo ""
  echo "Checking formulae..."
  for formula in $installed_formulae; do
    if ! echo "$wanted_formulae" | grep -q "^${formula}$"; then
      echo ""
      echo "  Found unlisted formula: $formula"

      # Check if it's a dependency
      if is_dependency_of_wanted "$formula"; then
        echo "    Skipping $formula (dependency of a wanted package)"
        continue
      fi

      if confirm "    Remove $formula?"; then
        echo "    Uninstalling $formula..."
        brew uninstall "$formula" 2>/dev/null || echo "    Failed to uninstall $formula"
        ((removed_count++))
      else
        echo "    Skipping $formula"
      fi
    fi
  done

  echo ""
  if [ $removed_count -eq 0 ]; then
    echo "No packages were removed."
  else
    echo "Removed $removed_count package(s)."
    echo ""
    echo "Running 'brew autoremove' to clean up unused dependencies..."
    brew autoremove
  fi
  echo ""
  echo "Prune complete!"
fi
