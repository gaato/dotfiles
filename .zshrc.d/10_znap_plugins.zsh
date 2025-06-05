# Znap setup
if [[ ! -r ~/Repos/znap/znap.zsh ]]; then
  if command -v git >/dev/null; then
    git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap ||
      echo "Failed to clone Znap"
  else
    echo "git not found. Install git to manage plugins" >&2
  fi
fi
[ -r ~/Repos/znap/znap.zsh ] && source ~/Repos/znap/znap.zsh

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
