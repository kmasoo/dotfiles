;;----------------------------------------------------------------------
;; package
;;----------------------------------------------------------------------

(require 'package)
;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; MELPA-stableを追加
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Orgを追加
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; 初期化
(package-initialize)

(unless (require 'use-package nil t)
  (unless package-archive-contents (package-refresh-contents))
  (package-install 'use-package))

;;----------------------------------------------------------------------
;; init loader (デーモン起動対応)
;;----------------------------------------------------------------------

(use-package init-loader
  :ensure t
  :config
  ;; デーモン起動の場合は、最初のフレーム（ウィンドウ）が作成された時に設定をロードする
  ;; これにより "Fontset ‘tty’ does not exist" エラーを回避し、GUI設定を正しく反映させる
  (if (daemonp)
      (add-hook 'after-make-frame-functions
                (lambda (frame)
                  (with-selected-frame frame
                    (init-loader-load "~/.emacs.d/init"))))
    ;; 通常起動の場合は即座にロード
    (init-loader-load "~/.emacs.d/init")))

;;----------------------------------------------------------------------
;; server / emacsclient 設定
;;----------------------------------------------------------------------

(require 'server)
;; すでにサーバーが動いていない場合のみ起動
(unless (server-running-p)
  (server-start))

;; 編集終了時にフレームをアイコン化する設定（元の設定を維持）
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))

(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)

;; C-x C-c で Emacs を終了させず、サーバー編集終了（clientを閉じる）にする
;;(global-set-key (kbd "C-x C-c") 'server-edit)

;;----------------------------------------------------------------------
;; Custom-file 設定
;;----------------------------------------------------------------------
;; 変数 custom-file を設定するとカスタム内容が書き込まれるファイルを分離できる
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
