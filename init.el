
(setq lmk-emacs-init-file load-file-name)
(setq lmk-emacs-config-dir
      (file-name-directory lmk-emacs-init-file))
(setq user-emacs-directory lmk-emacs-config-dir)
(setq lmk-elisp-dir (expand-file-name "elisp" lmk-emacs-config-dir))
(setq lmk-elisp-external-dir
      (expand-file-name "external" lmk-elisp-dir))

(setq lmk-secrets-file "~/.emacs24.d/lmksecrets.el")
(setq lmk-functions-file "~/.emacs24.d/functions.el")
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))

(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(menu)] (lambda ()
                           (interactive)
                           (or (boundp 'smex-cache)
                               (smex-initialize))
                           (global-set-key [(meta x)] 'smex)
                           (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)]
                                                   'smex-major-mode-commands)
                                   (smex-major-mode-commands)))

(global-set-key [(shift menu)] (lambda ()
                                 (interactive)
                                 (or (boundp 'smex-cache)
                                     (smex-initialize))
                                 (global-set-key [(shift meta x)]
                                                 'smex-major-mode-commands)
                                 (smex-major-mode-commands)))

(require 'cl)				; common lisp goodies, loop
(require 'electric)


(add-to-list 'default-frame-alist '(font . "Inconsolata-11"))
;(set-face-font 'default "Inconsolata-10")
;(set-face-font 'default "Anonymous Pro-10")
;(set-face-font 'default "Envy Code R-10")
(add-to-list 'default-frame-alist '(alpha . 100))

;; M-x shell is a nice shell interface to use, let's make it colorful.  If
;; you need a terminal emulator rather than just a shell, consider M-x term
;; instead.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; If you do use M-x term, you will notice there's line mode that acts like
;; emacs buffers, and there's the default char mode that will send your
;; input char-by-char, so that curses application see each of your key
;; strokes.
;;
;; The default way to toggle between them is C-c C-j and C-c C-k, let's
;; better use just one key to do the same.
(require 'term)
(define-key term-raw-map  (kbd "C-'") 'term-line-mode)
(define-key term-mode-map (kbd "C-'") 'term-char-mode)

;; Have C-y act as usual in term-mode, to avoid C-' C-y C-'
;; Well the real default would be C-c C-j C-y C-c C-k.
(define-key term-raw-map  (kbd "C-y") 'term-paste)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C") 'ibuffer)
(global-set-key (kbd "C-x B") 'ibuffer)


(require 'package)
(require 'eieio)

(dolist (project (directory-files lmk-elisp-external-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; (require 'actionscript-mode)
;; (eval-after-load     "actionscript-mode" '(load "actionscript-config"))
;; (add-to-list 'auto-mode-alist '("\\.as\\'" . actionscript-mode))
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'gist)
(setq gist-authenticate-function 'gist-basic-authentication)
(when (file-exists-p lmk-secrets-file)
  (load lmk-secrets-file))
(global-set-key (kbd "<f8>") 'gist-region-or-buffer)

;; set up 'custom' system
(setq custom-file (expand-file-name "emacs-customizations.el" lmk-emacs-config-dir))
(load custom-file)

(package-initialize)

(require 'dired-x)
(require 'dired+)
(require 'netrc)
(require 'org2blog)

(require 'switch-window)
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs24.d/elpa/auto-complete-1.4.20110207/dict")
(ac-config-default)
(global-auto-complete-mode t)

(setq org2blog/wp-blog-alist
      '(("wordpress"
         :url "http://lawrencekite.com/xmlrpc.php"
         :username "larrykite"
         :tags-as-categories nil)))

(global-set-key (kbd "<f9>") 'org2blog/wp-new-entry)
(global-set-key (kbd "S-<f9>") 'org2blog/wp-post-buffer)

(setq c-default-style "stroustrup")
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)
(fset 'yes-or-no-p 'y-or-n-p)

(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
;; return to same line on a scroll back
(setq scroll-preserve-screen-position t)
;; Not display the initial message
(setq inhibit-startup-message t)
;; autosave every 512 keyboard inputs
(setq auto-save-interval 512)
;; autosave after 30 s idle
(setq auto-save-timeout 30)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)
                                        ;(toggle-diredp-find-file-reuse-dir 1)
(setq compile-command "make")
(setq redisplay-dont-pause t)

;; Keyboard
;; ============
;;
(global-set-key [C-tab]     'yic-next-buffer)
(global-set-key [C-S-iso-lefttab]     'yic-prev-buffer)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [C-home] 'beginning-of-buffer)
(global-set-key [C-end] 'end-of-buffer)
(global-set-key (kbd "C-c c") 'comment-region)   ;; make C-c C-c and C-c C-u work
(global-set-key (kbd "C-c C-c") 'comment-region)   ;; make C-c C-c and C-c C-u work
(global-set-key (kbd "C-c u") 'uncomment-region) ;; for comment/uncomment region in all modes
(global-set-key (kbd "C-c C-u") 'uncomment-region) ;; for comment/uncomment region in all modes
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
(global-set-key (kbd "C-z") 'shell)
                                        ;(global-set-key (kbd "C-x p") 'compile)
(global-set-key (kbd "C-x y") 'switch-kill)

;; Meta
(global-set-key "\M- " 'set-mark-command)
(global-set-key "\M-\C-h" 'backward-kill-word)
(global-set-key "\M-\C-r" 'query-replace)
(global-set-key "\M-r" 'replace-string)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-h" 'help-command)

;; Function keys
(global-set-key [f1] 'manual-entry)
(global-set-key [f2] 'info)
(global-set-key [f3] 'repeat-complex-command)
(global-set-key [f4] 'advertised-undo)
(global-set-key [f5] 'eval-current-buffer)
(global-set-key [f6] 'buffer-menu)
(global-set-key [f7] 'other-window)
(global-set-key [f8] 'find-file)
(global-set-key [f9] 'save-buffer)
(global-set-key [f10] 'next-error)
(global-set-key [f11] 'fullscreen)
(global-set-key [f12] 'grep)
(global-set-key [C-f1] 'compile)
(global-set-key [C-f2] 'grep)
(global-set-key [C-f3] 'next-error)
(global-set-key [C-f4] 'previous-error)
(global-set-key [C-f5] 'display-faces)
(global-set-key [C-f8] 'dired)
(global-set-key [C-f10] 'kill-compilation)

;; Keypad bindings
(global-set-key [up] "\C-p")
(global-set-key [down] "\C-n")
(global-set-key [left] "\C-b")
(global-set-key [right] "\C-f")
(global-set-key [home] "\C-a")
(global-set-key [end] "\C-e")
(global-set-key [prior] "\M-v")
(global-set-key [next] "\C-v")
(global-set-key [C-up] "\M-\C-b")
(global-set-key [C-down] "\M-\C-f")
(global-set-key [C-left] "\M-b")
(global-set-key [C-right] "\M-f")
(global-set-key [C-home] "\M-<")
(global-set-key [C-end] "\M->")
(global-set-key [C-prior] "\M-<")
(global-set-key [C-next] "\M->")
(global-set-key "\M-u" 'previous-line)
(global-set-key "\M-e" 'next-line)
(global-set-key "\M-n" 'backward-char)
(global-set-key "\M-i" 'forward-char)
(global-set-key "\M-N" 'backward-kill-word)
(global-set-key "\M-I" 'kill-word)
(global-set-key "\M-U" 'kill-start-of-line)
(global-set-key "\M-E" 'kill-line)
(global-set-key "\C-ct" 'toggle-tool-bar-mode-from-frame)
(global-set-key "\C-cm" 'toggle-menu-bar-mode-from-frame)
(global-set-key "\C-ca" 'anything)
;; disable kill-emacs and minimize window if emacs started in daemon mode
(if (daemonp)
    (global-unset-key (kbd "C-x C-c")))
(if (daemonp)
    (global-unset-key (kbd "C-x C-z")))

;; Mouse
(global-set-key [mouse-3] 'imenu)


;; SavePlace- this puts the cursor in the last place you edited
;; a particular file. This is very useful for large files.
(require 'saveplace)
(setq-default save-place t)
;; replace highlighted text with what I type rather than just
;; inserting at a point
(delete-selection-mode t)

(require 'undo-tree)
(global-undo-tree-mode)
(add-to-list 'custom-theme-load-path "~/.emacs24.d/themes/")

(require 'semantic/sb)
(semantic-mode 1)

;; Indicate that this file has been read at least once
(setq first-time nil)
(set-frame-height (selected-frame) 52)
(set-frame-width (selected-frame) 130)

;; Python Configuration
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(require 'ipython)
(setq py-python-command-args '( "--pylab=qt" "--colors=LightBG"))
(require 'python-mode)
(global-set-key [C-M-end] 'ipython-complete)
(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")

(setq ropemacs-enable-autoimport t)


(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "pycheckers"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init)))
(load-library "flymake-cursor")

(setq python-check-command "pyflakes")

(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.md" . markdown-mode) auto-mode-alist))


(setq pylookup-dir (concat lmk-elisp-external-dir "/pylookup"))
(add-to-list 'load-path pylookup-dir)
(eval-when-compile (require 'pylookup))
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))
;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup"
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

(global-set-key "\C-ch" 'pylookup-lookup)

(require 'yasnippet)
(yas/global-mode 1)

(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")   'buf-move-right)
(setq local-function-key-map (delq '(kp-tab . [9]) local-function-key-map))
(global-set-key (kbd "M-;") 'win-swap)

;(load-theme 'solarized-dark)
(load-theme 'zenburn)
(set-language-environment "utf-8")
(setq inferior-lisp-program "/usr/local/bin/ccl") ; your Lisp system
(add-to-list 'load-path "~/projects/slime/")  ; your SLIME directory

(require 'slime)
(setq slime-net-coding-system 'utf-8-unix)
(slime-setup '(slime-fancy))

(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-pattern nil)

(defun kill-start-of-line ()
  "Kill characters from point to beginning of line"
  (interactive)
  (kill-line 0))

; from http://www.masteringemacs.org/articles/2010/12/22/fixing-mark-commands-transient-mark-mode/
(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))

(defun exchange-point-and-mark-no-activate ()
  "Identical to \\[exchange-point-and-mark] but will not activate the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))
(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)
; end from http://www.masteringemacs.org/articles/2010/12/22/fixing-mark-commands-transient-mark-mode/

(defconst pcmpl-git-commands
  '("add" "bisect" "branch" "checkout" "clone"
    "commit" "diff" "fetch" "grep"
    "init" "log" "merge" "mv" "pull" "push" "rebase"
    "reset" "rm" "show" "status" "tag" )
  "List of `git' commands")

(defvar pcmpl-git-ref-list-cmd "git for-each-ref refs/ --format='%(refname)'"
  "The `git' command to run to get a list of refs")

(defun pcmpl-git-get-refs (type)
  "Return a list of `git' refs filtered by TYPE"
  (with-temp-buffer
    (insert (shell-command-to-string pcmpl-git-ref-list-cmd))
    (goto-char (point-min))
    (let ((ref-list))
      (while (re-search-forward (concat "^refs/" type "/\\(.+\\)$") nil t)
        (add-to-list 'ref-list (match-string 1)))
      ref-list)))

(defun pcomplete/git ()
  "Completion for `git'"
  ;; Completion for the command argument.
  (pcomplete-here* pcmpl-git-commands)
  ;; complete files/dirs forever if the command is `add' or `rm'
  (cond
   ((pcomplete-match (regexp-opt '("add" "rm")) 1)
    (while (pcomplete-here (pcomplete-entries))))
   ;; provide branch completion for the command `checkout'.
   ((pcomplete-match "checkout" 1)
    (pcomplete-here* (pcmpl-git-get-refs "heads")))))



;; Turn on outline minor mode
(add-hook 'emacs-lisp-mode-hook  'outline-minor-mode)

;; Add key bindings for Org-style outline cycling
(add-hook 'outline-minor-mode-hook
  (lambda ()
    (define-key outline-minor-mode-map [(control tab)] 'org-cycle)
    (define-key outline-minor-mode-map [(shift tab)] 'org-global-cycle)))

(global-set-key (kbd "C-`") 'push-mark-no-activate)
(global-set-key (kbd "M-`") 'jump-to-mark)

(load lmk-functions-file)

;; ;; ERGOMACS Config
;; (setenv "ERGOEMACS_KEYBOARD_LAYOUT" "colemak") ; (Ergonomic) Colemak http://colemak.com/
;; ;; load ErgoEmacs keybinding
;; (load "~/.emacs24.d/ergoemacs-keybindings-5.3.9/ergoemacs-mode")
;; ;; turn on minor mode ergoemacs-mode
;; (ergoemacs-mode nil)
;; ;; End ERGOMACS Config
