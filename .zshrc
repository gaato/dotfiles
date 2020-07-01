export LANG=ja_JP.UTF-8

#大文字小文字を区別しない補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#histry
HISTFILE="~/.zsh_history "
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history #ヒストリに実行時間も保存

#コマンドのスペルを訂正する
# setopt correct

# <Tab>でパス名の補完候補を表示したあと、
# 続けて<Tab>を押すと候補からパス名を選択することができるようになる
zstyle ':completion:*:default' menu select=1

autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"


autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}"
zstyle ':vcs_info:*' formats "[%F{green}%c%u%b%f]"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }

PROMPT='%K{235}[%n@%m] %F{cyan}%~%f ${vcs_info_msg_0_}%k
%k%F{green}=^._.^=%f '
RPROMPT='%K{235}[%F{cyan}%D{%H:%M}%f]'


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=/Applications/Julia-1.4.app/Contents/Resources/julia/bin:$PATH
export PATH=/Users/gart/.nimble/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=/usr/local/opt/llvm/bin:$PATH
eval "$(pyenv init -)"
alias e='emacs'
alias activate="source $PYENV_ROOT/versions/anaconda3-2.5.0/bin/activate"
eval $(thefuck --alias)
