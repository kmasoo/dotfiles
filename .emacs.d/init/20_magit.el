
;; Magitを起動（M-x magit-status）してから、操作コマンドを入力する
;; C-x g	Magitを起動
;; C-x g ?	ヘルプの表示
;; C-x g g	現在のバッファの更新
;; C-x g q	バッファを閉じる
;; C-x g $	プロセス表示
;; C-x g y	ブランチやタグの一覧表示
;; C-x g b	ブランチ操作
;; C-x g c	コミット操作
;; C-x g f	フェッチ
;; C-x g F	プル
;; C-x g m	マージ操作
;; C-x g P	プッシュ操作
;; C-x g t	タグ操作


(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup))
  :init
  :config
)
