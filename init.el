(require 'package)
;(add-to-list 'package-archives
;             '("marmalade" . "https://marmalade-repo.org/packages/"))
;(add-to-list 'package-archives
;             '("melpa" . "http://melpa.org/packages/"))

;package source
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)



(defvar my-packages '(better-defaults
                      elpy ;; add the elpy package
                      flycheck ;; add the flycheck package
                      py-autopep8
                      markdown-mode
                      paredit
                      neotree
                      dracula-theme
                      sublime-themes
                      auto-complete
                      cider))

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
(load-theme 'dracula t)
;(load-theme 'granger t)


;; Preeeetty font in Emacs 24/Ubuntu
;(set-default-font "Source Code Pro Medium")


;; init.el ends here

;;lein install location
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))



;;ocaml
(load "/Users/heng/.opam/system/share/emacs/site-lisp/tuareg-site-file")

(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var"
                                                     "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)))
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line


;;; Install fsharp-mode
(unless (package-installed-p 'fsharp-mode)
  (package-install 'fsharp-mode))

(require 'fsharp-mode)

(setq inferior-fsharp-program "/Library/Frameworks/Mono.framework/Versions/Current/Commands/fsharpi --readline-")
(setq fsharp-compiler "/Library/Frameworks/Mono.framework/Versions/Current/Commands/fsharpc")

