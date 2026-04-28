quick-back.el
========

A simple mark-and-jump utility for Emacs.

You can jump back to a marked position at any time.

# Installation

Clone this repository to your packages directory.

```
$ cd ~/.emacs.d/elisp
$ git clone https://github.com/ketanaka/quick-back.git
```

Add the following to your `init.el`.

```el
(add-to-list 'load-path "~/.emacs.d/elisp/quick-back/")
(require 'quick-back)
(keymap-global-set "C-M-'" #'quick-back-mark)  ; customize as you like
(keymap-global-set "C-'"   #'quick-back-jump)  ; customize as you like
```

# Usage

1. **mark**

    `Ctrl + Meta + '`

2. **jump**

    `Ctrl + '`

    * Jumping again from the destination returns to the original position.

# Note

For more features, use the built-in Lisp libraries (bookmark.el, register.el).
