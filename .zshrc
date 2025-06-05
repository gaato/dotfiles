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
