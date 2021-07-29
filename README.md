# Usage

* Clone this repository
* Move it to your home directory `mv dotfiles .dotfiles && cd dotfiles`, or create a soft link `ln -s {path_to_repository_clone} ~/.dotfiles`
* `cd ~/.dotfiles`
* `./make.sh`

This will sync all dotfiles in this repository.

See http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/ for the approach taken. This is very much a work in progress.

# Application-specific setup

## iTerm
After running the Makefile for the first time, go to Preferences > General > Preferences and select "Load preferences from a custom folder or URL". Enter `/Users/larslockefeer/Projects/Personal/dotfiles/config/iTerm/Profiles` as the location to load preferences from. Set "Save changes" to "Automatically".
