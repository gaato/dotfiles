;;; my-editing.el --- 編集まわり -*- lexical-binding: t -*-

;;; Code:

(setq-default indent-tabs-mode nil)

(electric-pair-mode 1)
(delete-selection-mode 1)

;; 保存時の非同期フォーマット(フォーマッタは各言語のツールチェーン任せ)
(use-package apheleia
  :config (apheleia-global-mode 1))

;; 自分が触った行だけ行末空白を掃除する(エージェントのdiffを汚さない)
(use-package ws-butler
  :hook (prog-mode . ws-butler-mode))

;; 読みやすいヘルプ
(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)
         ("C-c C-d" . helpful-at-point)))

(provide 'my-editing)
;;; my-editing.el ends here
