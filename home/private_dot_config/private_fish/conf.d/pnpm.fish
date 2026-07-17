# pnpm のグローバルインストール先 (pnpm add -g)
set -gx PNPM_HOME ~/.local/share/pnpm
fish_add_path --global $PNPM_HOME
