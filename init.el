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
                      paredit))

(package-initialize)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup messa
(global-linum-mode t) ;; enable line numbers globall

;; PYTHON  
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;;(elpy-use-ipython)

;;;;;
;;customize theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/moe-theme.el/")
(add-to-list 'load-path "~/.emacs.d/themes/moe-theme.el/")
(require 'moe-theme)
(load-theme 'moe-dark t)
;; init.el ends here


