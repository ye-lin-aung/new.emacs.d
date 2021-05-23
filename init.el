;; ---------------------------------------------------------------------
;; GNU Emacs / N Λ N O - Emacs made simple
;; Copyright (C) 2020 - N Λ N O developers
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.
;; ---------------------------------------------------------------------
;; font face

(add-to-list 'load-path "~/.emacs.d/custom/")

(require 'package) ;; Emacs builtin

;; set package.el repositories
(setq package-archives
      '(
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ))

;; initialize built-in package management
(package-initialize)

;; update packages list if we are on a new install
(unless package-archive-contents
  (package-refresh-contents))

;; a list of pkgs to programmatically install
;; ensure installed via package.el
(setq my-package-list '(use-package))

;; smex
(use-package smex
  :ensure t)
(require 'smex) ;


;; programmatically install/ensure installed
;; pkgs in your personal list
(dolist (package my-package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; now you can
;; (use-package pkgname) etc as per
;; use-package example docs


;; Path to nano emacs modules (mandatory)
(add-to-list 'load-path "~/.emacs.d/nano-emacs")
(add-to-list 'load-path ".")

(use-package counsel
  :ensure t
  :after ivy
  :config (counsel-mode))




(use-package ivy
  :defer 0.1
  :ensure t
  :diminish
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

(use-package page-break-lines
  :defer 0.1
  :ensure t
  :config
  (global-page-break-lines-mode)

  )

(use-package ivy-rich
  :after ivy
  :ensure t
  :custom
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :after ivy
  :ensure t
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

;; Window layout (optional)
(require 'nano-layout)

;; Theming Command line options (this will cancel warning messages)
(add-to-list 'command-switch-alist '("-dark"   . (lambda (args))))
(add-to-list 'command-switch-alist '("-light"  . (lambda (args))))
(add-to-list 'command-switch-alist '("-default"  . (lambda (args))))

(cond
 ((member "-default" command-line-args) t)
 ((member "-dark" command-line-args) (require 'nano-theme-dark))
 (t (require 'nano-theme-dark)))

;; Customize support for 'emacs -q' (Optional)
;; You can enable customizations by creating the nano-custom.el file
;; with e.g. `touch nano-custom.el` in the folder containing this file.
(let* ((this-file  (or load-file-name (buffer-file-name)))
       (this-dir  (file-name-directory this-file))
       (custom-path  (concat this-dir "nano-custom.el")))
  (when (and (eq nil user-init-file)
             (eq nil custom-file)
             (file-exists-p custom-path))
    (setq user-init-file this-file)
    (setq custom-file custom-path)
    (load custom-file)))

;; Theme
(require 'nano-faces)
(nano-faces)

(require 'nano-theme)
(nano-theme)

;; Nano default settings (optional)
(require 'nano-defaults)

;; Nano session saving (optional)
(require 'nano-session)

;; Nano header & mode lines (optional)
(require 'nano-modeline)

;; Nano key bindings modification (optional)
(require 'nano-bindings)

;; Nano counsel configuration (optional)
;; Needs "counsel" package to be installed (M-x: package-install)
(require 'nano-counsel)

(require 'nano-base-colors)

;;(require 'nano-command)
;;(nano-command)

;; Welcome message (optional)
(let ((inhibit-message t))
  (message "Welcome to GNU Emacs / N Λ N O edition")
  (message (format "Initialization time: %s" (emacs-init-time))))

;; Splash and help (optional)
(add-to-list 'command-switch-alist '("-no-splash" . (lambda (args))))
(unless (member "-no-splash" command-line-args)
  (require 'nano-help)
  (require 'nano-splash))

(provide 'nano)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eshell-output-filter-functions
   '(eshell-handle-ansi-color eshell-handle-control-codes eshell-handle-ansi-color eshell-watch-for-password-prompt))
 '(mini-frame-show-parameters '((top . 130) (width . 0.5) (left . 0.5)))
 '(package-selected-packages
   '(company-restclient ob-restclient comapny-restclient rest-client rspec-mode rubocop rustic rust-mode projectile exec-path-from-shell projectile-rails highlight-parentheses flycheck vimish-fold dumb-jump web-mode company-web auto-complete company-box corral mini-frame multiple-cursors zoom persp-projectile counsel-projectile perspective lsp-treemacs lsp-ivy treemacs company-lsp lsp-ui avy ibuffer-vc highlight-indent-guides docker goto-line-preview visual-regexp switch-window ripgrep rg which-key undo-tree ag hydra minimap sublimity try magit ivy-rich counsel use-package))
 '(zoom-size 'size-callback))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((((background dark)) (:background "#3B4252")) (t (:background "#D3D3D3222222"))) nil :group))

(when(display-graphic-p)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1))

(global-linum-mode)


;; custom packages should start here
(use-package try
  :ensure t)

;; sublimity mode
(use-package minimap
  :ensure t
  :config
;';  (minimap-mode)
  ;; customize the minimap
  (custom-set-faces
   '(minimap-active-region-background
     ((((background dark)) (:background "#3B4252"))
      (t (:background "#D3D3D3222222")))
     "Face for the active region in the minimap.
By default, this is only a different background color."
     :group 'minimap)
   )
   (setq minimap-window-location 'right)

  )



;; Added backup folders to saves
(setq backup-directory-alist `(("." . "~/.saves")))

;; Disable that annoying sound that windows beep!
(setq visible-bell 1)
(add-hook 'before-save-hook 'my-prog-nuke-trailing-whitespace)

(defun my-prog-nuke-trailing-whitespace ()
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))



(setq ring-bell-function 'ignore)

(require 'ido)
(ido-mode t)

;; change user name and email of your preferences
(setq user-full-name "Ye Lin Aung")
(setq user-mail-address "hello.yelinaung@gmail.com")

;; marking text and respect clipboards
(delete-selection-mode t)
(transient-mark-mode t)

;; show empty lines
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; 2 space tabs -_-
(setq tab-width 2
      indent-tabs-mode nil)

;; a good yes or no than y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; projectile
(use-package projectile
  :defer t
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-global-mode)
  ;;  (setq projectile-completion-system 'helm)
  )

;; Counsel Swiper
(use-package hydra
  :ensure t
  )

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  )
(use-package swiper
  :ensure t
  :load-path "~/.emacs.d/vendor/swiper/"
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))




(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(use-package ag
  :defer t
  :ensure t
  )

(use-package undo-tree
  :ensure t
  :bind
  ("C-x u" . undo-tree-visualizer-diff)
  :config
  (global-undo-tree-mode)
  )

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  )

(use-package rg
  :ensure t)

(use-package ripgrep
  :demand
  :ensure t)

(use-package magit
  :defer t
  :ensure t
  )

(use-package switch-window
  :ensure t
  :config
  (global-set-key (kbd "C-x o") 'switch-window)
  (global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
  (global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
  (global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
  (global-set-key (kbd "C-x 0") 'switch-window-then-delete)

  (global-set-key (kbd "C-x 4 d") 'switch-window-then-dired)
  (global-set-key (kbd "C-x 4 f") 'switch-window-then-find-file)
  (global-set-key (kbd "C-x 4 m") 'switch-window-then-compose-mail)
  (global-set-key (kbd "C-x 4 r") 'switch-window-then-find-file-read-only)
  (global-set-key (kbd "C-x 4 C-f") 'switch-window-then-find-file)
  (global-set-key (kbd "C-x 4 C-o") 'switch-window-then-display-buffer)

  (global-set-key (kbd "C-x 4 0") 'switch-window-then-kill-buffer)
  )

(use-package visual-regexp
  :ensure t
  :config
  (define-key global-map (kbd "C-c i") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  (define-key global-map (kbd "C-c m") 'vr/mc-mark)
  )

(use-package goto-line-preview
  :ensure t
  :defer t
  :config
  )
(global-set-key (kbd "M-g M-g")  'goto-line-preview)



(use-package docker
  :ensure t
  :defer t
  :bind ("C-c d" . docker))

(use-package highlight-indent-guides
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character)
  )

;; multi term
(defalias 'ff 'find-file)
(defalias 'ffo 'find-file-other-window)

;; New Eshell
(global-set-key (kbd "C-c u $")
                (defun eshell-new()
                  "Open a new instance of eshell."
                  (interactive)
                  (eshell 'N))
                )

;; ibuffer
(use-package ibuffer-vc
  :ensure t)

;; avy
(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-;") 'avy-goto-char))


;; lsp mode

(use-package lsp-mode
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  :defer t
  :init
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq gc-cons-threshold 100000000)
  (setq lsp-idle-delay 0.500)
  (setq lsp-keymap-prefix "C-c l")

  ;;  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
  ;;         (prog-mode . lsp)
  ;; if you want which-key integration
  ;;         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; optionally
(use-package lsp-ui
  :defer t
  :ensure t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

;;(use-package company-lsp
;;  :defer t
;;  :ensure t
;;  :commands company-lsp)

;; if you are ivy user
(use-package treemacs
  :defer t
  :ensure t)



(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)

(use-package perspective
  :ensure t
  :config
  (persp-mode)
  )

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode)
  )
(use-package persp-projectile
  :after (perspective)
  :ensure t
  :bind
  )
(global-set-key (kbd "C-x b") 'persp-ivy-switch-buffer)


(use-package zoom
  :ensure t
  :config
  (zoom-mode t)
  (defun size-callback ()
    (cond ((> (frame-pixel-width) 1280) '(0.8 . 0.75))
          (t                            '(0.8 . 0.5))))

  (custom-set-variables
   '(zoom-size 'size-callback))
  (global-set-key (kbd "C-x +") 'zoom)
  )

(use-package multiple-cursors
  :ensure t
  )
(global-set-key (kbd "C-c u m") 'mc/edit-lines)

(use-package mini-frame
  :ensure t
  :config (custom-set-variables
           '(mini-frame-show-parameters
             '((top . 130)
               (width . 0.5)
               (left . 0.5)))))
;;(mini-frame-mode)


(use-package hydra
  :ensure t
  :config
  ;;(defhydra hydra-zoom (global-map "<f2>")
  ;;  "zoom"
  ;;  ("g" text-scale-increase "in")
  ;;  ("l" text-scale-decrease "out"))
  (defhydra hydra-flycheck (global-map "<f2>")
    "flycheck"
    ("n" flycheck-next-error)
    ("p" flycheck-previous-error))
  )

(use-package corral
  :ensure t
  :config
  (defhydra hydra-corral (:columns 4)
    "Corral"
    ("(" corral-parentheses-backward "Back")
    (")" corral-parentheses-forward "Forward")
    ("[" corral-brackets-backward "Back")
    ("]" corral-brackets-forward "Forward")
    ("{" corral-braces-backward "Back")
    ("}" corral-braces-forward "Forward")
    ("." hydra-repeat "Repeat"))
  (global-set-key (kbd "C-c n") #'hydra-corral/body))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))



;; langs
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  )
(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  )

(use-package company-web
  :ensure t
  :config
  )

;; web mode
(use-package web-mode
  :defer t
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  )

;; dumb-jump
(use-package dumb-jump
  :defer t
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g b" . dumb-jump-back)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
  :ensure)

;; vimimsh fold
(use-package vimish-fold
  :ensure t
  :config
  (vimish-fold-global-mode 1)
  (global-set-key (kbd "C-c v f") #'vimish-fold)
  (global-set-key (kbd "C-c v v") #'vimish-fold-delete))

;; fly check
(use-package flycheck
  :defer t
  :ensure t
  :init (global-flycheck-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; highlight parens
(use-package highlight-parentheses
  :defer t
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'highlight-parentheses-mode)
  )


;; Rails
(use-package projectile-rails
  :ensure t
  :config
  (projectile-rails-global-mode)
  (define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)
  )

;; Rust
(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm
  (setq-local buffer-save-without-query t))


(use-package ivy-rich
  :ensure t
  :after ivy
  :config (ivy-rich-mode 1))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GEM_PATH"))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq-default flycheck-disabled-checkers '(ruby-ruby-lint ruby-rubocop ruby-reek))

(require 'rubocop)
(use-package rubocop
  :ensure t
  :after ruby-mode
)
(setq rubocop-autocorrect-on-save t)

(add-hook 'ruby-mode-hook 'rubocop-mode)

;;rest-client
(use-package restclient
  :ensure t
  )

(use-package company-restclient
  :ensure t
  )

(use-package ob-restclient
  :ensure t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((restclient . t)))
(add-to-list 'company-backends 'company-restclient)

;;(setq flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop")
;;(setq flycheck-ruby-rubylint-executable "~/.rbenv/shims/ruby-lint")

;;(add-hook 'ruby-mode-hook
;;          (lambda ()
;;            (setq-local flycheck-command-wrapper-function
;;                        (lambda (command) (append '("bundle" "exec") command)))))


(use-package rspec-mode
  :ensure t)

(require 'rspec-mode)

(global-auto-revert-mode)

(add-hook 'eshell-mode-hook
          (defun chunyang-eshell-mode-setup ()
            (remove-hook 'eshell-output-filter-functions
                         'eshell-postoutput-scroll-to-bottom)))

(set-face-attribute 'default nil :height 130)
