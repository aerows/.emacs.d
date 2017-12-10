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

;; gui customization
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

;; general
(use-package general)
(setq general-default-keymaps 'evil-normal-state-map)
(setq my-leader1 ",")

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

;; evilmode
(use-package evil)
(evil-mode 1)

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

;; easy-motion
(use-package evil-easymotion
  :ensure t)
(evilem-default-keybindings "SPC")

;; seti
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'seti t)

(global-undo-tree-mode)
(tool-bar-mode -1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (general evil-leader use-package evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; keymaps

(general-define-key
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line)

;; leader maps
(general-define-key :prefix my-leader1
		    "e" 'find-file
		    "k" 'kill-buffer
		    "m" 'neotree-toggle
		    "n" 'neotree-project-dir
)

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
