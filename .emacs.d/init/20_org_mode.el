
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


;;--------------------------------------------------------------------------
;; org 設定
;;--------------------------------------------------------------------------
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
  (setq org-directory "~/Dropbox/prj/documents/org/")
  ;; org-default-notes-fileのファイル名
  (setq org-default-notes-file "captured.org")
  :mode (("\\.txt$" . org-mode))
  :bind (
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c b" . org-iswitchb)
  ("C-c c" . org-capture)
  ("C-c r" . org-remember))
  :init
  ;; 保存先（もっとうまく書けたらいいのになぁ）
  (setq my-org-directory "~/Dropbox/prj/documents/org/")
  (setq my-org-agenda-directory "~/Dropbox/prj/documents/org/")
  (setq my-org-default-notes-file "~/Dropbox/prj/documents/org/captured.org") ;; org-captureしたときのとりあえずの保存先
  :config
  ;; 基本設定
  ;; Hide the first N-1 stars in a headline : nil --> t
  (setq org-hide-leading-stars t)
  ;; RET will follow the link : nil --> t
  (setq org-return-follows-link t)

  (setq org-directory my-org-directory)
  (setq org-agenda-files (list my-org-directory my-org-agenda-directory))
  ;; Default target for storing notes : "~/.notes" --> "captured.org"
  (setq org-default-notes-file my-org-default-notes-file)


;;--------------------------------------------------------------------------
;; org-capture setting
;;--------------------------------------------------------------------------

  ;;ファイルパスの設定
  (setq listfile "~/Dropbox/prj/documents/org/list.org")

  (setq org-capture-templates
      '(
	("a" "あっと思ったことを さっとφ(..)メモする" entry (file+headline "" "MEMO") "* %U%?\n\n%a\n%F\n" :empty-lines 1)
	("n" "ノートブック" entry (file+headline "" "NOTE") "* %?\n   Entered on %U" :empty-lines 1 :jump-to-captured 1)
	("p" "ぱっと 読み返したいと思ったとき" plain (file+headline "" "PLAIN") "%?" :empty-lines 1 :jump-to-captured 1 :unnarrowed 1)
	("t" "とりあえず 仕事(TODO)を放り込む" entry (file+headline "" "GTD") "** TODO %T %?\n   Entered on %U    %i\n" :empty-lines 1)
        ("s" "タスク（スケジュールあり）" entry (file+headline "" "Tasks")  "** TODO %? \n   SCHEDULED: %^t \n")
        ("l" "やりたいこと" checkitem (file+headline listfile "やりたいこと") "[ ] %? \n")
        ("b" "欲しいもの" checkitem (file+headline listfile "欲しいもの")  "[ ] %? \n")
        ("g" "行きたいところ" checkitem (file+headline listfile "行きたいところ") "[ ] %? \n")
	))

;;--------------------------------------------------------------------------
; メモをC-M-^一発で見るための設定(必要ないかも)
;;--------------------------------------------------------------------------
; https://qiita.com/takaxp/items/0b717ad1d0488b74429d から拝借
(defun show-org-buffer (file)
  "Show an org-file FILE on the current buffer."
  (interactive)
  (if (get-buffer file)
      (let ((buffer (get-buffer file)))
        (switch-to-buffer buffer)
        (message "%s" file))
    (find-file (concat "~/Dropbox/prj/documents/org/" file))))
(global-set-key (kbd "C-M-^") '(lambda () (interactive)
                                 (show-org-buffer "captured.org")))

;;--------------------------------------------------------------------------
;; org-agenda setting
;;--------------------------------------------------------------------------
  (setq org-todo-keywords
        '((sequence "APPT(a@/!)" "TODO(t)" "STARTED(s!)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCEL(c@/!)")))
  (setq org-log-done 'time)   ;;; DONEの時刻を記録

  (setq org-tag-alist
        '((:startgroup . nil)
          ("HOME" . ?h) ("OFFICE" . ?o)("IPNSPR" . ?i)("KEKPR" . ?k)
          (:endgroup . nil)
          (:newline . nil)
          (:startgroup . nil)
          ("TOPICS" . ?t) ("PRESS" . ?p)("HIGHLIGHT" . ?l)("EVENT" . ?e)
          (:endgroup . nil)
          (:newline . nil)
          (:startgroup . nil)
          ("T2K" . nil) ("BELLE" . nil)("COMET" . nil)
          (:endgroup . nil)
          (:newline . nil)
          (:startgroup . nil)
          ("READING" . ?r) ("WRITING" . ?w)("ASKING" . ?a)
          (:endgroup . nil)))

  ;; アジェンダ表示で下線を用いる
  (add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
  ;; refile setting
  (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))


;;--------------------------------------------------------------------------
;; image 表示設定
;;--------------------------------------------------------------------------

  ;;一律に指定する場合

  ;;若干のハマりポイントなのですが、org-element-propertyに正しく反応させないと
  ;;アトリビュートが正しく解釈されないので、画像リンクの前にハイフン等が付いているとダメ
  (setq org-image-actual-width 256)

  ;;個別に指定する場合
  ;;   アトリビュートを使用して、横幅を指定します。#+ATTR_で始まっていれば正規表現で
;;   勝手に解釈されますが、とりあえず#+ATTR_HTMLを使いましょう。
;;   コロンの位置などフォーマットに気をつけてください。
;;   以下のようにすると、横幅100ピクセルでインライン表示されます。

  ;; #+ATTR_HTML: :width 100
;;   もう一つ重要な設定。実は、上記のアトリビュート指定と同時に、
;;   やはりorg-image-actual-widthの設定が必要です。しかも、数値指定ではなくリスト型でないとだめです。
;;   以下のように設定すれば、アトリビュート指定がある時にはその値を優先し、無ければ
;;   org-image-actual-widthの数値が使われます。

;; (setq org-image-actual-width '(256))
;; それから、若干のハマりポイントなのですが、org-element-propertyに正しく反応させないと
;; アトリビュートが正しく解釈されないので、画像リンクの前にハイフン等が付いているとダメ

;;   これでめでたくorgバッファでもJPEG 2000画像がインライン表示されるようになります。
;;   Orgバッファで次のように画像へのリンク記載します。ちなみにリンク上で、C-c C-oすれば、
;;   別バッファにフルサイズの画像がレンダリングされます。

;; #+ATTR_HTML: :width 128
;; [[~/Desktop/lena_std.jp2]]

;; [[~/Desktop/lena_std.jp2]]

;; #+BEGIN_SRC emacs-lisp
;; (org-toggle-inline-images)
;; #+END_SRC
;; org-toggle-inline-imagesを評価します。上の例では、org-toggle-inline-imagesの行に
;; カーソルを置いて、C-c C-cすればOKです。以下のように表示が切り替わると思います。
;; 大元の画像は、横幅が512ピクセルですから、アトリビュート指定で128ピクセルに、
;; 指定なし（デフォ値反映）で256ピクセルにリサイズされています。


)


;;--------------------------------------------------------------------------
;; org-attach-screenshot
;;--------------------------------------------------------------------------
(use-package org-attach-screenshot
  :ensure t
  :init
  :config
  :bind
   ("C-c t" . org-attach-screenshot)
   )

;;--------------------------------------------------------------------------
;; org-download
;;--------------------------------------------------------------------------
;; キルバッファに画像ファイル名やURLを入れた上で、 M-x org-download-yank を
;; 実行すると、ドラッグ&ドロップしたときと同様に画像が挿入される。
;; 何の役に立つんだという人もいるだろうが、実は Dired で画像ファイルの上で 0 w
;; と打つとそのファイルの場所がキルバッファに入るので、すでにローカルにある
;; 画像を簡単に挿入することが出来るのである。
;; また、M-x org-download-screenshotを実行し、適当なウィンドウ上でクリックすると、
;; そのウィンドウのスクリーンショットが挿入される。
(use-package org-download
  :ensure t
  :init
  :config
  (setq-default org-download-image-dir "~/Dropbox/prj/documents/org/image")

  )
