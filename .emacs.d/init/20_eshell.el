

;; load environment value
(load-file (expand-file-name "~/.emacs.d/config/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))


