;; スタートアップページを表示しない
(setq inhibit-startup-message t)

;;
;;Emacs でビープ音を出さなくする
;;

(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;; 右から左に読む言語に対応させないことで描画高速化

(setq-default bidi-display-reordering nil)

;;; 同じ内容を履歴に記録しないようにする
(setq history-delete-duplicates t)


;; C-u C-SPC C-SPC ...でどんどん過去のマークを遡る
(setq set-mark-command-repeat-pop t)


;;isearch-wordが使用されていないための暫定対応
;;(setq search-default-mode t) 

;;---------------------------------------------------------------------- 
;;; ウインドウ幅、高さ設定
;;---------------------------------------------------------------------- 

(setq initial-frame-alist
      (append (list
        '(width .  95)
;;        '(width .  120)
        '(height . 35)
        )
        initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;;---------------------------------------------------------------------- 
;;; Fonts setting
;;---------------------------------------------------------------------- 

;; Ricty Discord
;; (cond (window-system
;; (set-face-attribute 'default nil
;;                     :family "Ricty Discord"
;;                     :height 120)
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0208
;;                   (cons "Ricty Discord" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0212
;;                   (cons "Ricty Discord" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'katakana-jisx0201
;;                   (cons "Ricty Discord" "iso10646-1"))
;; (setq w32-enable-synthesized-fonts t)

;; (add-to-list 'face-font-rescale-alist
;;              `(,(encode-coding-string "Ricty Discord" 'emacs-mule) . 0.9))
;; ))


;; Ricty
(cond (window-system
 (set-face-attribute 'default nil
                    :family "Ricty"
                    :height 120)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (cons "Ricty" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  (cons "Ricty" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'katakana-jisx0201
                  (cons "Ricty" "iso10646-1"))
(setq w32-enable-synthesized-fonts t)

(add-to-list 'face-font-rescale-alist
             `(,(encode-coding-string "Ricty" 'emacs-mule) . 0.9))
))

;; Ricty Diminished Discord Regular for Powerline
;; (cond (window-system
;; (set-face-attribute 'default nil
;;                     :family "Ricty Diminished Discord Regular for Powerline"
;;                     :height 120)
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0208
;;                   (cons "Ricty Diminished Discord Regular for Powerline" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0212
;;                   (cons "Ricty Diminished Discord Regular for Powerline" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'katakana-jisx0201
;;                   (cons "Ricty Diminished Discord Regular for Powerline" "iso10646-1"))
;; (setq w32-enable-synthesized-fonts t)

;; (add-to-list 'face-font-rescale-alist
;;              `(,(encode-coding-string "Ricty Diminished Discord Regular for Powerline" 'emacs-mule) . 0.9))
;; ))


;; MyricaM
;; (cond (window-system
;; (set-face-attribute 'default nil
;;                     :family "MyricaM"
;;                     :height 120)
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0208
;;                   (cons "MyricaM" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0212
;;                   (cons "MyricaM" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'katakana-jisx0201
;;                   (cons "MyricaM" "iso10646-1"))
;; (setq w32-enable-synthesized-fonts t)

;; (add-to-list 'face-font-rescale-alist
;;              `(,(encode-coding-string "MyricaM" 'emacs-mule) . 0.9))
;; ))

;; (set-face-attribute 'default nil
;;                    :family "Ricty"
;;                    :height 120)
;; (set-fontset-font
;;  nil 'japanese-jisx0208
;;  (font-spec :family "Ricty"))

;; 同様のフォント設定があればコメントアウトしておくべき
;; (set-frame-font "Ricty-12")
;; (set-frame-font "Ricty-13")
;; (set-frame-font "ricty-15")
;; (add-to-list 'default-frame-alist '(font . "Ricty-13.5"))

;;---------------------------------------------------------------------- 
;;;フレームに関する設定
;;---------------------------------------------------------------------- 

;;; メニューバーを消す
 (menu-bar-mode -1)

;;; ツールバーを消す
 (tool-bar-mode -1)

;;; カーソルの点滅をとめる
(blink-cursor-mode 0)

;;; カーソルの位置が何文字目かを表示する
(column-number-mode t)

;;; カーソルの位置が何行目かを表示する
(line-number-mode t)

;; ファイルサイズを表示
(size-indication-mode t)

;; 時計を表示（好みに応じてフォーマットを変更可能）
;; (setq display-time-day-and-date t) ; 曜日・月・日を表示
;;(setq display-time-24hr-format t) ; 24時表示
;;(display-time-mode t)

(setq frame-title-format "%f")

;; 行番号を常に表示する
(global-linum-mode t)

;;----------------------------------------------------------------------
;;;
;;----------------------------------------------------------------------

;;; 対応する括弧を光らせる
(show-paren-mode 1)

;;; ウィンドウ内に収まらないときだけカッコ内も光らせる
(setq show-paren-style 'mixed)

;;; 行末の空白を表示
(setq-default show-trailing-whitespace t)

;; ;;; 現在行を目立たせる
;; (defface hlline-face
;;   '((((class color)
;;       (background dark))
;;      ;;(:background "dark state gray"))
;;      (:background "white smoke"
;;                   :underline "light gray"))
;;     (((class color)
;;       (background light))
;;      (:background "white smoke"
;;                   :underline "light gray"))
;;     (t ()))
;;   "*Face used by hl-line.")
;; (setq hl-line-face 'hlline-face)
;; ;;(setq hl-line-face 'underline)
;; (global-hl-line-mode)

;; (defface hlline-face
;;   '((((class color)
;;       (background dark))
;;      ;;(:background "dark state gray"))
;;      (:background "gray10"
;;                   :underline "gray24"))
;;     (((class color)
;;       (background light))
;;      (:background "gray10"
;;                   :underline "gray24"))
;;     (t ()))
;;   "*Face used by hl-line.")
;; (setq hl-line-face 'hlline-face)
;; ;;(setq hl-line-face 'underline)
;; (global-hl-line-mode)


;;; 行の先頭をC-kを一回押すだけで行全体を表示する
;;; (setq kill-whole-line t)

;;; 最終行に必ず一行挿入する
;; (setq require-final-newline t)

;;; バッファの最後でnewlineで新規行を追加するのを禁止する
;; (setq next-line-add-newlines nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;バックアップとオートセーブ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; バックアップファイルを作らない
;; (setq make-backup-files nil) ; 初期値はt
;; オートセーブファイルを作らない
;; (setq auto-save-default nil) ; 初期値はt

;;; バックアップファイルの保存場所
;; (setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))
;;; 自動保存ファイルの保存場所
(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)


;;---------------------------------------------------------------------- 
;;;
;;---------------------------------------------------------------------- 

;;; 補完
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;;; 部分一致の補完機能を使う
;;; p-bでprint-bufferとか
;;;;; (partial-completion-mode t)

;; 補完可能なものを随時表示
(icomplete-mode 1)

;;; 履歴数
(setq history-length 10000)

;;; ミニバッファの履歴を保存する
(savehist-mode 1)

;;; 最近開いたファイルを保存する数
(setq recentf-max-saved-items 10000)

;;; ediffを1ウィンドウで実行
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; diffのオプション
(setq diff-switches '("-u" "-p" "-N"))

(when (fboundp 'w32-ime-initialize)
  (setq default-input-method "W32-IME")
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  (w32-ime-initialize)
  (add-hook 'input-method-activate-hook
            (lambda () (set-cursor-color "blue")))
  (add-hook 'input-method-inactivate-hook
            (lambda () (set-cursor-color "black")))
  (add-hook 'minibuffer-setup-hook
            (lambda ()
              (if (ime-get-mode)
                  (set-cursor-color "blue")
                (set-cursor-color "black"))))
  (global-set-key "\C-o" 'toggle-input-method))

;; skk と dired-x との競合回避
(setq dired-bind-jump nil)

;;---------------------------------------------------------------------- 
;;;
;;---------------------------------------------------------------------- 

;;; 対応する括弧を光らせる
(show-paren-mode 1)

;;; ウィンドウ内に収まらないときだけカッコ内も光らせる
(setq show-paren-style 'mixed)

;;; 行末の空白を表示
(setq-default show-trailing-whitespace t) 

;; ;;; 現在行を目立たせる
;; (defface hlline-face
;;   '((((class color)
;;       (background dark))
;;      ;;(:background "dark state gray"))
;;      (:background "white smoke"
;;                   :underline "light gray"))
;;     (((class color)
;;       (background light))
;;      (:background "white smoke"
;;                   :underline "light gray"))
;;     (t ()))
;;   "*Face used by hl-line.")
;; (setq hl-line-face 'hlline-face)
;; ;;(setq hl-line-face 'underline)
;; (global-hl-line-mode)

;; (defface hlline-face
;;   '((((class color)
;;       (background dark))
;;      ;;(:background "dark state gray"))
;;      (:background "gray10"
;;                   :underline "gray24"))
;;     (((class color)
;;       (background light))
;;      (:background "gray10"
;;                   :underline "gray24"))
;;     (t ()))
;;   "*Face used by hl-line.")
;; (setq hl-line-face 'hlline-face)
;; ;;(setq hl-line-face 'underline)
;; (global-hl-line-mode)


;;; 行の先頭をC-kを一回押すだけで行全体を表示する
;;; (setq kill-whole-line t)

;;; 最終行に必ず一行挿入する
;; (setq require-final-newline t)

;;; バッファの最後でnewlineで新規行を追加するのを禁止する
;; (setq next-line-add-newlines nil)

;; server start for emacs-client

;; (require 'server)
;; (unless (server-running-p)
;;   (server-start)
;;   (defun iconify-emacs-when-server-is-done ()
;;     (unless server-clients (iconify-frame) )
;;   )
;;   (add-hook 'server-done-hook 'iconify-emacs-when-server-is-done )
;;   (global-set-key (kbd "C-x C-c") 'server-edit)
;;   (defalias 'exit 'save-buffers-kill-emacs )
;; )


;; root 権限でファイルを開き直す

(defun reopen-with-sudo ()
  "Reopen current buffer-file with sudo using tramp."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (find-alternate-file (concat "/sudo::" file-name))
      (error "Cannot get a file name"))))

;; 自動で root 権限で開いてほしい

(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))

