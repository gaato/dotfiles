export LANG=ja_JP.UTF-8


#history
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history #ヒストリに実行時間も保存


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit light marlonrichert/zsh-autocomplete

zinit light zsh-users/zsh-autosuggestions

zinit light -b zdharma-continuum/history-search-multi-word

zinit light zdharma-continuum/fast-syntax-highlighting

### End of Zinit's installer chunk


# prompt
# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{yellow}"
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}"
# zstyle ':vcs_info:*' formats "[%F{green}%c%u%b%f]"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd() { vcs_info }

# PROMPT='%K{235}[%n@%m] %F{cyan}%~%f ${vcs_info_msg_0_}%k
# %k%F{green}|ω･)%f '
# RPROMPT='%K{235}[%F{cyan}%D{%H:%M}%f]'


# opam configuration
test -r ~/.opam/opam-init/init.zsh && . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true


# eval
pyenv() {
  unfunction "$0"
  source <(pyenv init -)
  if which pyenv-virtualenv-init > /dev/null; then source <(pyenv virtualenv-init -); fi
  $0 "$@"
}

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
