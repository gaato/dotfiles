(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(require 'package)

;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; MELPA-stableを追加
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Marmaladeを追加
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; Orgを追加
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; 初期化
(package-initialize)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; バックアップファイルを作成させない
(setq make-backup-files nil)

;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;; 列数を表示する
(column-number-mode t)

;; 行数を表示する
(global-linum-mode t)

;; カーソル行をハイライトする
(global-hl-line-mode t)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; スペース、タブなどを可視化する
;(global-whitespace-mode 1)

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; C-kで行全体を削除する
(setq kill-whole-line t)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

(electric-pair-mode 1)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)



(when (require 'ivy nil t)

  ;; M-o を ivy-hydra-read-action に割り当てる．
  (when (require 'ivy-hydra nil t)
    (setq ivy-read-action-function #'ivy-hydra-read-action))

  ;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める．
  (setq ivy-use-virtual-buffers t)

  ;; ミニバッファでコマンド発行を認める
  (when (setq enable-recursive-minibuffers t)
    (minibuffer-depth-indicate-mode 1)) ;; 何回層入ったかプロンプトに表示．

  ;; ESC連打でミニバッファを閉じる
  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  ;; プロンプトの表示が長い時に折り返す（選択候補も折り返される）
  (setq ivy-truncate-lines nil)

  ;; リスト先頭で `C-p' するとき，リストの最後に移動する
  (setq ivy-wrap t)

  ;; アクティベート
  (ivy-mode 1))


;; company
(use-package company
  :config
  (global-company-mode t)
  (global-set-key (kbd "<C-tab>") 'company-complete)
  (bind-keys :map company-active-map
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous))
  (bind-keys :map company-search-map
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous))
  (bind-keys :map company-active-map
             ("<tab>" . company-complete-selection))
  )
(use-package company-lsp :commands company-lsp)

(setq c-default-style "bsd"
      c-basic-offset 4)



(when (and (require 'python nil t) (require 'elpy nil t))
  (elpy-enable))

(when (require 'set-pyenv-version-path nil t)
 (add-to-list 'exec-path "~/.pyenv/shims"))


;; The `nimsuggest-path' will be set to the value of
;; (executable-find "nimsuggest"), automatically.
(setq nimsuggest-path "~/Nim/nimsuggest/nimsuggest")

(defun my--init-nim-mode ()
  "Local init function for `nim-mode'."

  ;; Just an example, by default these functions are
  ;; already mapped to "C-c <" and "C-c >".
  ;;(local-set-key (kbd "M->") 'nim-indent-shift-right)
 ;; (local-set-key (kbd "M-<") 'nim-indent-shift-left)

  ;; Make files in the nimble folder read only by default.
  ;; This can prevent to edit them by accident.
  (when (string-match "/\.nimble/" buffer-file-name) (read-only-mode 1))

  ;; If you want to experiment, you can enable the following modes by
  ;; uncommenting their line.
  (nimsuggest-mode 1)
  ;; Remember: Only enable either `flycheck-mode' or `flymake-mode' at the same time.
  (flycheck-mode 1)
  ;; (flymake-mode 1)

  ;; The following modes are disabled for Nim files just for the case
  ;; that they are enabled globally.
  ;; Anything that is based on smie can cause problems.
  ;; (auto-fill-mode 0)

  ;; (electric-indent-local-mode 0)
)

(add-hook 'nim-mode-hook 'my--init-nim-mode)



;; lsp-mode
(use-package lsp-mode
  :hook ((c-mode c++-mode) . lsp)
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil)
  ;;  (setq lsp-clients-clangd-executable "clangd-6.0")
  )
(use-package lsp-ui :commands lsp-ui-mode)





;; for AUCTeX 11.86
(setq japanese-LaTeX-command-default "latexmk")
(setq TeX-view-program-list '(("Mxdvi" "open -a Mxdvi.app %d")
                              ("TeXShop" "open -a TeXShop.app %o")
                              ("open" "open %o")
                              ))
(setq TeX-view-program-selection '((output-dvi "Mxdvi")
                                   (output-pdf "TeXShop")
                                   (output-html "open")
                                   ))
(add-hook 'LaTeX-mode-hook (function (lambda ()
    (add-to-list 'TeX-command-list
                 '("latexmk" "latexmk %t"
                   TeX-run-TeX nil (latex-mode) :help "Run ASCII pLaTeX"))
    (add-to-list 'TeX-command-list
                 '("pdfview" "open -a TeXShop.app '%s.pdf' " TeX-run-command t nil))
    )))

(require 'magic-latex-buffer)

(add-hook 'latex-mode-hook 'magic-latex-buffer)
;(setq magic-latex-enable-block-highlight nil
 ;     magic-latex-enable-suscript t
  ;    magic-latex-enable-pretty-symbols t
   ;   magic-latex-enable-block-align nil
    ;  magic-latex-enable-inline-image nil
     ; magic-latex-enable-minibuffer-echo nil)



;; design


(nyan-mode t)
(nyan-start-animation)
(nyan-toggle-wavy-trail)

  (use-package doom-themes
    :custom
    (doom-themes-enable-italic t)
    (doom-themes-enable-bold t)
    :custom-face
    (doom-modeline-bar ((t (:background "#6272a4"))))
    :config
    (load-theme 'doom-dracula t)
    (doom-themes-neotree-config)
    (doom-themes-org-config))

    (use-package doom-modeline
      :custom
      (doom-modeline-buffer-file-name-style 'truncate-with-project)
      (doom-modeline-icon t)
      (doom-modeline-major-mode-icon nil)
      (doom-modeline-minor-modes nil)
      :hook
      (after-init . doom-modeline-mode)
      :config
  ;;    (line-number-mode 0)
  ;;    (column-number-mode 0)
      (doom-modeline-def-modeline 'main
    '(bar buffer-position parrot)
    '(misc-info persp-name lsp debug minor-modes input-method major-mode process vcs checker)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-themes-enable-bold t)
 '(doom-themes-enable-italic t)
 '(package-selected-packages
   (quote
    (magic-latex-buffer xpm which-key use-package tern-auto-complete python-mode nyan-mode nim-mode material-theme lsp-ui lsp-treemacs lsp-ivy jedi-core go-autocomplete find-file-in-project elpy doom-themes doom-modeline company-lsp company-irony company-c-headers better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background "#6272a4")))))
