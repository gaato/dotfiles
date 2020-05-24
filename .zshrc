# zsh-completions(補完機能)の設定
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi


autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '[%F{green}%b%f]'
zstyle ':vcs_info:*' actionformats '[%F{green}%b%f(%F{red}%a%f)]'
precmd() { vcs_info }
PROMPT='%{${fg[yellow]}%}%~%{${reset_color}%}
[%n@%m]${vcs_info_msg_0_}
%(?.%B%F{green}.%B%F{blue})% \(^o^)/ %f%b'
RPROMPT=''

function chpwd() { ls -l }

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
