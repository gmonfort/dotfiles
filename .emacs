;; Emacs configuration for nu7s :)
(setq nu7macs-path "~/.emacs.d/nu7macs")
(load-file (concat nu7macs-path "/init.el"))

;; Default font size 13pt.
(set-face-attribute 'default nil :height 130) 

;; Auto-generated configuration
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(font-use-system-font t)
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(safe-local-variable-values (quote ((eval add-hook (quote write-file-hooks) (quote time-stamp)))))
 '(scroll-bar-mode (quote right))
 '(truncate-lines t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
