# FZF setup - install if missing
if ! command -v fzf >/dev/null; then
    if command -v git >/dev/null; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
            ~/.fzf/install --bin --key-bindings --completion --no-update-rc
    else
        echo "fzf not found and git is missing. See https://github.com/junegunn/fzf#installation" >&2
    fi
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide (modern directory jumping)
if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh)"
else
    echo "zoxide not installed. See https://github.com/ajeetdsouza/zoxide#installation"
fi
