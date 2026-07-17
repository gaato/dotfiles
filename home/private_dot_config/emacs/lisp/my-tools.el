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

;; project.el: ghq 配下のリポジトリを見つけやすくする
(use-package project
  :ensure nil
  :custom
  (project-vc-extra-root-markers '("moon.mod.json" "package.json" "Cargo.toml")))

(provide 'my-tools)
;;; my-tools.el ends here
