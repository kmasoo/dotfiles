;; SKK 使いの人への注意: dired-x を load すると、通常 skk の起動キーに使われている
;; C-x C-j が dired-jump に奪われてしまいます。 これを避けるには、フックを使って 


;; (add-hook 'dired-load-hook
;;           (lambda ()
;;             (load "dired-x")
;;             (global-set-key "\C-x\C-j" 'skk-mode)
;;             ))

;;---------------------------------------------------------------------- 
;; dired-x
;;---------------------------------------------------------------------- 
;; dired とは DIRectory EDitor の略です。 その昔 DOS を使っていた頃はファイラーを
;; 使っていた人も多いと思いますが、 そのようなモードです。
;; 現在の Emacs には dired の拡張版である dired-x も含まれています。
;; デフォルトでは、dired が使われます
;; dired を起動したときに dired-x の方が起動

 ;;; diredを便利にする
(require 'dired-x)

;;---------------------------------------------------------------------- 
;; wdired
;;---------------------------------------------------------------------- 
;;; バッファ内でファイル名、dir名の編集ができる！！
;;; dired使っている時にrを押して編集してC-x C-s押したらファイル名とか編集できます。
;;; また、拡張子 cpp を cxx に変更したいとすれば M - % で確認置換を起動し、cpp -> cxx と
;;; 置換すればOKです。
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;---------------------------------------------------------------------- 
;; uniquify
;;---------------------------------------------------------------------- 
;;; 同名ファイルのバッファ名の識別文字列を変更する
;;; デフォルトだと同じファイル名を複数開くと<1>,<2>と
;;; かついて全く区別できないので、以下の設定をしておくと
;;; 便利です。入っているディレクトリ名などで識別してくれます。
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)



;; 2画面なら他方にコピー
(setq dired-dwim-target t)

(defun dired-dwim-find-alternate-file ()
  "画面分割に適した `dired-find-alternate-file'．
通常は `dired-find-alternate-file' を行うが，画面分割されていて
他方のウィンドウに同じバッファが表示されていれば `dired-find-file'．"
  (interactive)
  (cond
   ;; 同じバッファが他のwindowにある場合
   ((delq (selected-window) (get-buffer-window-list))
    (dired-find-file))
   ;; 同じバッファが他のwindowにない場合
   (t
    (dired-find-alternate-file))))


(defun dired-up-alternate-directory ()
  "バッファを増やさず上のディレクトリに移動．"
  (interactive)
  (let* ((dir (dired-current-directory))
         (up (file-name-directory (directory-file-name dir))))
    (or (dired-goto-file (directory-file-name dir))
        ;; Only try dired-goto-subdir if buffer has more than one dir.
        (and (cdr dired-subdir-alist)
             (dired-goto-subdir up))
        (progn
          (find-alternate-file up)
          (dired-goto-file dir)))))


(defun dired-dwim-up-alternate-directory ()
  "画面分割に適した `dired-up-alternate-directory'．"
  (interactive)
  (cond
   ;; 同じバッファが他のwindowにある場合
   ((delq (selected-window) (get-buffer-window-list))
    (dired-up-directory))
   ;; 同じバッファが他のwindowにない場合
   (t
    (dired-up-alternate-directory))))


(defun dired-dwim-quit-window ()
  "画面分割に適した `quit-window'．"
  (interactive)
  (quit-window (not (delq (selected-window) (get-buffer-window-list)))))
