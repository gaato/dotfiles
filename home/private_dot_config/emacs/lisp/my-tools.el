;;; my-tools.el --- Git・プロジェクト -*- lexical-binding: t -*-

;;; Commentary:
;; レビュー・観測拠点の要。エージェントの変更を magit + diff-hl で追う。

;;; Code:

(use-package magit
  :bind (("C-c g" . magit-status)
         ("C-c G" . magit-dispatch)))

(use-package diff-hl
  :demand t
  :config
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1)
  ;; TTY フレームでは fringe が無いので margin 表示に切り替える
  (add-hook 'diff-hl-mode-hook
            (lambda ()
              (unless (display-graphic-p)
                (diff-hl-margin-local-mode 1))))
  :hook ((magit-pre-refresh . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

;; ファイルツリー(VS Code のエクスプローラー相当)
(use-package treemacs
  :bind (("C-c t" . treemacs)
         ("C-c T" . treemacs-select-window))
  :custom
  (treemacs-width 32)
  :config
  (treemacs-follow-mode 1)     ; 今開いているファイルをツリーが追従
  (treemacs-filewatch-mode 1)  ; エージェントによるファイル作成・削除も即反映
  (treemacs-git-mode 'deferred))

(use-package treemacs-nerd-icons
  :after treemacs
  :config (treemacs-load-theme "nerd-icons"))

(use-package treemacs-magit
  :after (treemacs magit))

;; Emacs 内フル機能ターミナル(herdr-attach 用)
(use-package vterm
  :custom
  (vterm-always-compile-module t)
  (vterm-max-scrollback 10000)
  :commands (vterm vterm-mode))

;; herdr のエージェントたちを Emacs から観測・操作する(自作パッケージ)
;; TODO: GitHub 公開後は :vc (:url "https://github.com/gaato/herdr.el") に切り替える
(use-package herdr
  :if (file-directory-p "~/ghq/github.com/gaato/herdr.el")
  :ensure nil
  :load-path "~/ghq/github.com/gaato/herdr.el"
  :bind ("C-c h" . herdr))

;; project.el: ghq 配下のリポジトリを見つけやすくする
(use-package project
  :ensure nil
  :custom
  (project-vc-extra-root-markers '("moon.mod.json" "package.json" "Cargo.toml")))

(provide 'my-tools)
;;; my-tools.el ends here
