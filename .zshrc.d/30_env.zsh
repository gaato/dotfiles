# Set basic environment
export LANG=en_US.UTF-8
export EDITOR='nano'

# Env managers (conditional)
if command -v pyenv >/dev/null; then
    eval "$(pyenv init --path)"
else
    echo "pyenv not installed. See https://github.com/pyenv/pyenv#installation"
fi

if command -v goenv >/dev/null; then
    eval "$(goenv init -)"
else
    echo "goenv not installed. See https://github.com/syndbg/goenv#installation"
fi

# NVM
export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
else
    echo "nvm not installed. See https://github.com/nvm-sh/nvm#installing-and-updating"
fi
