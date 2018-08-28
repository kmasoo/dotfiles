
;;auto-package-updateでemacsのパッケージのアップデートを自動化する
;;(add-to-list 'load-path "/path/to/auto-package-update")

(use-package auto-package-update
;;(require 'auto-package-update)
  :ensure t
  :config
 (setq auto-package-update-interval 2)
 (setq auto-package-update-delete-old-versions t)
  (add-hook 'auto-package-update-before-hook
            (lambda () (message "I will update packages now"))))
;;  (save-window-excursion
    ;;                (auto-package-update-now))



