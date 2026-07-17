;;; my-langs.el --- 言語サポート -*- lexical-binding: t -*-

;;; Commentary:
;; tree-sitter(ビルトイン treesit)+ eglot(ビルトイン)。
;; LSP サーバー本体は mise / uv / moon などで別途導入する。

;;; Code:

;; tree-sitter: grammar が無ければ確認の上ビルド、*-ts-mode へ自動リマップ
(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode 1))

;; eglot
(use-package eglot
  :ensure nil
  :custom (eglot-autoshutdown t)
  :hook ((go-ts-mode . eglot-ensure)
         (python-ts-mode . eglot-ensure)))

;; MoonBit(eglot は moonbit-ts-mode 側が moon lsp を自動起動する)
(use-package moonbit-ts-mode
  :vc (:url "https://github.com/moonbit-community/moonbit-ts-mode" :rev :newest)
  :init
  (add-to-list 'treesit-language-source-alist
               '(moonbit "https://github.com/moonbitlang/tree-sitter-moonbit.git" "main" "src"))
  (add-to-list 'treesit-language-source-alist
               '(moonbit_mbtp "https://github.com/moonbitlang/tree-sitter-moonbit.git"
                              "main" "grammars/mbtp/src")))

;; その他の言語モード
(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode))
(use-package nim-mode)
(use-package tuareg)
(use-package fish-mode)
(use-package terraform-mode)

(provide 'my-langs)
;;; my-langs.el ends here
