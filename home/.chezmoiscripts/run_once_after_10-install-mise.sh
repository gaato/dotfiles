#!/bin/sh
# mise 未導入なら公式インストーラで導入し、~/.config/mise/config.toml のツールを収束させる
set -eu

if ! command -v mise >/dev/null 2>&1; then
    if [ -x "$HOME/.local/bin/mise" ]; then
        PATH="$HOME/.local/bin:$PATH"
    else
        echo "==> mise をインストールします"
        curl -fsSL https://mise.run | sh
        PATH="$HOME/.local/bin:$PATH"
    fi
fi

echo "==> mise install (ツールを config.toml に収束)"
mise install --yes
