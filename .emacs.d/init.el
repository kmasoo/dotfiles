;;----------------------------------------------------------------------
;; package
;;----------------------------------------------------------------------


(require 'package)
;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; MELPA-stableを追加
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Marmaladeを追加
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; Orgを追加
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; 初期化
(package-initialize)

;;----------------------------------------------------------------------
;; init loader
;;----------------------------------------------------------------------

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/init")

(require 'server)
(unless (server-running-p) (server-start))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(helm-ff-auto-update-initial-value nil)
 '(inhibit-startup-screen nil)
 '(package-selected-packages
   (quote
    (auto-async-byte-compile package-utils auto-package-update org2elcomment wgrep sequential-command ruby-end ruby-electric ruby-block powerline popwin org-plus-contrib org multi-term moe-theme migemo markdown-mode init-loader inf-ruby geeknote enh-ruby-mode drill-instructor-AZIK-force cdb ccc auto-complete async anything))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
