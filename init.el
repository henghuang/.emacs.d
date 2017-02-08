(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))


(defvar my-packages '(better-defaults
                      elpy ;; add the elpy package
                      flycheck ;; add the flycheck package
                      py-autopep8
                      markdown-mode
                      paredit
                      neotree
                      dracula-theme
                      sublime-themes
                      auto-complete))

(package-initialize)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup messa
(global-linum-mode t) ;; enable line numbers globall
(ac-config-default)

;; PYTHON  
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Matlab via buit-in octave-mode
(setq auto-mode-alist
      (cons
       '("\\.m$" . octave-mode)
       auto-mode-alist))

;;neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme 'arrow)

;;paredit 
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'python-mode-hook #'enable-paredit-mode)

;;;;;
;;customize theme

;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;(load-theme 'dracula t)
(load-theme 'granger t)

;; Preeeetty font in Emacs 24/Ubuntu
(set-default-font "Source Code Pro Medium")

;; init.el ends here


