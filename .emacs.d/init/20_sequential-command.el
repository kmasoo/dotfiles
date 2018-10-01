;;(require 'sequential-command)
(use-package sequential-command
  :ensure
  :config
  (define-sequential-command seq-home
  back-to-indentation  beginning-of-line beginning-of-buffer seq-return)

  (define-sequential-command seq-end
  end-of-line end-of-buffer seq-return)
  :bind
  ("C-a" . seq-home)
  ("C-e" . seq-end)
  )
