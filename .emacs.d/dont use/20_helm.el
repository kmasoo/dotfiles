;;----------------------------------------------------------------------
;; helm setting
;;----------------------------------------------------------------------
(setq ad-redefinition-action 'accept)

(when (require 'helm-config nil t)
      (require 'helm-descbinds)
      (require 'helm-migemo)
      (require 'helm-swoop)
      (require 'helm-gtags)
(helm-mode 1))

(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-c h")   'helm-mini)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)


;; 文字列を入力してから検索するまでのタイムラグを設定する（デフォルトは 0.01）
;;(setq helm-input-idle-delay 0.2)

;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))


;; C-h でバックスペースと同じように文字を削除できるようにする
;; (define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)

;; TAB で補完する
;; (define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)

;; helm で正しく migemo を動作させるための対策
;; http://rubikitch.com/2014/12/19/helm-migemo/
;; https://github.com/emacs-helm/helm/pull/379

(defun helm-compile-source--candidates-in-buffer (source)
  (helm-aif (assoc 'candidates-in-buffer source)
      (append source
              `((candidates
                 . ,(or (cdr it)
                        (lambda ()
                          ;; Do not use `source' because other plugins
                          ;; (such as helm-migemo) may change it
                          (helm-candidates-in-buffer (helm-get-current-source)))))
                (volatile) (match identity)))
    source))
