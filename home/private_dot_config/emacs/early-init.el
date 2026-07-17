;;; early-init.el --- 起動前の下ごしらえ -*- lexical-binding: t -*-

;;; Commentary:
;; フレーム生成前に効かせたい設定だけをここに置く。

;;; Code:

;; 起動中はGCを緩めて速くする(起動後に戻す)
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))

;; GUIの余計なバー類は最初から出さない
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

;; 起動時の白フラッシュ対策(catppuccin mocha の base/text)
(push '(background-color . "#1e1e2e") default-frame-alist)
(push '(foreground-color . "#cdd6f4") default-frame-alist)

(setq frame-inhibit-implied-resize t)
(setq inhibit-startup-screen t)
(setq native-comp-async-report-warnings-errors 'silent)

;;; early-init.el ends here
