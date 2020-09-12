;;; git-grep.el --- Search tools using git grep

;; Author: Sam Kleinman
;; Maintainer: tychoish <garen@tychoish.com>
;; Version: 1.0
;; Package-Requires: ((projectile "0.10.0"))
;; Homepage: https://github.com/tychoish/git-grep/
;; Keywords: matching files grep search using git-grep

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; commentary

;;; Code:

(require 'grep)
(require 'projectile)

(defvar git-grep-command "git --no-pager grep --no-color --line-number <C> <R>"
  "The command to run with GIT-GREP.")

(defun git-grep (regexp)
  "Search for REGEXP using `git grep' in the current directory."
  (interactive "sRegexp: ")
  (unless (boundp 'grep-find-template) (grep-compute-defaults))
  (let ((old-command grep-find-template))
    (grep-apply-setting 'grep-find-template git-grep-command)
    (rgrep regexp "*" "")
    (grep-apply-setting 'grep-find-template old-command)))

(defun git-grep-repo ()
  "Search for the given regexp using `git grep' in the current directory."
  (interactive)
  (unless (boundp 'grep-find-template) (grep-compute-defaults))
  (let ((old-command grep-find-template)
	(search-text (buffer-substring-no-properties (region-beginning) (region-end))))
    (message search-text)
    (grep-apply-setting 'grep-find-template "git --no-pager grep --no-color --line-number <C> <R>")
    (rgrep search-text "*" (projectile-project-root))
    (grep-apply-setting 'grep-find-template old-command)))

(defadvice grep-expand-template (around grep-expand-template-with-git-color)
  "Add compatibility for git grep in grep mode."
  (when (and (string-match "^git grep " (ad-get-arg 0))
	     (not (string-match " --color=" (ad-get-arg 0))))
    (ad-set-arg 0 (replace-regexp-in-string
		   "^git grep " "git grep --color=auto " (ad-get-arg 0))))
  ad-do-it)

(provide 'git-grep)
;;; git-grep.el ends here
