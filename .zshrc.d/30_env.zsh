# Set basic environment
export LANG=en_US.UTF-8
export EDITOR='nano'

# Env managers (run only when installed)
command -v pyenv >/dev/null && eval "$(pyenv init --path)"
# Initialize goenv if available
command -v goenv >/dev/null && eval "$(goenv init -)"

# NVM
export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
else
    echo "nvm not installed. See https://github.com/nvm-sh/nvm#installing-and-updating"
fi
