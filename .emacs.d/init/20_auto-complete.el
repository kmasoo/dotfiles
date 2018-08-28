;; auto complete
(use-package auto-complete-config
  ;;(require 'auto-complete-config)
  :ensure t
  :config
 (ac-config-default)
 (add-to-list 'ac-modes 'text-mode) )     ;; text-modeでも自動的に有効にする


