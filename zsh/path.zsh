export PATH=/usr/local/share/android-sdk/platform-tools:$PATH

# Use GNU core utils instead of the ones provided by OS X, for interoperability with scripts writeen on other UNIX systems.
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

# Docker
export PATH=$PATH:$HOME/.docker/bin

# kubectl
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# CUA
export PATH="$PATH:/Users/larslockefeer/.local/bin"
