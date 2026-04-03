;;----------------------------------------------------------------------
;;; Ivy / Counsel / Swiper / Recentf Setting (完全修正版)
;;----------------------------------------------------------------------

;; --- 1. Ivy 基本設定 ---
(use-package ivy
  :ensure t
  :diminish
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)       ;; 最近開いたファイルを候補に含める
  (setq enable-recursive-minibuffers t)  ;; ミニバッファ内での再帰呼び出しを許可
  (setq ivy-height 30)                   ;; ミニバッファの高さを拡大
  (setq ivy-extra-directories nil)       ;; ./ ../ を候補から除外
  (setq ivy-re-builders-alist '((t . ivy--regex-plus)))
  (setq ivy-wrap t)                      ;; 候補の末尾で最初に戻る

  ;; --- ディレクトリ優先 & 昇順ソートの設定 ---
  ;; counsel-find-file 等でディレクトリを上に、ファイルを名前順に並べる
  (defun my-ivy-sort-directories-first (x y)
    "ディレクトリを優先し、その後名前順（昇順）でソートする。"
    (let ((x-dir (string-suffix-p "/" x))
          (y-dir (string-suffix-p "/" y)))
      (if (eq x-dir y-dir)
          (string< x y)
        x-dir)))

  (setq ivy-sort-functions-alist
        '((counsel-find-file . my-ivy-sort-directories-first)
          (read-file-name-internal . my-ivy-sort-directories-first)
          (t . string<))))

;; --- 2. Recentf (履歴管理) の修正 ---
;; recentfが効かない問題を解決するため、init段階でモードを起動し保存を強化します
(use-package recentf
  :ensure t
  :init
  (recentf-mode 1)                       ;; 起動時に即座に有効化
  :config
  (setq recentf-save-file (expand-file-name "recentf" user-emacs-directory))
  (setq recentf-max-saved-items 2000)    ;; 保存件数を拡張
  (setq recentf-exclude '(".recentf" "COMMIT_EDITMSG" "/tmp/" "/sudo:"))
  (setq recentf-auto-cleanup 'never)

  ;; アイドル時およびEmacs終了時に保存を確実に行う
  (run-with-idle-timer 30 t
    (lambda () (let ((message-log-max nil)) (with-temp-message "" (recentf-save-list)))))
  (add-hook 'kill-emacs-hook 'recentf-save-list))

;; --- 3. Counsel & Swiper ---
(use-package counsel
  :ensure t
  :diminish
  :config
  (setq counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
  (counsel-mode 1))

(use-package swiper
  :ensure t
  :config
  (setq swiper-include-line-number-in-search t))

;; --- 4. 補完・ジャンプ系 ---
(use-package company
  :ensure t
  :diminish
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (setq company-selection-wrap-around t)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/yasnippets" "~/.emacs.d/mysnippets"))
  (yas-global-mode 1))

(use-package neotree
  :ensure t
  :bind ("C-x t" . neotree-toggle)
  :config
  (setq neo-theme 'ascii)
  (setq neo-persist-show t)
  (setq neo-smart-open t))

(use-package dumb-jump
  :ensure t
  :config
  (setq dumb-jump-force-searcher 'rg)    ;; ripgrepを使用
  (setq dumb-jump-selector 'ivy)
  (dumb-jump-mode 1))

;; --- 5. Ivy-rich (見た目の拡張) ---
(use-package ivy-rich
  :ensure t
  :after (ivy counsel all-the-icons-ivy)
  :config
  (ivy-rich-mode 1))

(use-package all-the-icons-ivy
  :ensure t
  :config (all-the-icons-ivy-setup))

;; ==========================================================
;; キーバインド統合
;; ==========================================================
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-x C-r") 'counsel-recentf)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
