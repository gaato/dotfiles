export LANG=ja_JP.UTF-8

#history
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history #ヒストリに実行時間も保存

# Download Znap, if it's not there yet.
[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap
source ~/Repos/znap/znap.zsh  # Start Znap

# Plugins
znap source mafredri/zsh-async
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source zdharma-continuum/history-search-multi-word
znap source zdharma-continuum/fast-syntax-highlighting
znap source sindresorhus/pure

# prompt
# zstyle :prompt:pure:path

# ls colors
export LSCOLORS=gxfxcxdxbxegedabagacad

# opam configuration
test -r ~/.opam/opam-init/init.zsh && . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# eval
eval "$(pyenv init -)"
eval "$(goenv init -)"

fuck() {
  unfunction "$0"
  source <(thefuck --alias)
  $0 "$@"
}

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# alias
case "${OSTYPE}" in
darwin*)
  alias ls="ls -G"
  alias ll="ls -lG"
  alias la="ls -laG"
  ;;
linux*)
  alias ls='ls --color'
  alias ll='ls -l --color'
  alias la='ls -la --color'
  ;;
esac
