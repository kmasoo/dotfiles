

(use-package expand-region
  :ensure t
  :init
  :config
  ;; 真っ先に入れておかないとすぐに括弧に対応してくれない…
  (push 'er/mark-outside-pairs er/try-expand-list)

  ;; C-@: 押すごとにリージョンを広げる
  ;; C-M-@: 押すごとにリージョンを狭める
  ;(global-set-key (kbd "C-M-SPC") 'er/expand-region)
  (global-set-key (kbd "C-@") 'er/expand-region)
  (global-set-key (kbd "C-M-@") 'er/contract-region)
)

(use-package multiple-cursors
  :ensure t
  :init
    (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
    (global-set-key (kbd "C->") 'mc/mark-next-like-this)
    (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
    (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
)

;; 検索
;; リージョンにおける文字列を検索対象にインクリメンタルサーチを
;; 走らせることができる．ここではphi-searchを用いることにする．
;; このphi-searchはmultiple-cursor向けに設計してあるため，その相性は大変良い．
;; リージョンを程よく選択した後，sやrを押すことで，選択された文字列を対象に即座に
;; インクリメンタルサーチが発動する．続けてジャンプしたい場合はC-sやC-rを続けて押す．
;; 上記でC-sやC-rをはじめからバインドしなかった理由は，リージョンをisearchで
;; 広げることがしばしばあるためである．

(use-package phi-search
  :ensure t
  :init
  :config
  )

;;置換
;; リージョンの文字列を取得することさえできれば，それをクエリにして
;; 置換のコマンドを発動させることも可能である．
;; まず@rubikitch氏が作成したreplace-from-region.elをダウンロードして
;; ロードパスの通ったところに置き，以下を設定ファイルに追記しておく．

(use-package replace-from-region
  :ensure t
  :init
  :config
)


;; 特徴・利点
;; リージョン（最後にマークした箇所から現在のカーソル位置の間で囲まれた領域）を
;; 有効にした状態でのみ，region-bindings-modeというマイナーモードが発動する．
;; このマイナーモード下でのみ有効なキーバインドを設定することが可能なため，
;; 既存のキーバインドの設定が侵食されにくい，という利点がある.

(use-package region-bindings-mode
  :ensure t
  :init
  :config
  (region-bindings-mode-enable)
  (define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
  (define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
  (define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
  (define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)
  (define-key region-bindings-mode-map "s" 'phi-search)
  (define-key region-bindings-mode-map "r" 'phi-search-backward)
  (define-key region-bindings-mode-map "q" 'query-replace-from-region)
  (define-key region-bindings-mode-map "C-q" 'query-replace-regexp-from-region)
  )


