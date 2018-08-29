
;;---------------------------------------------------------------------- 
;;; org-mode
;;---------------------------------------------------------------------- 

;; orgモードの使い方
;; http://d.hatena.ne.jp/tamura70/20100203/org


;; * 見出し
;; ** 子見出し
;; *** 孫見出し
;;  - 項目1
;;    - 子項目1
;;    - 子項目2
;;  - 項目2
;; *** 孫見出し
;;  1. 最初の項目
;;  2. 二番目の項目
;; * 別の見出し
;; ** 名前付き項目リスト
;;  - 名前1 :: 内容1
;;  - 名前2 :: 内容2
;; ** チェックリスト [/]
;;  - [ ] チェック項目1
;; - [ ] チェック項目2


;;  見出しの構造の編集
;; 「見出し」の行で，タブキーを入力すると，それ以下の行を折りたたんで隠したり展開して表示したりを切り替えることができる．
;; また「M-UP」や「M-DOWN」で見出しの場所の移動，「M-RIGHT」や「M-LEFT」で見出しのレベルの変更ができる．
;; さらに「M-S-RIGHT」や「M-S-LEFT」で子孫の見出しも含めて，見出しのレベルを変更できる!

;; TAB	見出し以下を隠す/一段展開/すべて展開
;; M-RET	同一レベルで新しい見出しの行を挿入する
;; M-UP	見出しを前に移動
;; M-DOWN	見出しを後に移動
;; M-RIGHT	見出しのレベルを増やす
;; M-LEFT	見出しのレベルを減らす
;; M-S-RIGHT	子孫も含めて見出しのレベルを増やす
;; M-S-LEFT	子孫も含めて見出しのレベルを減らす
;; C-u C-u C-u TAB	すべてを展開して表示

;;  項目の構造の編集
;; 「-」や「+」，あるいは「1.」等により項目リストを記述できる．同一レベルの項目は，同じインデントレベルにしておく．
;; 項目の構造の編集は，見出しの編集と同様に可能である．
;; TAB	項目以下を隠す/一段展開/すべて展開
;; M-RET	同一レベルで新しい項目の行を挿入する
;; M-UP	項目を前に移動
;; M-DOWN	項目を後に移動
;; M-RIGHT	子孫も含めて項目のレベルを増やす
;; M-LEFT	子孫も含めて項目のレベルを減らす
;; C-c C-c	番号付き項目リストの番号を付け直す
;; M-q	長い文章を整形(fill-paragraph)

;;  検索
;; org-modeでは，検索した結果などについて，不要な部分を折りたたんだスパース木の形で表示することができる．
;; C-c / /	正規表現で検索した結果をスパース木表示

;;(require 'org)
(use-package org
  :ensure
  :config
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-log-done t)
  ;; org-modeでの強調表示を可能にする
  (add-hook 'org-mode-hook 'turn-on-font-lock)
  ;; 見出しの余分な*を消す
  (setq org-hide-leading-stars t)
  ;; org-default-notes-fileのディレクトリ
  (setq org-directory "~/org/")
  ;; org-default-notes-fileのファイル名
  (setq org-default-notes-file "notes.org")

  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c r" . org-remember)
)
;; ;; キーバインドの設定
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (define-key global-map "\C-cr" 'org-remember)

;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (setq org-log-done t)
;; ;; org-modeでの強調表示を可能にする
;; (add-hook 'org-mode-hook 'turn-on-font-lock)
;; ;; 見出しの余分な*を消す
;; (setq org-hide-leading-stars t)
;; ;; org-default-notes-fileのディレクトリ
;; (setq org-directory "~/org/")
;; ;; org-default-notes-fileのファイル名
;; (setq org-default-notes-file "notes.org")


