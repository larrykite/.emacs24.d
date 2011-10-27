(setq lmk-emacs-init-file load-file-name)
(setq lmk-emacs-config-dir
      (file-name-directory lmk-emacs-init-file))
(setq user-emacs-directory lmk-emacs-config-dir)
(setq lmk-elisp-dir (expand-file-name "elisp" lmk-emacs-config-dir))
(setq lmk-elisp-external-dir
      (expand-file-name "external" lmk-elisp-dir))
(setq lmk-init-dir
      (expand-file-name "init.d" lmk-emacs-config-dir))
(setq lmk-secrets-file "~/.emacs24.d/lmksecrets.el")
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))


(require 'package)
(require 'eieio)

(dolist (project (directory-files lmk-elisp-external-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(require 'gist)
(setq gist-authenticate-function 'gist-basic-authentication)
(when (file-exists-p lmk-secrets-file)
  (load lmk-secrets-file))
(global-set-key (kbd "<f8>") 'gist-region-or-buffer)
;; set up 'custom' system

(setq custom-file (expand-file-name "emacs-customizations.el" lmk-emacs-config-dir))
(load custom-file)

; It seems I need to do this first to make package loading work
(package-initialize) 

(require 'netrc)
(require 'org2blog)
;(setq lmk-netrc-vc
;      (netrc-machine (netrc-parse "~/.netrc") "ubuntu" t))
(setq org2blog/wp-blog-alist
      '(("wordpress"
         :url "http://lawrencekite.com/xmlrpc.php"
         :username "larrykite"
         :tags-as-categories nil)))

(global-set-key (kbd "<f9>") 'org2blog/wp-new-entry)
(global-set-key (kbd "S-<f9>") 'org2blog/wp-post-buffer)
