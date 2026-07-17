;;; my-completion.el --- 補完スタック -*- lexical-binding: t -*-

;;; Commentary:
;; ミニバッファ: vertico + orderless + marginalia + consult + embark
;; バッファ内:   corfu + cape(+ TTY 用に corfu-terminal)

;;; Code:

(use-package vertico
  :custom (vertico-cycle t)
  :config (vertico-mode 1))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :config (marginalia-mode 1))

(use-package consult
  :bind (("C-x b"   . consult-buffer)
         ("C-x p b" . consult-project-buffer)
         ("M-y"     . consult-yank-pop)
         ("M-s l"   . consult-line)
         ("M-s r"   . consult-ripgrep)
         ("M-s d"   . consult-find)
         ("M-g g"   . consult-goto-line)
         ("M-g i"   . consult-imenu)
         ("C-x r b" . consult-bookmark))
  :custom
  (consult-narrow-key "<"))

(use-package embark
  :bind (("C-." . embark-act)
         ("C-h B" . embark-bindings))
  :custom
  (prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.15)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  :config
  (global-corfu-mode 1)
  (corfu-popupinfo-mode 1))

;; TTY フレーム(herdr ペインの emacsclient -nw)でも corfu を出す
(use-package corfu-terminal
  :after corfu
  :config (corfu-terminal-mode 1))

(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-dabbrev))

(use-package nerd-icons-corfu
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(provide 'my-completion)
;;; my-completion.el ends here
