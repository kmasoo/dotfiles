
;; 指定できる色指定の一覧はM-x list-colors-displayで確認できる
;; カスタマイズしたテーマファイルは、M-x customize-create-themeを実行しても作成できる。

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(setq custom-theme-directory "~/.emacs.d/themes")

;; プリインストール番
;; (load-theme 'adwaita t)
;; (load-theme 'deeper-blue t)
;; (load-theme 'dichromacy t)
;; (load-theme 'leuven t)
;; (load-theme 'light-blue t)
;; (load-theme 'manoj-dark t)
;; (load-theme 'misterioso t)
;; (load-theme 'tango-dark t)
;; (load-theme 'tango t)
;; (load-theme 'tsdh-dark t)
;; (load-theme 'tsdh-light t)
;; (load-theme 'wheatgrass t)
;; (load-theme 'whiteboard t)
;; (load-theme 'wombat t)

;;目にやさしいダークなカラーテーマ
;;(load-theme 'madhat2r t)

;;カスタムテーマ
(load-theme 'my-manoj-dark_and_madhat2r t)
;;(load-theme 'vsc t)
