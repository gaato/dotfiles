# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==========================================
# Zsh Configuration by @gaato
# ==========================================

# Use ZDOTDIR if set to locate configuration
zsh_home="${ZDOTDIR:-$HOME}"

# Load environment specific settings
local_rc="$zsh_home/.zshrc.local"
[[ -f $local_rc ]] && source "$local_rc"

# Source configuration fragments
rc_dir="$zsh_home/.zshrc.d"
if [[ -d $rc_dir ]]; then
    for rc in "$rc_dir"/*.zsh(N); do
        [[ -r $rc ]] && source "$rc"
    done
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
