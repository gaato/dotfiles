#!/bin/sh
# dotfiles リポジトリ自体の設定: gitleaks pre-push フックを有効化
set -eu

repo="$(dirname "$CHEZMOI_SOURCE_DIR")"
if [ -d "$repo/.githooks" ]; then
    git -C "$repo" config core.hooksPath .githooks
fi
