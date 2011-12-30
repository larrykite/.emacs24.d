;-*- coding: utf-8 -*-
;; Shortcuts for ERGOEMACS_KEYBOARD_LAYOUT=colemak
;; Keyboard Layout: Colemak
;; Contributor: Ivan Haralamov ( postivan gmail.com ), “vockets”, Graham Poulter.
;; Creation date: 2009

;;; --------------------------------------------------
;;; CURSOR MOVEMENTS

;; Single char cursor movement
(defconst ergoemacs-backward-char-key			(kbd "M-n")) 
(defconst ergoemacs-forward-char-key			(kbd "M-i"))  
(defconst ergoemacs-previous-line-key			(kbd "M-u"))
(defconst ergoemacs-next-line-key			(kbd "M-e"))

;; Move by word
(defconst ergoemacs-backward-word-key			(kbd "M-l")) ; downcase word OK   
(defconst ergoemacs-forward-word-key			(kbd "M-y")) ; unassigned OK

;; Move by paragraph
(defconst ergoemacs-backward-paragraph-key		(kbd "M-L")) ; translated downcase word OK
(defconst ergoemacs-forward-paragraph-key		(kbd "M-Y")) ; translated yank-pop OK

;; Move to beginning/ending of line
(defconst ergoemacs-move-beginning-of-line-key		(kbd "M-h")) ; help
(defconst ergoemacs-move-end-of-line-key		(kbd "M-H")) ; help

;; Move by screen (page up/down)
(defconst ergoemacs-scroll-down-key			(kbd "M-U")) ; kill-start-of-line
(defconst ergoemacs-scroll-up-key			(kbd "M-E")) ; kill-line

;; Move to beginning/ending of file
(defconst ergoemacs-beginning-of-buffer-key		(kbd "M-N")) ; backward-kill-word (also mapped to <C-backspace>)
(defconst ergoemacs-end-of-buffer-key			(kbd "M-I")) ; kill-word (also mapped to M-d, <C-delete>

;; isearch
(defconst ergoemacs-isearch-forward-key			(kbd "M-o")) ; facemenu-keymap 
(defconst ergoemacs-isearch-backward-key		(kbd "M-O")) ;

(defconst ergoemacs-recenter-key			(kbd "M-;")) ; win-swap (doesn't work)

;;; MAJOR EDITING COMMANDS

;; Delete previous/next char.
(defconst ergoemacs-delete-backward-char-key		(kbd "M-s")) ; prefix-command OK
(defconst ergoemacs-delete-char-key			(kbd "M-t")) ; transpose-words

; Delete previous/next word.
(defconst ergoemacs-backward-kill-word-key		(kbd "M-f")) ; forward-word
(defconst ergoemacs-kill-word-key			(kbd "M-p")) ; undefined

; Copy Cut Paste, Paste previous
(defconst ergoemacs-kill-region-key			(kbd "M-x")) ; smex
(defconst ergoemacs-kill-ring-save-key			(kbd "M-c")) ; capitalize-word
(defconst ergoemacs-yank-key				(kbd "M-v")) ; scroll-down-command
(defconst ergoemacs-yank-pop-key			(kbd "M-V"))
(defconst ergoemacs-copy-all-key			(kbd "M-C")) ; capitalize-word
(defconst ergoemacs-cut-all-key				(kbd "M-X")) ; anonymous function in init.el (smex major mode)

;; undo and redo
(defconst ergoemacs-redo-key				(kbd "M-Z")) ; zap-to-char
(defconst ergoemacs-undo-key				(kbd "M-z")) ; zap-to-char

; Kill line
(defconst ergoemacs-kill-line-key			(kbd "M-d")) ; kill-word
(defconst ergoemacs-kill-line-backward-key		(kbd "M-D")) ; kill-word

;;; Textual Transformation

(defconst ergoemacs-mark-paragraph-key			(kbd "M-S-SPC")) ; set-mark-command
(defconst ergoemacs-shrink-whitespaces-key		(kbd "M-w")) ; kill-ring-save
(defconst ergoemacs-comment-dwim-key			(kbd "M-'")) ; abbrev-prefix-mark
(defconst ergoemacs-toggle-letter-case-key		(kbd "M-/")) ; dabbrev-expand

; keyword completion, because Alt+Tab is used by OS
(defconst ergoemacs-call-keyword-completion-key		(kbd "M-g")) ; goto-line

; Hard-wrap/un-hard-wrap paragraph
(defconst ergoemacs-compact-uncompact-block-key		(kbd "M-q")) ; fill-paragraph

;;; EMACS'S SPECIAL COMMANDS

; Cancel
(defconst ergoemacs-keyboard-quit-key			(kbd "M-k")) ; kill-sentence

; Mark point.
(defconst ergoemacs-set-mark-command-key		(kbd "M-SPC")) ; set-mark-command (instead gives app menu)

(defconst ergoemacs-execute-extended-command-key	(kbd "M-a")) ; backward-sentence
(defconst ergoemacs-shell-command-key			(kbd "M-A")) ; backward-sentence

;;; WINDOW SPLITING
(defconst ergoemacs-move-cursor-next-pane-key		(kbd "M-r")) ; replace-string
(defconst ergoemacs-move-cursor-previous-pane-key	(kbd "M-R")) ; replace-string

;;; --------------------------------------------------
;;; OTHER SHORTCUTS

(defconst ergoemacs-switch-to-previous-frame-key        (kbd "M-~")) ; not-modified
(defconst ergoemacs-switch-to-next-frame-key            (kbd "M-`")) ; tmm-menubar

(defconst ergoemacs-query-replace-key                   (kbd "M-5")) ; digit-argument
(defconst ergoemacs-query-replace-regexp-key            (kbd "M-%")) ; query-replace

(defconst ergoemacs-delete-other-windows-key            (kbd "M-3")) ; digit-argument
(defconst ergoemacs-delete-window-key                   (kbd "M-0")) ; digit-argument

(defconst ergoemacs-split-window-vertically-key         (kbd "M-4")) ; digit-argument
(defconst ergoemacs-split-window-horizontally-key       (kbd "M-$")) ; ispell-word

(defconst ergoemacs-extend-selection-key                (kbd "M-8")) ; 
(defconst ergoemacs-select-text-in-quote-key            (kbd "M-*"))
