# zsh-completions(補完機能)の設定
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -U compinit
compinit -u

# prompt
PROMPT='%m@%n %F{6}%~%f$ '

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=/Users/gart/.nimble/bin:$PATH
export PATH=~/.local/bin:$PATH
eval "$(pyenv init -)"
alias e='emacs -nw'
alias activate="source $PYENV_ROOT/versions/anaconda3-2.5.0/bin/activate"
