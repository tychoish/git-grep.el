=================================================
``git-grep.el`` -- Git Grep Integration for Emacs
=================================================

Overview
--------

``git-grep.el`` provides integration with the ``git grep`` command inside of
Emacs' ``find-grep`` for searching the content of files within a directory or
repository.

Configuration
-------------

Use the following ``use-package`` declaration to configure the ``git-grep``
integration: :: 

  (use-package git-grep
    :commands (git-grep git-grep-repo)
    :bind (("C-c g g" . git-grep)
           ("C-c g r" . git-grep-repo)))

Use these bindings, or call the functions directly to use ``git grep``.

See Also
--------

- `Native Emacs Find Grep <https://www.gnu.org/software/emacs/manual/html_node/emacs/Grep-Searching.html>`_
- `ripgrep.el <https://github.com/nlamirault/ripgrep.el>`_ 
