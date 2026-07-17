;;; init.el --- 便利で最強でかわいいEmacs -*- lexical-binding: t -*-

;;; Commentary:
;; Emacs 30 のビルトイン(use-package / treesit / eglot)を軸にした手組み設定。
;; 実体は lisp/my-*.el に分割してある。

;;; Code:

;; パッケージ
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; 初回のみアーカイブを取得(2回目以降はディスクキャッシュで足りる)
(unless (file-exists-p
         (expand-file-name "archives/melpa/archive-contents" package-user-dir))
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

;; モジュール読み込み
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'my-core)
(require 'my-ui)
(require 'my-completion)
(require 'my-editing)
(require 'my-org)
(require 'my-langs)
(require 'my-tools)

;;; init.el ends here
