;;----------------------------------------------------------------------
;; package
;;----------------------------------------------------------------------


(require 'package)
;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; MELPA-stableを追加
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Marmaladeを追加
;; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; Orgを追加
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; 初期化
(package-initialize)

;;(unless package-archive-contents
;;  (package-refresh-contents))
;;;;; ensure to use use-package
;;(when (not (package-installed-p 'use-package))
;;  (package-install 'use-package))

(unless (require 'use-package nil t)
    (unless package-archive-contents (package-refresh-contents))
    (package-install 'use-package))

;;----------------------------------------------------------------------
;; use-packageを使用する
;;----------------------------------------------------------------------
;;(require 'use-package)

;;----------------------------------------------------------------------
;; init loader
;;----------------------------------------------------------------------

;; (require 'init-loader)
;; (setq init-loader-show-log-after-init nil)
;; (init-loader-load "~/.emacs.d/init")

(use-package init-loader
  :ensure t
  :config
  (init-loader-load "~/.emacs.d/init"))


;; (use-package server)
;; (unless (server-running-p)
;;    (server-start)
;;    (defun iconify-emacs-when-server-is-done ()
;;      (unless server-clients (iconify-frame) )
;;    )
;;    (add-hook 'server-done-hook 'iconify-emacs-when-server-is-done )
;;    (global-set-key (kbd "C-x C-c") 'server-edit)
;;    ;;(defalias 'exit 'save-buffers-kill-emacs )
;;  )

;; 変数 custom-file を設定するとカスタム内容が書き込まれるファイルを
;; 指定することができるので、これを利用して、custom.el に書き込むようにします。
;; そして起動時にこのファイルが存在すれば、それを読み込むことにします。

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

