(setq lmk-emacs-init-file load-file-name)
(setq lmk-emacs-config-dir
      (file-name-directory lmk-emacs-init-file))
(setq user-emacs-directory lmk-emacs-config-dir)
(setq lmk-elisp-dir (expand-file-name "elisp" lmk-emacs-config-dir))
(setq lmk-elisp-external-dir
      (expand-file-name "external" lmk-elisp-dir))
;(setq lmk-init-dir
;      (expand-file-name "init.d" lmk-emacs-config-dir))
(setq lmk-secrets-file "~/.emacs24.d/lmksecrets.el")
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))

(require 'cl)				; common lisp goodies, loop
(require 'electric)
(set-face-font 'default "Envy Code R-13")
(add-to-list 'default-frame-alist '(alpha . 100))

;; M-x shell is a nice shell interface to use, let's make it colorful.  If
;; you need a terminal emulator rather than just a shell, consider M-x term
;; instead.
;(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

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

;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-unix t))
(defun dos-file ()
  "Change the current buffer to Latin 1 with DOS line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-dos t))
(defun mac-file ()
  "Change the current buffer to Latin 1 with Mac line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-mac t))


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
                                        ;(require 'regexpl)
(require 'color-theme)
(require 'color-theme-solarized)
(eval-after-load "color-theme"
  '(color-theme-solarized-light))

;; Indicate that this file has been read at least once
(setq first-time nil)
(set-frame-height (selected-frame) 52)
(set-frame-width (selected-frame) 115)

;;
;; Defined Functions
;;
;;
;;
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file  modified
(defun rename-file-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                     (buffer-file-name)))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; If the file isn't saved yet, skip the file rename, but still update the
  ;; buffer name and visited file.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil))
    (message "Renamed to %s." new-name)))

(setq
 time-stamp-active t          ; do enable time-stamps
 time-stamp-line-limit 10     ; check first 10 buffer lines for Time-stamp: <>
 time-stamp-format "Last changed %02d-%02m-%04y %02H:%02M:%02S by %L, %u") ; date format
(add-hook 'write-file-hooks 'time-stamp) ; update when saving

;; Move current line up or down with M-up or M-down
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (let ((col (current-column))
	start
	end)
    (beginning-of-line)
    (setq start (point))
    (end-of-line)
    (forward-char)
    (setq end (point))
    (let ((line-text (delete-and-extract-region start end)))
      (forward-line n)
      (insert line-text)
      ;; restore point to original column in moved line
      (forward-line -1)
      (forward-char col))))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(defun switch-kill ()
  "Switch buffers and kill others."
  (interactive)
  (other-window 1)
  (delete-other-windows))


;; ----------------------------------------------------------------------
;;     Original yic-buffer.el
;;     From: choo@cs.yale.edu (young-il choo)
;;     Date: 7 Aug 90 23:39:19 GMT
;;
;;     Modified
;; ----------------------------------------------------------------------

(defun yic-ignore (str)
  (or
   ;;buffers I don't want to switch to
                                        ;  (string-match "\\*Buffer List\\*" str)
   (string-match "^TAGS" str)
                                        ;   (string-match "^\\*Messages\\*$" str)
   (string-match "^\\*Completions\\*$" str)
   (string-match "^ " str)

   ;;Test to see if the windw is visible on an existing visible frame.
   ;;Because I can always ALT-TAB to that visible frame, I never want to
   ;;Ctrl-TAB to that buffer in the current frame.  That would cause
   ;;a duplicate top-level buffer inside two frames.
   (memq str
         (mapcar
          (lambda (x)
            (buffer-name
             (window-buffer
              (frame-selected-window x))))
          (visible-frame-list)))
   ))

(defun yic-next (ls)
  "Switch to next buffer in ls skipping unwanted ones."
  (let* ((ptr ls)
         bf bn go
         )
    (while (and ptr (null go))
      (setq bf (car ptr)  bn (buffer-name bf))
      (if (null (yic-ignore bn))        ;skip over
	  (setq go bf)
        (setq ptr (cdr ptr))
        )
      )
    (if go
        (switch-to-buffer go))))

(defun yic-prev-buffer ()
  "Switch to previous buffer in current window."
  (interactive)
  (yic-next (reverse (buffer-list))))

(defun yic-next-buffer ()
  1 "Switch to the other buffer (2nd in list-buffer) in current window."
  (interactive)
  (bury-buffer (current-buffer))
  (yic-next (buffer-list)))
;;end of yic buffer-switching methods

;; Count words in buffer
(defun count-words-buffer ()
  "Count the number of words in current the buffer
print a message in the minibuffer with the result."
  (interactive)
  (save-excursion
    (let ((count 0))
      (goto-char (point-min))
      (while (< (point) (point-max))
	(forward-word 1)
	(setq count (1+ count)))
      (message "buffer contains %d words." count))))
