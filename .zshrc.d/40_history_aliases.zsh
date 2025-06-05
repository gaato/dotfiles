# History options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY SHARE_HISTORY

# Aliases (use eza/exa)
alias grep='grep --color=auto'

# Use eza/exa if available, otherwise fallback to ls
if command -v eza >/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first'
    alias la='eza -la --icons --group-directories-first'
    alias lt='eza -Ta --icons'
elif command -v exa >/dev/null; then
    alias ls='exa --icons --group-directories-first'
    alias ll='exa -l --icons --group-directories-first'
    alias la='exa -la --icons --group-directories-first'
    alias lt='exa -Ta --icons'
else
    alias ll='ls -l'
    alias la='ls -la'
    alias lt='ls -Ta'
fi
