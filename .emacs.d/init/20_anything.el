;;---------------------------------------------------------------------- 
;;;anything setting
;;---------------------------------------------------------------------- 

;; anoything がパッケージから消えたので下記のサイトから取得する必要がある。
;; emacsatticにあるrepositoryを使う https://github.com/emacsattic/anything
;; emacswikiのmirrorの方を使う https://github.com/emacsmirror/emacswiki.org/blob/master/anything.el


(require 'anything-startup)

(require 'anything-config)
(setq anything-enable-shortcuts 'prefix)
(define-key anything-map (kbd "@") 'anything-select-with-prefix-shortcut)
(define-key global-map (kbd "M-x")     'anything-M-x)
(define-key global-map (kbd "C-x C-f") 'anything-find-files)
(define-key global-map (kbd "C-x C-r") 'anything-recentf)
(define-key global-map (kbd "C-c i")   'anything-imenu)
(define-key global-map (kbd "C-c h")   'anything-mini)
(define-key global-map (kbd "C-x b")   'anything-buffers-list)
;;(define-key helm-map (kbd "C-h") 'delete-backward-char);
;;(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
;;(define-key helm-find-files-map (kbd "TAB") 'anything-execute-persistent-action)
;;(define-key helm-read-file-map (kbd "TAB") 'anything-execute-persistent-action)


(require 'anything-match-plugin)


;; anything-for-document

(setq anything-for-document-sources
      (list anything-c-source-man-pages
	    anything-c-source-info-cl
	    anything-c-source-info-elisp
	    anything-c-source-apropos-emacs-commands
	    anything-c-source-apropos-emacs-functions
	    anything-c-source-apropos-emacs-variables))

;; anything-for-document

(defun anything-for-document ()
  "Preconfigured 'anything' for anything-for-document."
  (interactive)
  (anything anything-for-document-sources
	    (thing-at-point 'symbol) nil nil nil
	    "*anything for document*"))
