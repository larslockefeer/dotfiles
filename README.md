# Dotfiles

Personal dotfiles for macOS setup with automated Homebrew package installation and symlink management.

## Structure

```
~/.dotfiles/
├── make.sh              # Main setup script
├── home/                # Files to symlink to ~/ (with dot prefix)
│   ├── config/          # -> ~/.config/
│   │   ├── brew/        # Homebrew package lists
│   │   ├── ghostty/     # Terminal config
│   │   ├── karabiner/   # Keyboard customization
│   │   ├── phoenix/     # Window manager
│   │   ├── starship.toml
│   │   └── television/
│   ├── m2/              # -> ~/.m2/
│   ├── zsh/             # -> ~/.zsh/
│   ├── gitconfig        # -> ~/.gitconfig
│   ├── phoenix.js       # -> ~/.phoenix.js
│   ├── tmux.conf        # -> ~/.tmux.conf
│   ├── zprofile         # -> ~/.zprofile
│   └── zshrc            # -> ~/.zshrc
└── README.md
```

## Usage

### Initial Setup

1. Clone this repository:
   ```bash
   git clone <repo-url> ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run the setup script:
   ```bash
   ./make.sh
   ```

This will:
- Install Homebrew (if not already installed)
- Update Homebrew and upgrade all packages
- Install packages from `home/config/brew/casks.txt` and `formulae.txt`
- Create symlinks from `home/` to `~/` (with dot prefix)
- Prune packages not in config files (asks interactively)

### Selective Installation

Run only specific phases:

```bash
./make.sh --deps        # Only install/update dependencies (includes brew update & upgrade)
./make.sh --symlinks    # Only create symlinks
./make.sh --prune       # Only remove packages not in config (interactive)
./make.sh --help        # Show help
```

You can combine flags:
```bash
./make.sh --deps --prune    # Install/update packages and remove unlisted ones
```

## Managing Packages

### Adding/Removing Packages

Edit the package lists:
- **Casks** (GUI apps): `home/config/brew/casks.txt`
- **Formulae** (CLI tools): `home/config/brew/formulae.txt`

Both files support comments (`#`) and grouping. To add a custom Homebrew tap, use:

```
tap: username/repo
package-name
```

### Configuration Files

All configuration files in `home/` are automatically symlinked to `~/` with a dot prefix. To add a new dotfile:

1. Add it to `home/`
2. Run `./make.sh --symlinks`

### Pruning Packages

The `--prune` flag helps keep your system in sync with your config files by removing packages that are no longer listed:

```bash
./make.sh --prune
```

This will:
1. Compare installed packages with those in your config files
2. For each unlisted package:
   - Check if it's a dependency of a wanted package (won't remove if it is)
   - Ask you interactively if you want to remove it
3. Automatically run `brew autoremove` to clean up unused dependencies

**Safety features:**
- Always asks before removing each package
- Never removes dependencies of packages you want to keep
- Shows clear information about what will be removed

**Note:** Prune runs by default when you run `./make.sh` without flags, keeping your system automatically in sync with your config.

## Notes

- Backups of existing dotfiles are saved to `~/.dotfiles_old/`
- The `.nvm` directory is created automatically if needed
- Running `./make.sh` without flags will run all phases (deps, symlinks, prune)
- The deps phase includes `brew update` and `brew upgrade` to keep everything current
- The prune phase automatically runs `brew autoremove` after removing packages
