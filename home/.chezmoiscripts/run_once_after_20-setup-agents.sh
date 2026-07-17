#!/bin/sh
# ~/.agents (Claude Code / Codex 共有のエージェント設定) を配置し symlink を張る
# 手順の正本: ~/.agents/HANDOFF.md
set -eu

AGENTS_DIR="$HOME/.agents"
AGENTS_REMOTE="${AGENTS_REMOTE:-git@github.com:gaato/agents.git}"

if [ ! -d "$AGENTS_DIR" ]; then
    echo "==> $AGENTS_DIR を clone します ($AGENTS_REMOTE)"
    if ! git clone "$AGENTS_REMOTE" "$AGENTS_DIR"; then
        echo "!! clone に失敗しました。リモートを用意してから再実行してください:" >&2
        echo "!!   AGENTS_REMOTE=<url> chezmoi apply" >&2
        exit 0
    fi
fi

# グローバル指示の symlink (正本は ~/.agents/AGENTS.md)
# ~/.agents が skills のインストール先としてだけ存在する環境では、存在しない
# AGENTS.md へのリンクを作らない。
if [ -f "$AGENTS_DIR/AGENTS.md" ]; then
    mkdir -p "$HOME/.claude" "$HOME/.codex"
    ln -sfT "$AGENTS_DIR/AGENTS.md" "$HOME/.claude/CLAUDE.md"
    ln -sfT "$AGENTS_DIR/AGENTS.md" "$HOME/.codex/AGENTS.md"
else
    echo "==> $AGENTS_DIR/AGENTS.md がないためグローバル指示の symlink はスキップします"
fi

# スキルの symlink (~/.claude/skills/* → ~/.agents/skills/*)
if [ -x "$AGENTS_DIR/scripts/check-skills.sh" ]; then
    "$AGENTS_DIR/scripts/check-skills.sh"
fi
