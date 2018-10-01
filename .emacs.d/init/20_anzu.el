
;; 常に有効にしたい方は以下のように global-anzu-modeを有効にしてください
;; anzu-mode-ligterはモードラインに表示されるマイナーモード名です. 常に anzu-modeを
;; 有効にするのであれば空文字列で良いでしょう.

;; anzu-deactivate-regionは後述の置換コマンドをリージョン指定で行ったときに,
;; コマンド実行直後リージョンのハイライトを無効にするかどうかの設定です.
;; 色がついたまま置換を行うと, インタラクティブに挿入される文字列が見づらいので
;; 置換コマンドを使うのであればこの変数を tにすることを推奨します.

;; anzu-search-thresholdは全体のマッチ数を数えるときに, この数以上は数えない
;; ようにするというものです. 巨大なバッファで検索文字列と一致するものが数万,
;; 数十万となったとき, 検索が非常に遅くなってしまいます. きっちり全体数を知りたい
;; という場合は別ですが, 多くの場合は「たくさんマッチする」という情報を知れれば
;; 十分です. この変数に自分が多いと感じる数を設定しておくことで, 検索に余計な
;; 時間を使うことを回避できます.

;; migemoユーザは anzu-use-migemoを tにすることで, 日本語検索にも
;; 対応できます.

(use-package anzu
;;(require 'anzu)
  :ensure t
  :init
  (global-anzu-mode +1)

  :config
  (setq anzu-deactivate-region t)
  (setq anzu-search-threshold 1000)
  (setq anzu-use-migemo t)
  (setq anzu-minimum-input-length 3)


  ;; 置換コマンド
  (global-set-key (kbd "C-c r") 'anzu-query-replace)
  (global-set-key (kbd "C-c R") 'anzu-query-replace-regexp))

