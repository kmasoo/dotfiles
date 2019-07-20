;;----------------------------------------------------------------------
;;; Ivy setting
;;----------------------------------------------------------------------

;;-------------------------------------
;; ivy設定
;;-------------------------------------
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 30) ;; minibufferのサイズを拡大！（重要）
  (setq ivy-extra-directories nil)
  (setq ivy-re-builders-alist
	'((t . ivy--regex-plus)))
  )

(setq counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))

;;-------------------------------------
;; counsel
;;-------------------------------------
(use-package counsel
  :ensure t
  :config
  )
;;-------------------------------------
;; counsel-etags
;;-------------------------------------
(use-package counsel-etags
  :ensure t
  :config
  )
;;-------------------------------------
;; counsel-gtags
;;-------------------------------------
(use-package counsel-gtags
  :ensure t
  :config
  )
;;-------------------------------------
;; all-the-icons-ivy
;;-------------------------------------
(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup)
)

(ivy-set-display-transformer 'ivy-switch-buffer 'all-the-icons-ivy-buffer-transformer)
;;-------------------------------------
;;swiper
;;-------------------------------------
(use-package swiper
  :ensure t
  :config
  )
;;(global-set-key "\C-s" 'swiper)
(setq swiper-include-line-number-in-search t) ;; line-numberでも検索可能

;; migemo + swiper（日本語をローマ字検索できるようになる
;;-------------------------------------
;; avy-migemo
;;-------------------------------------
(use-package avy-migemo
  :ensure t
  :config
  (avy-migemo-mode 1)
;;(require 'avy-migemo-e.g.swiper)
)

;;-------------------------------------
;; company
;;-------------------------------------
(use-package company
  :ensure t
  :config
  (global-company-mode) ; 全バッファで有効にする
  (setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
  (setq company-idle-delay 0) ; デフォルトは0.5
  (setq company-minimum-prefix-length 3) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
  (setq completion-ignore-case t)
  (setq company-dabbrev-downcase nil)
  (company-mode t) ;; 自動補完
)

(global-set-key (kbd "C-M-i") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う

;; yasnippetとの連携
;;-------------------------------------
;; yasnippet
;;-------------------------------------
(use-package yasnippet
  :ensure t
  :config
  )
;;(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(setq yas-snippet-dirs
    '("~/.emacs.d/yasnippets" ;; お好みで!!
    "~/.emacs.d/mysnippets"))
(yas-global-mode 1)

(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;;-------------------------------------
;; git-complete
;;-------------------------------------
;; git-complete
(require 'git-complete)



;;-------------------------------------
;; recentf
;;-------------------------------------
;; 余分なメッセージを削除しておきましょう
(defmacro with-suppressed-message (&rest body)
  "Suppress new messages temporarily in the echo area and the `*Messages*' buffer while BODY is evaluated."
  (declare (indent 0))
  (let ((message-log-max nil))
    `(with-temp-message (or (current-message) "") ,@body)))

(use-package recentf
  :ensure t
  :config
  (setq recentf-save-file "~/.emacs.d/recentf")
  (setq recentf-max-saved-items 200)             ;; recentf に保存するファイルの数
  (setq recentf-exclude '("recentf"))           ;; .recentf自体は含まない
  (setq recentf-auto-cleanup 'never)             ;; 保存する内容を整理
  (run-with-idle-timer 30 t '(lambda () (with-suppressed-message (recentf-save-list))))
)

;;(require 'recentf-ext) ;; ちょっとした拡張
;;-------------------------------------
;; recentf-ext
;;-------------------------------------
(use-package recentf-ext
  :ensure t
  :config
  )

;;-------------------------------------
;; neotree
;;-------------------------------------
(use-package neotree
  :ensure t
  :config
  (setq neo-theme 'ascii) ;; icon, classic等もあるよ！
  (setq neo-persist-show t) ;; delete-other-window で neotree ウィンドウを消さない
  (setq neo-smart-open t) ;; neotree ウィンドウを表示する毎に current file のあるディレクトリを表示する
  (setq neo-smart-open t)
  ;;(global-set-key "\C-o" 'neotree-toggle)
)

;;-------------------------------------
;; dumb-jump
;;-------------------------------------
(use-package dumb-jump
  :ensure t
  :config
  (setq dumb-jump-mode t)
  (setq dumb-jump-selector 'ivy) ;; 候補選択をivyに任せます
  (setq dumb-jump-use-visible-window nil)
)
;;(define-key global-map [(super d)] 'dumb-jump-go) ;; go-to-definition!
;;(define-key global-map [(super shift d)] 'dumb-jump-back)

;;-------------------------------------
;; ivy-rich
;;-------------------------------------
(use-package ivy-rich
  :ensure t
  :config
  (ivy-rich-mode 1)
)

(defun ivy-rich-switch-buffer-icon (candidate)
     (with-current-buffer
   	  (get-buffer candidate)
	(let ((icon (all-the-icons-icon-for-mode major-mode)))
	  (if (symbolp icon)
	      (all-the-icons-icon-for-mode 'fundamental-mode)
	    icon))))

(setq ivy-rich--display-transformers-list
      (plist-put ivy-rich--display-transformers-list
                 'ivy-switch-buffer
                 '(:columns
                   ((ivy-rich-switch-buffer-icon :width "2")
                    (ivy-rich-candidate (:width 30))
                    (ivy-rich-switch-buffer-size (:width 7))
                    (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
                    (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
                    (ivy-rich-switch-buffer-project (:width 15 :face success))
                    (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
                   :predicate
                   (lambda (cand) (get-buffer cand)))))



(global-set-key (kbd "C-s") 'swiper) ;; buffer内検索
(global-set-key (kbd "C-c C-c") 'git-complete) ;; gitによる補完
;;(global-set-key (kbd "super-shift-i") 'find-file-in-project) ;; ファイル検索
(global-set-key (kbd "C-x C-r") 'counsel-recentf) ;; 履歴によるファイル検索
;;(global-set-key (kbd "super-f") 'counsel-rg) ;; find-usage
(global-set-key (kbd "C-c C-d") 'dumb-jump) ;; go-to-definition
(global-set-key (kbd "C-x t") 'neotree) ;; ディレクトリツリー展開

(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
;;(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

;; これらは counsel-mode で自動で設定されるため、明示的に設定しなくてよい
;;(global-set-key (kbd "M-x") 'counsel-M-x)
;;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;(global-set-key (kbd "<f1> f") 'counsel-describe-function)
;;(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;;(global-set-key (kbd "<f1> l") 'counsel-load-library)
;;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

