(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Font
(custom-set-faces '(default ((t (:family "Noto Sans Mono")))))
(set-fontset-font t 'japanese-jisx0208
                  (font-spec :family "Noto sans CJK JP"))

;;; Package
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;;; No backup
(setq make-backup-files nil)

;;; Just spaces
(setq-default tab-width 4 indent-tabs-mode nil)

;;; cc-mode
(setq c-basic-offset 4)
(defun my-cc-setup ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-cc-setup)

;;; Eglot over Tramp
(with-eval-after-load "tramp"
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;;; No zenkaku-space hilighted
(when (>= emacs-major-version 28)
  (setq nobreak-char-display nil))

;;; Suppress '<key> is undefined'
(when (string= system-type "gnu/linux")
  (global-set-key (kbd "<henkan>") 'ignore)
  (global-set-key (kbd "<muhenkan>") 'ignore)
  (global-set-key (kbd "<Hangul>") 'ignore)
  (global-set-key (kbd "<Hangul_Hanja>") 'ignore))

;;; Hide tool bar
(tool-bar-mode 0)
