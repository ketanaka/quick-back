quick-back.el
========

This program support simply mark & jump for Emacs.

You can back to the place that you marked anytime.

# Installation

Clone this repository to your packages directory.

```
$ cd ~/.emacs.d/elisp
$ git clone https://github.com/ketanaka/quick-back.git
```

Add the following in your `init.el`.

```el
(add-to-list 'load-path "~/.emacs.d/elisp/quick-back/")
(require 'quick-back)
(global-set-key (kbd "C-M-'") 'quick-back-mark)     ; customize as you like
(global-set-key (kbd "C-'") 'quick-back-jump)       ; customize as you like
```

# Usage

1. `mark`

    Ctrl + Meta + '

2. `jump`

    Ctrl + '

    * Double jump will return to the original place.

# Note

If you want more function, use the built-in lisp.  (bookmark.el, register.el)
