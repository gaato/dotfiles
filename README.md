# dotfiles

[chezmoi](https://www.chezmoi.io/) で「失うと再構築が面倒なファイル」だけを管理する。

## 設計方針

- **管理対象は最小限**: fish / git / mise / Claude Code 設定 / ドリフト検出基盤。
  デスクトップ設定 (Plasma・テーマ等) は churn が高いので対象外。
  `~/.ssh/config` はネットワーク構成 (private の iac リポジトリの領分) を含むため対象外
- **ドリフトは日常**: 禁止せず、毎日の timer で検出して「取り込む / 捨てる」の二択に落とす。
  処理はエージェントの `/dotfiles` スキルに任せる
- **所有権は一意**: ツールのバージョン = mise (`~/.config/mise/config.toml`)、
  ファイル内容 = chezmoi、エージェント設定の正本 = `~/.agents` (別リポジトリ)
- **このリポジトリは public**: 秘密情報は入れない。pre-push フックで gitleaks が走る
  (`~/.codex/config.toml` は API キーを含むため意図的に管理対象外)

## 新マシンのセットアップ

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply gaato
```

これだけで以下が揃う:

1. 管理ファイルの配置 (fish, git, mise, claude, systemd timer)
2. mise の導入と `mise install` によるツール収束 (run_once スクリプト)
3. `~/.agents` の clone と CLAUDE.md / AGENTS.md / skills の symlink 構築
4. gitleaks pre-push フックの有効化

その後 `systemctl --user daemon-reload && systemctl --user enable --now chezmoi-drift.timer`
でドリフト検出 timer を起動 (次回ログイン以降は自動)。

ghq 配置に揃えたい場合は clone 後に
`~/.local/share/chezmoi` を `~/ghq/github.com/gaato/dotfiles` へ移して symlink を張る。

## 日常運用

普段はエージェントの `/dotfiles` スキルに任せればよい。手で触る場合の実質4コマンド:

| やること | コマンド |
|---|---|
| ドリフト確認 | `chezmoi status` / `chezmoi diff` |
| ローカルの変更を取り込む | `chezmoi re-add <file>` (自動コミットされる) |
| リポジトリ側に戻す | `chezmoi apply <file>` |
| 他マシンの変更を取り込む | `chezmoi update` |

ドリフトは `chezmoi-drift.timer` (毎日) が検出し、デスクトップ通知と
fish greeting の1行表示で知らせる。

## 構成

```
.chezmoiroot            # ソースは home/ 以下
.githooks/pre-push      # gitleaks ゲート
home/
├── .chezmoi.toml.tmpl  # chezmoi 設定 (autoCommit=true)
├── .chezmoiscripts/    # run_once: mise 導入 / ~/.agents 配置 / フック有効化
├── dot_gitconfig
├── dot_claude/settings.json
├── private_dot_config/ # fish, git, mise, systemd user units
└── private_dot_local/bin/chezmoi-drift-check
```

## TODO (Phase 2)

- [ ] Bitwarden 連携: `bitwarden`/`rbw` テンプレート関数でシークレットを apply 時に展開
      (まず `~/.codex/config.toml` の API キー1件で試す)
- [ ] `~/.ssh/config` を age 暗号化で管理する案の検討 (chezmoi は encrypted_ ファイルに対応)
- [ ] CI: GitHub Actions で `chezmoi init --apply` の smoke test (ubuntu ランナー + Bats)
- [ ] openSUSE コンテナでの bootstrap E2E 検証
- [ ] `~/.agents` にリモートを用意する (private 推奨) — 現状 bootstrap の clone は skip される
