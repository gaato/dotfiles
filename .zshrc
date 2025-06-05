# ==========================================
# Zsh Configuration by @gaato
# ==========================================

# Instant prompt (keep at top)
[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && \
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# Znap setup
[[ -r ~/Repos/znap/znap.zsh ]] || {
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap ||
  echo "Failed to clone Znap"
}
source ~/Repos/znap/znap.zsh

# Load plugins (interactive only)
if [[ $- == *i* ]]; then
    znap source mafredri/zsh-async
    znap source romkatv/powerlevel10k
    znap source zsh-users/zsh-autosuggestions
    znap source zsh-users/zsh-syntax-highlighting
    znap source zsh-users/zsh-completions
    znap source zsh-users/zsh-history-substring-search
    znap source MichaelAquilina/zsh-you-should-use
    znap source djui/alias-tips
    znap source johannchangpro/zsh-interactive-cd
    znap source Aloxaf/fzf-tab
fi

# FZF setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide (modern directory jumping)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# Set basic environment
export LANG=en_US.UTF-8
export EDITOR='nano'

# History options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY SHARE_HISTORY

# Aliases (use eza/exa)
alias grep='grep --color=auto'
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias lt='eza -Ta --icons'

# Env managers (conditional)
command -v pyenv >/dev/null && eval "$(pyenv init --path)"
command -v goenv >/dev/null && eval "$(goenv init -)"

# NVM
export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Source Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
