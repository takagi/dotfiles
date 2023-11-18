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

;;; Packages
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;;; Go
(use-package go-mode
  :ensure t
  :commands go-mode
  :hook (go-mode . eglot-ensure)
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))
(use-package gotest
  :after go-mode
  :bind (:map go-mode-map
              ("C-c t t" . go-test-current-test)
              ("C-c t f" . go-test-current-file)
              ("C-c t p" . go-test-current-project)))

;;; Dockerfile
(use-package dockerfile-mode
  :ensure t
  :mode "Dockerfile\\'")

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

;;; Symbol font
(setq use-default-font-for-symbols nil)

;;; corfu
(use-package corfu
  :ensure t
  :init
  (setq corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-prefix 1
        corfu-cycle t
        corfu-preselect-first t
        tab-always-indent 'complete)
  (global-corfu-mode 1))
(use-package corfu-terminal
  :ensure t
  :if (not (display-graphic-p))
  :after corfu
  :config
  (corfu-terminal-mode +1))

;;; cape
(use-package cape
  :ensure t
  :hook ((prog-mode . %setup-cape)
         (lisp-interaction-mode . %setup-cape))
  :init
  (defun %setup-cape ()
    (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (add-to-list 'completion-at-point-functions #'cape-file)))

;;; vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;;; orderless
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)))

;; consult
(use-package consult
  :ensure t
  :bind (("C-x C-f" . consult-locate)
         ("C-x f" . consult-fd)
         ("C-s" . consult-line)
         ("C-c i" . consult-imenu)))

;;; treemacs
(use-package treemacs
  :ensure t
  :config
  (treemacs-load-theme "Default"))
