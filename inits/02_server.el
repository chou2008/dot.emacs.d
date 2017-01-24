;; server start for emacs-client
(when window-system                       ; GUI時
  (require 'server)
  (unless (server-running-p)
    (server-start)

    (defun iconify-emacs-when-server-is-done ()
      (unless server-clients (iconify-frame)))

    ;; 編集が終了したらEmacsをアイコン化する(好みに応じて)
;;    (add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
    ;; C-x C-cに割り当てる(好みに応じて)
    (global-set-key (kbd "C-x C-c") 'server-edit)
    ;; M-x exitでEmacsを終了できるようにする
    (defalias 'exit 'save-buffers-kill-emacs)
    ;; 起動時に最小化する
    (add-hook 'after-init-hook 'iconify-emacs-when-server-is-done)

    ;; 終了時にyes/noの問い合わせ
    (if (eq window-system 'w32)
	(setq confirm-kill-emacs 'yes-or-no-p) ) 
    )
  )
