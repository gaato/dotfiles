;;; my-ui.el --- 見た目(かわいい担当) -*- lexical-binding: t -*-

;;; Commentary:
;; catppuccin mocha + HackGen + nerd-icons + dashboard で「かわいい」を作る。
;; daemon 運用のため、フォント設定はフレーム生成時フックでも走らせる。

;;; Code:

;; テーマ
(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'latte)
  (load-theme 'catppuccin :no-confirm))

;; フォント: HackGen35 Console NF(JP + Nerd Font グリフ入り)
(defun my/setup-fonts (&optional frame)
  "FRAME(省略時は選択フレーム)にフォントを設定する。"
  (when (display-graphic-p frame)
    (with-selected-frame (or frame (selected-frame))
      (set-face-attribute 'default nil :family "HackGen35 Console NF" :height 130)
      (set-face-attribute 'fixed-pitch nil :family "HackGen35 Console NF")
      (set-face-attribute 'variable-pitch nil :family "Noto Sans CJK JP")
      (dolist (script '(han kana cjk-misc symbol))
        (set-fontset-font t script "HackGen35 Console NF"))
      (set-fontset-font t 'emoji "Noto Color Emoji"))))
(add-hook 'after-make-frame-functions #'my/setup-fonts)
(my/setup-fonts)

;; アイコン(HackGen NF のグリフをそのまま使う)
(use-package nerd-icons
  :custom (nerd-icons-font-family "HackGen35 Console NF"))
(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode 1)
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup))
(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

;; モードライン
(use-package doom-modeline
  :custom
  (doom-modeline-height 28)
  (doom-modeline-buffer-encoding 'nondefault)
  :config
  (doom-modeline-mode 1))

;; スタートアップ画面
(use-package dashboard
  :custom
  (dashboard-banner-logo-title "便利で最強でかわいい")
  (dashboard-startup-banner (expand-file-name "assets/banner.txt" user-emacs-directory))
  (dashboard-center-content t)
  (dashboard-icon-type 'nerd-icons)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-projects-backend 'project-el)
  (dashboard-items '((recents . 8) (projects . 5) (bookmarks . 3)))
  :config
  ;; emacsclient で開いた最初のフレームにも dashboard を出す
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (dashboard-setup-startup-hook))

;; ウィンドウまわりの余白でやわらかく
(use-package spacious-padding
  :custom
  (spacious-padding-widths '(:internal-border-width 12
                             :right-divider-width 12
                             :mode-line-width 3
                             :scroll-bar-width 0))
  :config
  (spacious-padding-mode 1))

;; 括弧をパステルに
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; モードラインを Nyan Cat が横断する(doom-modeline では misc-info 経由で表示)
(use-package nyan-mode
  :custom
  (nyan-animate-nyancat t)
  (nyan-wavy-trail t)
  (nyan-bar-length 24)
  :config
  (nyan-mode 1)
  (add-to-list 'mode-line-misc-info
               '(:eval (when (and nyan-mode (display-graphic-p))
                         (list (nyan-create))))))

;; ジャンプ時にカーソルがぽわっと光る
(use-package pulsar
  :config
  (pulsar-global-mode 1))

;; 行番号・カーソル行
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'conf-mode-hook #'display-line-numbers-mode)
(column-number-mode 1)
(global-hl-line-mode 1)

(provide 'my-ui)
;;; my-ui.el ends here
