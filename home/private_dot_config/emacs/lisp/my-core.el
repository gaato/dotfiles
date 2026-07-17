;;; my-core.el --- 基本設定 -*- lexical-binding: t -*-

;;; Commentary:
;; パッケージが生成するファイルの整理、PATH、日本語環境、ビルトイン機能の有効化。

;;; Code:

;; 生成物を var/ etc/ に集約し、リポジトリ管理対象を汚さない
(use-package no-littering
  :demand t
  :config
  (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file))
  (no-littering-theme-backups))

;; GUI起動(Plasmaから直接)でも mise / MoonBit のツールが見えるようにする
(dolist (dir (list (expand-file-name "~/.local/share/mise/shims")
                   (expand-file-name "~/.moon/bin")
                   (expand-file-name "~/.local/bin")))
  (when (file-directory-p dir)
    (add-to-list 'exec-path dir)
    (setenv "PATH" (concat dir ":" (getenv "PATH")))))

(use-package exec-path-from-shell
  :if (or (daemonp) (memq window-system '(pgtk x)))
  :config
  (exec-path-from-shell-initialize))

;; 日本語環境(入力は fcitx 任せ)
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; herdr 側のエージェントが書き換えたファイルを即座に反映する
(setq auto-revert-avoid-polling t
      auto-revert-check-vc-info t
      global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)
(global-auto-revert-mode 1)

;; エージェントと同居するリポジトリでロックファイル(.#foo)を撒かない
(setq create-lockfiles nil)

;; 履歴・位置の記憶
(savehist-mode 1)
(save-place-mode 1)
(recentf-mode 1)
(setq recentf-max-saved-items 200)

;; ビルトインの快適機能
(which-key-mode 1)
(repeat-mode 1)
(setq use-short-answers t)
(setq ring-bell-function #'ignore)
(setq enable-recursive-minibuffers t)
(setq require-final-newline t)
(when (display-graphic-p)
  (pixel-scroll-precision-mode 1))

;; スクロールを穏やかに
(setq scroll-conservatively 101
      scroll-margin 2)

(provide 'my-core)
;;; my-core.el ends here
