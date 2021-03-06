;;(package-initialize)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)

;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(elpy-enable)

;; gui customization
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

;; general (use-package general)
(setq general-default-keymaps 'evil-normal-state-map)
(setq my-leader1 ",")

;; Key-chord
(use-package key-chord
  :ensure t)
(key-chord-mode t)

;; evilmode
(use-package evil
  :ensure t)
(evil-mode 1)

;; evil-surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; projectile
(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-global-mode)) 

(use-package evil-mc
  :ensure t
  )

;; Line numbers
(use-package nlinum-relative
    :ensure t
    :config
    ;; something else you want
    (nlinum-relative-setup-evil)
    (add-hook 'prog-mode-hook 'nlinum-relative-mode)
    (setq nlinum-relative-redisplay-delay 0))

;; neo-theme
(use-package all-the-icons)
(use-package neotree :ensure t)
  
(setq neo-theme 'icons)
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)


(use-package find-file-in-project :ensure t)

(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (ffip-project-root))
	(file-name (buffer-file-name)))
    (if project-dir
	(progn
	  (neotree-dir project-dir)
	  (neotree-find file-name))
      (message "Could not find git project root."))))

;; Orgmode

(use-package org
  :ensure t)
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme))))
(use-package org-autolist
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-autolist-mode))))

(use-package magit
  :ensure t)

;; helm
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (setq heml-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (general-define-key "M-x" #'helm-M-x))

(use-package helm-projectile
  :ensure t)

;; Jumping Around

;; Ace-jump
(use-package ace-jump-mode
  :ensure t)

;; Ace-window
(use-package ace-window
  :ensure t)

;; easy-motion
(use-package evil-easymotion
  :ensure t)
(evilem-default-keybindings "SPC")

;; Multi-cursor
;; evil-mc
(use-package evil-mc
  :ensure t
  :config
  (global-evil-mc-mode 1)
  )

;; Themes
(use-package color-theme
  :ensure t
  :config
  (setq color-theme-is-global t)
  (color-theme-initialize))
;; leuven
(use-package leuven-theme
  :ensure t)

(use-package zenburn-theme
  :ensure t)

;; powerline
(use-package powerline
  :ensure t)

(load-theme 'zenburn t)

;; python
(use-package elpy
  :ensure t)
(use-package flycheck
  :ensure t)
(use-package py-autopep8
  :ensure t)

;; editing
(use-package visual-regexp
  :ensure t
  :config
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
  )
(use-package visual-regexp-steroids
	 :ensure t)

(global-undo-tree-mode)
(tool-bar-mode -1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-nlinum-relative-mode t)
 '(package-selected-packages
   (quote
    (visual-regexp-steroids py-autopep8 flycheck nlinum-relative zenburn-theme color-theme magit evil-mc org-autolist org-autolist-mode monitor evil-org leuven-theme ace-window ace-jump-mode elpy visual-fill-column writeroom-mode powerline powerline-evil general evil-leader use-package evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; keymaps

(general-define-key :prefix my-leader1
		    my-leader1 'helm-M-x 
		    )

(general-define-key
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line)

;; jump maps
(general-define-key :prefix "SPC"
		    "o" 'evil-jump-backward
		    "i" 'evil-jump-forward
		    "SPC" 'ace-jump-mode
)

;; leader maps
(general-define-key :prefix my-leader1
		    "e" 'find-file
		    "k" 'kill-buffer
		    "m" 'neotree-toggle
		    "n" 'neotree-project-dir
		    "b" 'switch-to-buffer
		    "r" 'load-file
;;		    "x" 'eshell
		    "." 'shell-command
)		    

;; Eval modes

(general-define-key :prefix ",x"
		    "X" 'eval-expression
		    "b" 'eval-buffer
		    "c" 'eval-current-buffer
		    "v" 'eval-region
		    "f" 'load-file
		    "s" 'eval-defun
		    "x" (lambda () (interactive) 'evil-end-of-line 'eval-last-sexp)
		    )
;; Visual modes
(general-define-key :prefix ",v"
		    "w" 'writeroom-mode
		    "l" (lambda () (interactive) (load-theme 'leuven t))
		    "d" (lambda () (interactive) (load-theme 'seti t))
		    "z" (lambda () (interactive) (load-theme 'zenburn t))
		    "n" (lambda () (interactive) (nlinum-mode t))
		    "N" (lambda () (interactive) (nlinum-mode -1))
		    "r" (lambda () (interactive) (nlinum-relative-on))
		    "R" (lambda () (interactive) (nlinum-relative-off))
		     )
;; Windows
(general-define-key :prefix ",w" 
		    "h" 'windmove-left
		    "l" 'windmove-right
		    "j" 'windmove-down
		    "k" 'windmove-up
		    "s" 'ace-swap-window
		    "N" 'split-window-below
		    "n" 'split-window-right
		    "d" 'delete-window
		    "D" 'delete-other-windows
)

;; Mutliple cursors


;; Characters 
(general-evil-define-key '(normal) neotree-mode-map
  "q" 'neotree-hide
  "I" 'neotree-hidden-file-toggle
  "z" 'neotree-stretch-toggle
  "R" 'neotree-refresh
  "r" 'neotree-change-root
  "m" 'neotree-rename-node
  "c" 'neotree-create-node
  "d" 'neotree-delete-node
  "s" 'neotree-enter-vertical-split
  "S" 'neotree-enter-horizontal-split
  "RET" 'neotree-enter
  "TAB" 'neotree-enter
  "SPC" 'neotree-quick-look)


;; (key-chord-define-global "hj" "Hello how do you do?")
;; Visual
(key-chord-define evil-insert-state-map "aa" (lambda () (interactive) (insert "å")))
(key-chord-define evil-insert-state-map "AA" (lambda () (interactive) (insert "Å")))
