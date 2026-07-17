;;; my-org.el --- org-mode と文章執筆 -*- lexical-binding: t -*-

;;; Code:

(use-package org
  :ensure nil
  :custom
  (org-directory "~/org/")
  (org-agenda-files (list org-directory))
  (org-default-notes-file (expand-file-name "inbox.org" org-directory))
  (org-startup-indented t)
  (org-hide-emphasis-markers t)
  (org-ellipsis " …")
  (org-log-done 'time)
  :bind (("C-c o a" . org-agenda)
         ("C-c o c" . org-capture)
         ("C-c o o" . (lambda () (interactive) (find-file org-default-notes-file))))
  :config
  (make-directory org-directory t))

;; 見出し・バレットをかわいく
(use-package org-modern
  :hook (org-mode . org-modern-mode))

;; 執筆モード: 中央寄せの落ち着いたレイアウト(M-x olivetti-mode)
(use-package olivetti
  :custom (olivetti-body-width 90))

(provide 'my-org)
;;; my-org.el ends here
