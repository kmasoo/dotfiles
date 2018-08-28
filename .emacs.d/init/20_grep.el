;;---------------------------------------------------------------------- 
;;; grep
;;---------------------------------------------------------------------- 
(use-package grep
;;(require 'grep)
:ensure t
:config
(setq grep-command-before-query "grep -nH -r -e ")
(defun grep-default-command ()
  (if current-prefix-arg
      (let ((grep-command-before-target
             (concat grep-command-before-query
                     (shell-quote-argument (grep-tag-default)))))
        (cons (if buffer-file-name
                  (concat grep-command-before-target
                          " *."
                          (file-name-extension buffer-file-name))
                (concat grep-command-before-target " ."))
              (+ (length grep-command-before-target) 1)))
    (car grep-command)))
(setq grep-command (cons (concat grep-command-before-query " .")
                         (+ (length grep-command-before-query) 1))))


;;---------------------------------------------------------------------- 
;; wgrep
;;---------------------------------------------------------------------- 
;; grep で絞り込んだ行を、そのバッファ内で直接編集することが出来る熱いモード
;; 使い方
;; 1 M-x grep*1で検索する
;; 2 *grep*バッファに移動し、C-c C-p でモードを切り替える
;; 3 良い感じに編集する
;; 4 C-c C-c で編集を反映する or C-c C-k で破棄する
;; 5 編集を反映してもファイル自体は保存されないので、保存する
(use-package wgrep
  :ensure t
  )
;;(require 'wgrep nil t)

