# ==========================================
# .zshrc Configuration File
# Maintained by: Gakuto Furuya (@gaato)
# ==========================================

# ------------------------------------------
# Powerlevel10k Instant Prompt
# ------------------------------------------
# Enables Powerlevel10k instant prompt feature. 
# This block should stay close to the top of the file.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------
# Znap Setup
# ------------------------------------------
# Downloads Znap if not present and initializes it.
[[ -r ~/Repos/znap/znap.zsh ]] || {
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap ||
    echo "Failed to clone Znap"
}
source ~/Repos/znap/znap.zsh

# ------------------------------------------
# Plugins
# ------------------------------------------
# Core Functionality
znap source mafredri/zsh-async
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions

# Appearance
znap source romkatv/powerlevel10k

# Syntax and Search Enhancements
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-history-substring-search

# Utilities
znap source MichaelAquilina/zsh-you-should-use
znap source djui/alias-tips
znap source johannchangpro/zsh-interactive-cd

# ------------------------------------------
# Environment Variables
# ------------------------------------------
export LANG=en_US.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
export EDITOR='nano'

# ------------------------------------------
# Shell Options
# ------------------------------------------
setopt EXTENDED_GLOB

# ------------------------------------------
# History Settings
# ------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history  # Save execution time in history

# ------------------------------------------
# fzf Configuration
# ------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------------------
# Language Environments
# ------------------------------------------
# Initialize opam if present
[ -r ~/.opam/opam-init/init.zsh ] && . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null

# Initialize pyenv if present
type "pyenv" > /dev/null 2>&1 && eval "$(pyenv init -)"

# Initialize goenv if present
type "goenv" > /dev/null 2>&1 && eval "$(goenv init -)"

# ------------------------------------------
# Node Version Manager (nvm)
# ------------------------------------------
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# ------------------------------------------
# OS-Specific Aliases
# ------------------------------------------
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

# ------------------------------------------
# Prompt Customization
# ------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
