;; ==========================================================
;; 1. 基本動作・表示設定
;; ==========================================================
;; スタートアップページを表示しない
(setq inhibit-startup-screen t)
;; (setq inhibit-startup-message t)
;; (setq inhibit-startup-echo-area-message t)

;; ビープ音を出さなくする
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)

;; 同じ内容を履歴に記録しない
(setq history-delete-duplicates t)

;; C-u C-SPC C-SPC ...でどんどん過去のマークを遡る
(setq set-mark-command-repeat-pop t)

;; ウインドウ幅、高さ設定
(setq initial-frame-alist
      (append (list
        '(width .  95)
        '(height . 36)
        )
        initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;; ==========================================================
;; 2. フォント設定 (白源 / HackGen)
;; ==========================================================
;; デフォルトフォントに白源 (HackGen) を設定
(set-face-attribute 'default nil
                    :family "HackGen"
                    :height 135)

;; 日本語・カタカナにも白源を割り当て
(let ((fontset (frame-parameter nil 'font)))
  (set-fontset-font fontset 'japanese-jisx0208 (cons "HackGen" "iso10646-1"))
  (set-fontset-font fontset 'japanese-jisx0212 (cons "HackGen" "iso10646-1"))
  (set-fontset-font fontset 'katakana-jisx0201 (cons "HackGen" "iso10646-1")))

;; ==========================================================
;; 3. フレーム・UIの外観設定
;; ==========================================================
;; メニューバー・ツールバーを非表示
(menu-bar-mode -1)
(tool-bar-mode -1)

;; カーソルの点滅を止める
(blink-cursor-mode 0)

;; 行番号・列番号・ファイルサイズを表示
(column-number-mode t)
(line-number-mode t)
(size-indication-mode t)

;; フレームタイトルにファイル名を表示
(setq frame-title-format "%f")

;; 対応する括弧を光らせる
(show-paren-mode 1)
(setq show-paren-style 'mixed)

;; 行末の空白を表示
(setq-default show-trailing-whitespace t)

;; ==========================================================
;; 4. バックアップとオートセーブの設定
;; ==========================================================
;; バックアップ・自動保存ファイルの保存場所を ~/.emacs.d/backup に集約
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))
(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; ==========================================================
;; 5. 補完・履歴の設定
;; ==========================================================
;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; 補完可能なものを随時表示
(icomplete-mode 1)

;; 履歴数とミニバッファ履歴の保存
(setq history-length 10000)
(savehist-mode 1)

;; 最近開いたファイルを保存する数
(setq recentf-max-saved-items 10000)

;; ==========================================================
;; 6. ユーティリティ関数・外部連携
;; ==========================================================
;; ediffを1ウィンドウで実行
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq diff-switches '("-u" "-p" "-N"))

;; skk と dired-x との競合回避
(setq dired-bind-jump nil)

;; --- root 権限でファイルを開き直す (sudo) ---
(defun reopen-with-sudo ()
  "現在のバッファをsudo権限で開き直します。"
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (find-alternate-file (concat "/sudo::" file-name))
      (error "ファイル名を取得できません"))))

;; 読み込み専用ファイルをrootで開くか確認する
(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File " (ad-get-arg 0) " is read-only. Open it as root? ")))
      (set-buffer (find-file (concat "/sudo::" (ad-get-arg 0))))
    ad-do-it))

;; Paradox (パッケージ管理の拡張)
(use-package paradox
 :ensure t
 :custom
 (paradox-github-token t))
