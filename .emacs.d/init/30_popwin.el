
;;---------------------------------------------------------------------- 
;; popwin
;;---------------------------------------------------------------------- 
;;; ヘルプバッファや補完バッファをポップアップで
;;; 表示してくれるpopwin.el
;;; mode-compileとか、補完とか、anythingとかが下からひょこっと
;;; 出てきて後から消せるので、画面構成が変わらないので便利です。

(setq pop-up-windows nil)

(use-package popwin
  :ensure
  :config
  (setq anything-samewindow nil)
  (setq display-buffer-function 'popwin:display-buffer)
  (push '("anything" :regexp t :height 0.5) popwin:special-display-config)
  (push '("*Completions*" :height 0.4) popwin:special-display-config)
  (push '("*compilation*" :height 0.4 :noselect t :stick t) popwin:special-display-config)
  :bind
)

;; (setq pop-up-windows nil)
;; (require 'popwin nil t)
;; (when (require 'popwin nil t)
;;   (setq anything-samewindow nil)
;;   (setq display-buffer-function 'popwin:display-buffer)
;;   (push '("anything" :regexp t :height 0.5) popwin:special-display-config)
;;   (push '("*Completions*" :height 0.4) popwin:special-display-config)
;;   (push '("*compilation*" :height 0.4 :noselect t :stick t) popwin:special-display-config)
;;   )

