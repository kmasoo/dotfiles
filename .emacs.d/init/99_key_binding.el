;;---------------------------------------------------------------------- 
;;; キーバインド setting
;;---------------------------------------------------------------------- 

;;(define-key global-map (kbd "C-h") 'delete-backward-char)   ; 削除
;;(define-key key-translation-map [?\C-h][?\C-?]) 'delete-backward-char)   ; 削除
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))  ; ctrl + h で削除
(define-key global-map (kbd "M-?") 'help-for-help)          ; ヘルプ
(define-key global-map (kbd "C-z") 'undo)                   ; undo
(define-key global-map (kbd "C-c i") 'indent-region)        ; インデント
(define-key global-map (kbd "C-t") 'other-window)              ; window分割、移動
(define-key global-map (kbd "M-C-g") 'grep)                 ; grep
(define-key global-map (kbd "C-[ M-C-g") 'goto-line)        ; 指定行へ移動
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines);折り返しトグルコマンド


