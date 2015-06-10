;;; init.el --- Prelude's configuration entry point.
;;
;; Copyright (c) 2011 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: http://batsov.com/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file simply sets up the default load path and requires
;; the various modules defined within Emacs Prelude.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(defvar current-user
      (getenv
       (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(message "Prelude is powering up... Be patient, Master %s!" current-user)

(when (version< emacs-version "24.1")
  (error "Prelude requires at least GNU Emacs 24.1, but you're running %s" emacs-version))

;; Always load newest byte code
(setq load-prefer-newer t)

(defvar prelude-dir (file-name-directory load-file-name)
  "The root dir of the Emacs Prelude distribution.")
(defvar prelude-core-dir (expand-file-name "core" prelude-dir)
  "The home of Prelude's core functionality.")
(defvar prelude-modules-dir (expand-file-name  "modules" prelude-dir)
  "This directory houses all of the built-in Prelude modules.")
(defvar prelude-personal-dir (expand-file-name "personal" prelude-dir)
  "This directory is for your personal configuration.

Users of Emacs Prelude are encouraged to keep their personal configuration
changes in this directory.  All Emacs Lisp files there are loaded automatically
by Prelude.")
(defvar prelude-personal-preload-dir (expand-file-name "preload" prelude-personal-dir)
  "This directory is for your personal configuration, that you want loaded before Prelude.")
(defvar prelude-vendor-dir (expand-file-name "vendor" prelude-dir)
  "This directory houses packages that are not yet available in ELPA (or MELPA).")
(defvar prelude-savefile-dir (expand-file-name "savefile" prelude-dir)
  "This folder stores all the automatically generated save/history-files.")
(defvar prelude-modules-file (expand-file-name "prelude-modules.el" prelude-dir)
  "This files contains a list of modules that will be loaded by Prelude.")

(unless (file-exists-p prelude-savefile-dir)
  (make-directory prelude-savefile-dir))

(defun prelude-add-subfolders-to-load-path (parent-dir)
 "Add all level PARENT-DIR subdirs to the `load-path'."
 (dolist (f (directory-files parent-dir))
   (let ((name (expand-file-name f parent-dir)))
     (when (and (file-directory-p name)
                (not (string-prefix-p "." f)))
       (add-to-list 'load-path name)
       (prelude-add-subfolders-to-load-path name)))))

;; add Prelude's directories to Emacs's `load-path'
(add-to-list 'load-path prelude-core-dir)
(add-to-list 'load-path prelude-modules-dir)
(add-to-list 'load-path prelude-vendor-dir)
(prelude-add-subfolders-to-load-path prelude-vendor-dir)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; preload the personal settings from `prelude-personal-preload-dir'
(when (file-exists-p prelude-personal-preload-dir)
  (message "Loading personal configuration files in %s..." prelude-personal-preload-dir)
  (mapc 'load (directory-files prelude-personal-preload-dir 't "^[^#].*el$")))

(message "Loading Prelude's core...")

;; the core stuff
(require 'prelude-packages)
(require 'prelude-custom)  ;; Needs to be loaded before core, editor and ui
(require 'prelude-ui)
(require 'prelude-core)
(require 'prelude-mode)
(require 'prelude-editor)
(require 'prelude-global-keybindings)

;; OSX specific settings
(when (eq system-type 'darwin)
  (require 'prelude-osx))

(message "Loading Prelude's modules...")

;; the modules
(when (file-exists-p prelude-modules-file)
  (load prelude-modules-file))

;; config changes made through the customize UI will be store here
(setq custom-file (expand-file-name "custom.el" prelude-personal-dir))

;; load the personal settings (this includes `custom-file')
(when (file-exists-p prelude-personal-dir)
  (message "Loading personal configuration files in %s..." prelude-personal-dir)
  (mapc 'load (directory-files prelude-personal-dir 't "^[^#].*el$")))

(message "Prelude is ready to do thy bidding, Master %s!" current-user)

(prelude-eval-after-init
 ;; greet the use with some useful tip
 (run-at-time 5 nil 'prelude-tip-of-the-day))

;; http://batsov.com/prelude/

(load-theme 'deeper-blue t)

(require 'evil)
(require 'evil-leader)
(global-evil-leader-mode)
;; (evil-leader-mode)
(evil-mode)

(scroll-bar-mode -1)

;; (desktop-save-mode 1)
;; https://github.com/knu/elscreen
;; http://stackoverflow.com/questions/803812/emacs-reopen-buffers-from-last-session-on-startup
(defvar emacs-configuration-directory
  "~/.emacs.d/"
  "The directory where the Emacs configuration files are stored.")

(defvar elscreen-tab-configuration-store-filename
  (concat emacs-configuration-directory ".elscreen")
  "The file where the elscreen tab configuration is stored.")

(defun elscreen-store ()
  "Store the elscreen tab configuration."
  (interactive)
  (if (desktop-save emacs-configuration-directory)
      (with-temp-file elscreen-tab-configuration-store-filename
        (insert (prin1-to-string (elscreen-get-screen-to-name-alist))))))

(defun elscreen-restore ()
  "Restore the elscreen tab configuration."
  (interactive)
  (if (and
       (file-exists-p elscreen-tab-configuration-store-filename)
       (desktop-read))
      (let ((screens (reverse
                      (read
                       (with-temp-buffer
                         (insert-file-contents elscreen-tab-configuration-store-filename)
                         (buffer-string))))))
        (while screens
          (setq screen (car (car screens)))
          (setq buffers (split-string (cdr (car screens)) ":"))
          (if (eq screen 0)
              (switch-to-buffer (car buffers))
            (elscreen-find-and-goto-by-buffer (car buffers) t t))
          (while (cdr buffers)
            (switch-to-buffer-other-window (car (cdr buffers)))
            (setq buffers (cdr buffers)))
          (setq screens (cdr screens))))))

(elscreen-start)
(setq elscreen-prefix-key "\C-t")

(push #'elscreen-store kill-emacs-hook)
(elscreen-restore)

;; (setq elscreen-display-tab 3)
(setq elscreen-display-tab nil)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)

(require 'paredit)
(paredit-mode)
;; (add-hook M-mode-hook 'enable-paredit-mode)
;; (eval-after-load 'paredit
;;  '(progn ...redefine keys, &c....))

;; (evil-leader/set-leader "<SPC>")
;; M-s to splice, see paredit.el
;; evil-paredit.e
(eval-after-load 'paredit
  '(progn
     (message "evil-leader enabled!!!")
     (evil-leader/set-leader ",")
     (evil-leader/set-key
       "(" 'paredit-open-round
       "[" 'paredit-open-square
       "{" 'paredit-open-curly
       "<" 'paredit-open-angled
       "\"" 'paredit-doublequote
       ;; FIXME other file include clj worked,
       ;;       can't work after open new el!!!
       "n" 'elscreen-create
       "q" 'elscreen-kill
       "c" 'elscreen-clone
       "f" 'elscreen-next
       "b" 'elscreen-previous)))

;; http://stackoverflow.com/questions/5377960/whats-the-best-practice-to-git-clone-into-an-existing-folder

;;; init.el ends here
