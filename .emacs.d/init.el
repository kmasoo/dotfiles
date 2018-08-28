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
(require 'use-package)

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

;; (require 'server)
;; (unless (server-running-p) (server-start))


;; 変数 custom-file を設定するとカスタム内容が書き込まれるファイルを
;; 指定することができるので、これを利用して、custom.el に書き込むようにします。
;; そして起動時にこのファイルが存在すれば、それを読み込むことにします。

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(anzu-deactivate-region t)
 ;; '(anzu-mode-lighter "")
 ;; '(anzu-search-threshold 1000)
 '(inhibit-startup-screen nil)
 '(package-selected-packages
   (quote
    (use-package dash popup restart-emacs anzu auto-async-byte-compile package-utils auto-package-update org2elcomment wgrep sequential-command ruby-end ruby-electric ruby-block powerline popwin org-plus-contrib org multi-term moe-theme migemo markdown-mode init-loader inf-ruby geeknote enh-ruby-mode drill-instructor-AZIK-force cdb ccc auto-complete async anything))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
